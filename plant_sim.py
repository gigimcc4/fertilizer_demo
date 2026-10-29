"""
plant sim: the bagging line around the plc
------------------------------------------
the plc only knows bits. this script plays everything physical around it:

  * the silo of granular fertilizer and the gate under it (the solenoid)
  * the conveyor that brings an empty 50 lb bag under the spout
  * the prox sensor (bag in position) and the level sensor (bag full)
  * a scale that weighs each finished bag and writes the net weight into
    plc memory (%MW0), so the edge poller can read everything from the plc
  * the operator: sets the mode, keeps stop closed, and pulses start

it reads the plc outputs (motor, solenoid) over modbus, moves the line,
and writes the sensor bits back. it works the same against the OpenPLC
runtime or soft_plc.py.

    python3 plant_sim.py            # mode A, continuous
    python3 plant_sim.py --mode b   # fill, then wait for start each bag

scenarios you can fire while it runs (./run.sh event <name>):

    clog      the gate slowly cakes up. flow drops, fill time climbs
    drift     the level sensor drifts and trips early. bags come out short
    silo_low  the refill is late. the silo runs dry and the line starves
    stuck     the level sensor sticks off. the gate stays open and the bag overfills
    clear     maintenance: clean the gate, recalibrate the sensor, refill the silo
    stop      operator presses stop
    start     operator presses start
"""

import argparse
import glob
import logging
import os
import random
import time

from pymodbus.client import ModbusTcpClient

import config as cfg

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)-7s [plant] %(message)s")
log = logging.getLogger("plant")

TICK_S = 0.1

# --- line physics ----------------------------------------------------------
SILO_CAPACITY_LB = 20000.0
SILO_START_PCT = 85.0
REFILL_AT_PCT = 20.0          # a truck is called at this level
REFILL_TO_PCT = 90.0
REFILL_RATE_LB_S = 400.0      # how fast the truck unloads

NOMINAL_FLOW_LB_S = 12.0      # gate wide open, clean
LEVEL_TRIP_LB = 48.9          # sensor set a bit under 50 so in-flight product lands the bag near 50
IN_FLIGHT_S = 0.08            # product already falling when the gate shuts
BAG_CAPACITY_LB = 60.0        # past this it spills
BAG_SPACING_S = 2.5           # motor time between one bag leaving and the next arriving
SCALE_NOISE_LB = 0.05

CLOG_MIN_FACTOR = 0.65        # how bad the gate gets
CLOG_RAMP_S = 180.0
DRIFT_MAX_LB = -2.2           # sensor trips this many lb early at worst
DRIFT_RAMP_S = 120.0
STUCK_S = 20.0


class Plant:
    def __init__(self, mode):
        self.mode = mode
        self.silo_lb = SILO_CAPACITY_LB * SILO_START_PCT / 100
        self.refilling = False
        self.refill_late_s = 0.0

        self.state = "arriving"
        self.travel_s = BAG_SPACING_S
        self.bag_lb = 0.0
        self.fill_s = 0.0
        self.bag_count = 0
        self.trip_lb = LEVEL_TRIP_LB
        self._gate_was_open = False
        self._last_flow = 0.0

        self.clog_s = None        # seconds since clog began, None = clean
        self.drift_s = None
        self.stuck_s = None

        self.pending_start_pulse = 1.0   # pulse start on boot
        self.stop_closed = True

    # --- scenarios ---------------------------------------------------------
    def flow_factor(self):
        if self.clog_s is None:
            return 1.0
        frac = min(self.clog_s / CLOG_RAMP_S, 1.0)
        return 1.0 - (1.0 - CLOG_MIN_FACTOR) * frac

    def sensor_offset(self):
        if self.drift_s is None:
            return 0.0
        return DRIFT_MAX_LB * min(self.drift_s / DRIFT_RAMP_S, 1.0)

    def apply_event(self, name):
        if name == "clog":
            self.clog_s = 0.0
            log.warning("EVENT clog: gate starting to cake up, flow will drop over ~3 min")
        elif name == "drift":
            self.drift_s = 0.0
            log.warning("EVENT drift: level sensor drifting, bags will start coming out short")
        elif name == "silo_low":
            self.silo_lb = min(self.silo_lb, SILO_CAPACITY_LB * (REFILL_AT_PCT + 3) / 100)
            self.refill_late_s = 90.0
            log.warning("EVENT silo_low: silo near the refill point and the truck is ~90 s late")
        elif name == "stuck":
            self.stuck_s = 0.0
            log.warning("EVENT stuck: level sensor stuck off for %.0f s, gate will stay open", STUCK_S)
        elif name == "clear":
            self.clog_s = self.drift_s = self.stuck_s = None
            self.refill_late_s = 0.0
            log.warning("EVENT clear: gate cleaned, sensor recalibrated, refill on time")
        elif name == "stop":
            self.stop_closed = False
            log.warning("EVENT stop: operator pressed stop")
        elif name == "start":
            self.stop_closed = True
            self.pending_start_pulse = 1.0
            log.warning("EVENT start: operator pressed start")
        else:
            log.error("unknown event '%s'", name)

    def check_event_files(self):
        for path in glob.glob(os.path.join(cfg.DATA_DIR, "event_*.flag")):
            name = os.path.basename(path)[len("event_"):-len(".flag")]
            try:
                os.remove(path)
            except OSError:
                pass
            self.apply_event(name)

    # --- one tick ----------------------------------------------------------
    def step(self, motor, solenoid, dt):
        for attr in ("clog_s", "drift_s"):
            if getattr(self, attr) is not None:
                setattr(self, attr, getattr(self, attr) + dt)
        if self.stuck_s is not None:
            self.stuck_s += dt
            if self.stuck_s >= STUCK_S:
                self.stuck_s = None
                log.warning("level sensor working again")

        # silo refill
        pct = 100 * self.silo_lb / SILO_CAPACITY_LB
        if not self.refilling and pct <= REFILL_AT_PCT:
            if self.refill_late_s > 0:
                self.refill_late_s -= dt
            else:
                self.refilling = True
                log.info("refill truck unloading (silo %.0f%%)", pct)
        if self.refilling:
            self.silo_lb = min(self.silo_lb + REFILL_RATE_LB_S * dt, SILO_CAPACITY_LB * REFILL_TO_PCT / 100)
            if self.silo_lb >= SILO_CAPACITY_LB * REFILL_TO_PCT / 100 - 1:
                self.refilling = False
                log.info("refill done (silo %.0f%%)", REFILL_TO_PCT)

        completed = None

        if self.state == "arriving":
            if motor:
                self.travel_s -= dt
                if self.travel_s <= 0:
                    self.state = "at_spout"
                    self.bag_lb = 0.0
                    self.fill_s = 0.0
                    self.trip_lb = LEVEL_TRIP_LB + self.sensor_offset() + random.gauss(0, 0.15)
        elif self.state == "at_spout":
            if solenoid:
                flow = 0.0
                if self.silo_lb > 0:
                    flow = NOMINAL_FLOW_LB_S * self.flow_factor() * random.uniform(0.97, 1.03)
                take = min(flow * dt, self.silo_lb)
                self.silo_lb -= take
                self.bag_lb = min(self.bag_lb + take, BAG_CAPACITY_LB)
                self.fill_s += dt
                self._gate_was_open = True
                self._last_flow = flow
            elif self._gate_was_open:
                # gate just shut: product in the air still lands in the bag
                extra = self._last_flow * IN_FLIGHT_S
                self.bag_lb = min(self.bag_lb + extra, BAG_CAPACITY_LB)
                self._gate_was_open = False
            if motor and self.bag_lb > 0:
                # the plc released the full bag: it rides off over the scale
                self.bag_count += 1
                net = round(self.bag_lb + random.gauss(0, SCALE_NOISE_LB), 1)
                completed = (net, self.fill_s)
                self.state = "arriving"
                self.travel_s = BAG_SPACING_S
                self.bag_lb = 0.0

        prox = self.state == "at_spout"
        level = prox and self.stuck_s is None and self.bag_lb >= self.trip_lb
        return prox, level, completed

    def silo_pct(self):
        return 100 * self.silo_lb / SILO_CAPACITY_LB


def connect():
    while True:
        c = ModbusTcpClient(cfg.PLC_HOST, port=cfg.PLC_PORT)
        if c.connect():
            log.info("connected to plc at %s:%s", cfg.PLC_HOST, cfg.PLC_PORT)
            return c
        log.warning("plc not reachable at %s:%s, retrying in 3 s", cfg.PLC_HOST, cfg.PLC_PORT)
        time.sleep(3)


def mx_addr(name):
    return cfg.MX_COIL_OFFSET + cfg.MX[name]


def mw_addr(name):
    return cfg.MW_REG_OFFSET + cfg.MW[name]


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mode", choices=["a", "b", "c"], default=os.environ.get("LINE_MODE", "a"))
    args = ap.parse_args()
    os.makedirs(cfg.DATA_DIR, exist_ok=True)

    plant = Plant(args.mode)
    plc = connect()
    log.info("mode %s. silo %.0f%%. fire scenarios with ./run.sh event <clog|drift|silo_low|stuck|clear|stop|start>",
             args.mode.upper(), plant.silo_pct())

    last = time.time()
    while True:
        try:
            now = time.time()
            dt = min(now - last, 0.5)
            last = now
            plant.check_event_files()

            r = plc.read_coils(0, count=5)
            if r.isError():
                raise IOError(r)
            motor = r.bits[cfg.COIL["motor"]]
            solenoid = r.bits[cfg.COIL["solenoid"]]

            prox, level, completed = plant.step(motor, solenoid, dt)

            start_pulse = plant.pending_start_pulse > 0
            if start_pulse:
                plant.pending_start_pulse -= dt

            # operator panel + sensors (%MX0.0 - %MX0.6), one write
            bits = [False] * 7
            bits[cfg.MX["start"]] = start_pulse
            bits[cfg.MX["stop"]] = plant.stop_closed
            bits[cfg.MX["prox"]] = prox
            bits[cfg.MX["level"]] = level
            bits[cfg.MX["mode_a"]] = plant.mode == "a"
            bits[cfg.MX["mode_b"]] = plant.mode == "b"
            bits[cfg.MX["mode_c"]] = plant.mode == "c"
            plc.write_coils(cfg.MX_COIL_OFFSET, bits)

            plc.write_register(mw_addr("silo_pct"), int(round(plant.silo_pct())))
            plc.write_register(mw_addr("flow_x10"), int(round(NOMINAL_FLOW_LB_S * plant.flow_factor() * 10)))

            if completed:
                net, fill_s = completed
                # words in this order so the poller sees the count change last
                plc.write_register(mw_addr("bag_net_x10"), int(round(net * 10)))
                plc.write_register(mw_addr("fill_time_ds"), int(round(fill_s * 10)))
                plc.write_register(mw_addr("bag_count"), plant.bag_count % 65536)
                log.info("bag %d: %.1f lb in %.1f s (silo %.0f%%)", plant.bag_count, net, fill_s, plant.silo_pct())

        except Exception as e:
            log.error("plc i/o error (%s), reconnecting", e)
            try:
                plc.close()
            except Exception:
                pass
            time.sleep(1)
            plc = connect()
            last = time.time()

        time.sleep(TICK_S)


if __name__ == "__main__":
    main()
