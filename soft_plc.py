"""
soft plc: the silo fill ladder in python
----------------------------------------
a stand-in for the OpenPLC runtime, for anyone who wants to run the stack
without installing OpenPLC Editor. it serves modbus tcp on the same port with
the same address map as plc/ (see config.py and SETUP.md), and every 20 ms it
runs the same six rungs as plc/pous/programs/main.ld, top to bottom, the way
a plc scan does.

if you have OpenPLC running, you do not need this file.

    python3 soft_plc.py          # or: ./run.sh softplc

the rungs (from the silo lab, exercise 3):

  rung 1  run_light  := (start OR run_light) AND stop
  rung 2  full_light := (level OR full_light) AND prox
  rung 3  motor      := run_light AND (NOT prox
                          OR (full_light AND (mode_a OR ((mode_b OR mode_c) AND release))))
  rung 4  solenoid   := (mode_a OR mode_b) AND run_light AND prox AND NOT full_light
  rung 5  fill_light := solenoid
  rung 6  release    := (start OR release) AND full_light AND prox
"""

import logging
import threading
import time

from pymodbus.datastore import (
    ModbusSequentialDataBlock,
    ModbusServerContext,
    ModbusSlaveContext,
)
from pymodbus.device import ModbusDeviceIdentification
from pymodbus.server import StartTcpServer

import config as cfg

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)-7s [soft-plc] %(message)s")
log = logging.getLogger("soft-plc")

SCAN_S = 0.020   # 20 ms, same as the OpenPLC task interval in plc/project.json

COIL_SIZE = cfg.MX_COIL_OFFSET + 64
HR_SIZE = cfg.MW_REG_OFFSET + 64

store = ModbusSlaveContext(
    co=ModbusSequentialDataBlock(0, [0] * COIL_SIZE),
    hr=ModbusSequentialDataBlock(0, [0] * HR_SIZE),
    di=ModbusSequentialDataBlock(0, [0] * 16),
    ir=ModbusSequentialDataBlock(0, [0] * 16),
)
context = ModbusServerContext(slaves=store, single=True)

FC_COIL = 1   # pymodbus function-code key for the coil table


def _get(addr):
    return bool(store.getValues(FC_COIL, addr, count=1)[0])


def _set(addr, value):
    store.setValues(FC_COIL, addr, [bool(value)])


def mx(name):
    return _get(cfg.MX_COIL_OFFSET + cfg.MX[name])


def q(name):
    return _get(cfg.COIL[name])


def scan_forever():
    release = False   # internal bit, no address (same as the ladder)
    last = None
    while True:
        start, stop = mx("start"), mx("stop")
        prox, level = mx("prox"), mx("level")
        mode_a, mode_b, mode_c = mx("mode_a"), mx("mode_b"), mx("mode_c")

        run_light = (start or q("run_light")) and stop                              # rung 1
        full_light = (level or q("full_light")) and prox                            # rung 2
        motor = run_light and ((not prox) or (full_light and (                      # rung 3
            mode_a or ((mode_b or mode_c) and release))))
        solenoid = (mode_a or mode_b) and run_light and prox and not full_light    # rung 4
        fill_light = solenoid                                                       # rung 5
        release = (start or release) and full_light and prox                        # rung 6

        _set(cfg.COIL["run_light"], run_light)
        _set(cfg.COIL["full_light"], full_light)
        _set(cfg.COIL["motor"], motor)
        _set(cfg.COIL["solenoid"], solenoid)
        _set(cfg.COIL["fill_light"], fill_light)

        state = (run_light, motor, solenoid, full_light)
        if state != last:
            log.debug("run=%s motor=%s solenoid=%s full=%s", *state)
            last = state
        time.sleep(SCAN_S)


if __name__ == "__main__":
    identity = ModbusDeviceIdentification()
    identity.VendorName = "fertilizer_demo"
    identity.ProductName = "soft plc (silo fill ladder)"
    threading.Thread(target=scan_forever, daemon=True).start()
    log.info("soft plc running the silo fill ladder, modbus tcp on 0.0.0.0:%s", cfg.PLC_PORT)
    log.info("outputs: coils 0-4 (%%QX0.0-0.4) | inputs: coils %d-%d (%%MX0.0-0.6) | words: hr %d+ (%%MW)",
             cfg.MX_COIL_OFFSET, cfg.MX_COIL_OFFSET + 6, cfg.MW_REG_OFFSET)
    StartTcpServer(context=context, identity=identity, address=("0.0.0.0", cfg.PLC_PORT))
