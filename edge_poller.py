"""
edge poller
-----------
the piece that would run on a small box next to the line. it:

  1. polls the plc over modbus tcp twice a second (OpenPLC or soft_plc.py)
  2. writes every reading to a LOCAL InfluxDB (nothing leaves the network)
  3. when a bag comes off the scale: records it against the open lot,
     checks it against the label weight (short fill / overfill / giveaway)
  4. raises alarm EVENTS on the transition into a problem, once:
       short_fill, overfill   bag weight outside the limits in config.py
       fill_timeout           gate open longer than FILL_TIMEOUT_S
       starved                running, but no bag finished for STARVED_S
       silo_low               silo below SILO_LOW_PCT
       spc                    bag weight or fill time drifting away from the
                              lot's own baseline (z-score vs the first 30 bags
                              of the lot), which catches a slow clog or a
                              drifting sensor before the hard limits do
  5. opens and closes downtime events (stopped, starved)
  6. keeps a running OEE: availability x performance x quality

every check here is plain rules and statistics. no model is called per tick.
the chat layer only reads what this loop already recorded.
"""

import logging
import statistics
import time
from datetime import datetime, timezone

from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS
from pymodbus.client import ModbusTcpClient

import config as cfg
import db

logging.basicConfig(level=logging.INFO, format="%(asctime)s %(levelname)-7s [poller] %(message)s")
log = logging.getLogger("poller")

POLL_SECONDS = 0.5
HEARTBEAT_EVERY_TICKS = 20
LOG_EVERY_TICKS = 10
STARVED_S = 25.0
SILO_LOW_PCT = 15.0

SPC_BASELINE_BAGS = 30   # the first bags of each lot set the baseline
SPC_Z_THRESHOLD = 3.0
# floor on the baseline spread, so a very steady line doesn't turn a small
# wobble into a z of 300. roughly the scale's and the timer's resolution.
#
# why a frozen baseline and not a rolling one: a rolling window follows a
# slow drift (a gate caking up over minutes) and never flags it. classic SPC
# sets control limits from a known-good period and holds them. here that
# period is the start of each lot, since a new product can flow differently.
SPC_MIN_SD = {"net_lb": 0.2, "fill_time_s": 0.15}


def connect_plc():
    while True:
        c = ModbusTcpClient(cfg.PLC_HOST, port=cfg.PLC_PORT)
        if c.connect():
            log.info("connected to plc at %s:%s", cfg.PLC_HOST, cfg.PLC_PORT)
            return c
        log.warning("plc not reachable at %s:%s, retrying in 3 s", cfg.PLC_HOST, cfg.PLC_PORT)
        time.sleep(3)


def read_tags(plc):
    c = plc.read_coils(0, count=5)
    if c.isError():
        raise IOError(f"coil read: {c}")
    w = plc.read_holding_registers(cfg.MW_REG_OFFSET, count=5)
    if w.isError():
        raise IOError(f"register read: {w}")
    bits, regs = c.bits, w.registers
    return {
        "motor": bits[cfg.COIL["motor"]],
        "solenoid": bits[cfg.COIL["solenoid"]],
        "running": bits[cfg.COIL["run_light"]],
        "full_light": bits[cfg.COIL["full_light"]],
        "bag_net_lb": regs[cfg.MW["bag_net_x10"]] / 10.0,
        "bag_count": regs[cfg.MW["bag_count"]],
        "fill_time_s": regs[cfg.MW["fill_time_ds"]] / 10.0,
        "silo_pct": regs[cfg.MW["silo_pct"]],
        "flow_lbs": regs[cfg.MW["flow_x10"]] / 10.0,
    }


def spc_check(value, baseline, min_sd):
    """z-score against the lot's baseline (its first SPC_BASELINE_BAGS bags).
    while the baseline is still filling, no anomaly. returns (anomaly, z)."""
    if len(baseline) < SPC_BASELINE_BAGS:
        baseline.append(value)
        return False, 0.0
    mean = statistics.mean(baseline)
    sd = max(statistics.pstdev(baseline), min_sd)
    z = (value - mean) / sd
    return abs(z) > SPC_Z_THRESHOLD, round(z, 2)


def classify(net_lb):
    if net_lb < cfg.SHORT_LIMIT_LB:
        return "short"
    if net_lb > cfg.OVER_LIMIT_LB:
        return "over"
    return "ok"


class Poller:
    def __init__(self):
        self.ticks = 0
        self.run_ticks = 0
        self.productive_ticks = 0
        self.bags = 0
        self.good_bags = 0
        self.short_bags = 0
        self.over_bags = 0
        self.giveaway_lb = 0.0
        self.last_count = None
        self.last_bag_at = None
        self.last_net = None
        self.last_fill = None
        self.net_base = []
        self.fill_base = []
        self.net_z = 0.0
        self.fill_z = 0.0
        self.lot_id = None
        self.lot_checked_at = 0.0

        self.was_running = None
        self.down_id = None
        self.down_started = None
        self.down_reason = None
        self.gate_open_since = None
        self.timeout_active = False
        self.starved_active = False
        self.silo_low_active = False
        self.net_spc_active = False
        self.fill_spc_active = False

    # --- lot: re-read every 30 s so ./run.sh lot takes effect live ---------
    def refresh_lot(self):
        if time.time() - self.lot_checked_at > 30 or self.lot_id is None:
            lot = db.current_lot(cfg.ASSET_ID)
            if lot and lot != self.lot_id:
                log.info("current lot: %s (spc baseline resets: next %d bags)", lot, SPC_BASELINE_BAGS)
                self.net_base, self.fill_base = [], []
            self.lot_id = lot or self.lot_id
            self.lot_checked_at = time.time()

    def alarm(self, kind, field=None, value=None, z=None, detail=""):
        log.warning("ALARM %s: %s", kind, detail)
        db.record_alarm(cfg.ASSET_ID, kind, field=field, value=value, z_score=z,
                        detail=detail, lot_id=self.lot_id)

    def open_down(self, now, reason, detail):
        if self.down_id is None and self.down_reason is None:
            self.down_started = now
            self.down_reason = reason
            self.down_id = db.open_downtime(cfg.ASSET_ID, now, reason_code=reason,
                                            detail=detail, lot_id=self.lot_id)
            log.warning("downtime opened (%s): %s", reason, detail)

    def close_down(self, now):
        if self.down_reason is not None:
            dur = int((now - self.down_started).total_seconds())
            db.close_downtime(self.down_id, now, dur)
            log.info("downtime closed (%s, %ds)", self.down_reason, dur)
            self.down_id = self.down_started = self.down_reason = None

    # --- a bag came off the scale ------------------------------------------
    def on_bag(self, now, net, fill_s):
        self.bags += 1
        self.last_bag_at = now
        self.last_net, self.last_fill = net, fill_s
        result = classify(net)
        giveaway = round(max(0.0, net - cfg.LABEL_NET_LB), 2)
        self.giveaway_lb += giveaway
        if result == "ok":
            self.good_bags += 1
        elif result == "short":
            self.short_bags += 1
            self.alarm("short_fill", "net_lb", net,
                       detail=f"bag {net:.1f} lb, under the {cfg.SHORT_LIMIT_LB:.1f} lb limit "
                              f"(label {cfg.LABEL_NET_LB:.0f} lb), lot {self.lot_id}")
        else:
            self.over_bags += 1
            self.alarm("overfill", "net_lb", net,
                       detail=f"bag {net:.1f} lb, over the {cfg.OVER_LIMIT_LB:.1f} lb limit, "
                              f"{giveaway:.1f} lb given away, lot {self.lot_id}")

        db.record_bag(cfg.ASSET_ID, self.lot_id, now, net, fill_s, result, giveaway)

        net_anom, self.net_z = spc_check(net, self.net_base, SPC_MIN_SD["net_lb"])
        fill_anom, self.fill_z = spc_check(fill_s, self.fill_base, SPC_MIN_SD["fill_time_s"])
        if net_anom and not self.net_spc_active:
            self.alarm("spc", "net_lb", net, self.net_z,
                       f"bag weight {net:.1f} lb is {self.net_z:+.1f} std devs from this lot's baseline")
        self.net_spc_active = net_anom
        if fill_anom and not self.fill_spc_active:
            self.alarm("spc", "fill_time_s", fill_s, self.fill_z,
                       f"fill time {fill_s:.1f} s is {self.fill_z:+.1f} std devs from this lot's baseline "
                       f"(a slowing gate or low flow shows up here first)")
        self.fill_spc_active = fill_anom
        return result

    # --- one poll ----------------------------------------------------------
    def tick(self, t, now):
        self.ticks += 1
        alarm = False

        # bag completions
        if self.last_count is None:
            self.last_count = t["bag_count"]
            self.last_bag_at = now
        elif t["bag_count"] != self.last_count:
            missed = (t["bag_count"] - self.last_count) % 65536 - 1
            if missed > 0:
                log.warning("%d bag(s) finished between polls; only the latest is recorded", missed)
            self.last_count = t["bag_count"]
            res = self.on_bag(now, t["bag_net_lb"], t["fill_time_s"])
            alarm = alarm or res != "ok"
            if self.down_reason in ("starved", "fill_fault"):
                self.close_down(now)
                self.starved_active = False

        # stopped / running
        if t["running"]:
            self.run_ticks += 1
            if self.was_running is False and self.down_reason == "stopped":
                self.close_down(now)
                self.last_bag_at = now
        else:
            if self.was_running is not False:
                self.close_down(now)   # a starved episode becomes a stop
                self.open_down(now, "stopped", "run light off (stop pressed or line not started)")
                db.record_alarm(cfg.ASSET_ID, "downtime", "running", 0, detail="line stopped",
                                lot_id=self.lot_id)
            alarm = True
        self.was_running = t["running"]

        # starved: running but nothing coming off the scale
        idle_s = (now - self.last_bag_at).total_seconds() if self.last_bag_at else 0
        if t["running"] and idle_s > STARVED_S:
            if not self.starved_active:
                if self.timeout_active:
                    # gate is open and nothing finishes: the fill_timeout alarm already
                    # says why, so log the lost time as a fill fault, not starved
                    self.open_down(now, "fill_fault", f"gate open, no bag for {STARVED_S:.0f}+ s")
                else:
                    why = "silo empty" if t["silo_pct"] <= 1 else "no bag finished"
                    self.alarm("starved", "silo_pct", t["silo_pct"],
                               detail=f"running but no bag for {idle_s:.0f} s ({why}, silo {t['silo_pct']}%)")
                    self.open_down(now, "starved", f"no bag for {STARVED_S:.0f}+ s, silo {t['silo_pct']}%")
                self.starved_active = True
            alarm = True
        elif t["running"]:
            self.productive_ticks += 1

        # gate open too long
        if t["solenoid"]:
            self.gate_open_since = self.gate_open_since or now
            open_s = (now - self.gate_open_since).total_seconds()
            if open_s > cfg.FILL_TIMEOUT_S:
                if not self.timeout_active:
                    self.alarm("fill_timeout", "fill_time_s", round(open_s, 1),
                               detail=f"gate open {open_s:.0f} s with no level signal "
                                      f"(limit {cfg.FILL_TIMEOUT_S:.0f} s): sensor fault, empty silo or blocked gate")
                    self.timeout_active = True
                alarm = True
        else:
            self.gate_open_since = None
            self.timeout_active = False

        # silo
        if t["silo_pct"] < SILO_LOW_PCT:
            if not self.silo_low_active:
                self.alarm("silo_low", "silo_pct", t["silo_pct"],
                           detail=f"silo at {t['silo_pct']}%, under {SILO_LOW_PCT:.0f}%")
                self.silo_low_active = True
            alarm = True
        elif t["silo_pct"] > SILO_LOW_PCT + 5:
            self.silo_low_active = False

        # OEE since the poller started
        availability = self.productive_ticks / self.ticks if self.ticks else 0
        run_min = self.productive_ticks * POLL_SECONDS / 60
        performance = min(self.bags / (cfg.IDEAL_BAGS_PER_MIN * run_min), 1.0) if run_min > 0.5 else 1.0
        quality = self.good_bags / self.bags if self.bags else 1.0
        t.update({
            "availability_pct": round(availability * 100, 1),
            "performance_pct": round(performance * 100, 1),
            "quality_pct": round(quality * 100, 1),
            "oee_pct": round(availability * performance * quality * 100, 1),
            "alarm": alarm,
            "spc_alarm": self.net_spc_active or self.fill_spc_active,
            "net_z": self.net_z, "fill_z": self.fill_z,
            "bags_total": self.bags, "short_bags": self.short_bags, "over_bags": self.over_bags,
            "giveaway_lb": round(self.giveaway_lb, 1),
            "last_net_lb": self.last_net, "last_fill_s": self.last_fill,
        })
        return t


def to_points(t, now, lot_id, new_bag):
    p = (Point("fill_status").tag("line", cfg.ASSET_ID)
         .field("running", int(t["running"])).field("motor", int(t["motor"]))
         .field("solenoid", int(t["solenoid"])).field("full_light", int(t["full_light"]))
         .field("silo_pct", float(t["silo_pct"])).field("flow_lbs", float(t["flow_lbs"]))
         .field("bag_count", int(t["bag_count"])).field("bags_total", int(t["bags_total"]))
         .field("short_bags", int(t["short_bags"])).field("over_bags", int(t["over_bags"]))
         .field("giveaway_lb", float(t["giveaway_lb"]))
         .field("availability_pct", float(t["availability_pct"]))
         .field("performance_pct", float(t["performance_pct"]))
         .field("quality_pct", float(t["quality_pct"])).field("oee_pct", float(t["oee_pct"]))
         .field("alarm", int(t["alarm"])).field("spc_alarm", int(t["spc_alarm"]))
         .field("net_z", float(t["net_z"])).field("fill_z", float(t["fill_z"]))
         .time(now))
    points = [p]
    if new_bag:
        points.append(Point("bag").tag("line", cfg.ASSET_ID).tag("lot", lot_id or "none")
                      .tag("result", classify(t["last_net_lb"]))
                      .field("net_lb", float(t["last_net_lb"])).field("fill_time_s", float(t["last_fill_s"]))
                      .time(now))
    return points


def main():
    plc = connect_plc()
    influx = InfluxDBClient(url=cfg.INFLUX_URL, token=cfg.INFLUX_TOKEN, org=cfg.INFLUX_ORG)
    write_api = influx.write_api(write_options=SYNCHRONOUS)
    p = Poller()
    influx_warned = False
    log.info("polling every %.1f s, writing to InfluxDB bucket '%s'", POLL_SECONDS, cfg.INFLUX_BUCKET)

    while True:
        try:
            now = datetime.now(timezone.utc)
            p.refresh_lot()
            bags_before = p.bags
            t = p.tick(read_tags(plc), now)

            influx_ok = True
            try:
                write_api.write(bucket=cfg.INFLUX_BUCKET, org=cfg.INFLUX_ORG,
                                record=to_points(t, now, p.lot_id, p.bags != bags_before))
                influx_warned = False
            except Exception as e:
                influx_ok = False
                if not influx_warned:
                    log.error("InfluxDB write failed: %s", e)
                    influx_warned = True

            if p.ticks % HEARTBEAT_EVERY_TICKS == 0:
                db.record_heartbeat(cfg.ASSET_ID, "ok" if influx_ok else "degraded", influx_ok, p.ticks,
                                    None if influx_ok else "InfluxDB write failing")
            if p.ticks % LOG_EVERY_TICKS == 0:
                log.info("run=%s gate=%s silo=%d%% bags=%d (short %d, over %d) giveaway=%.1f lb | "
                         "A=%.0f%% P=%.0f%% Q=%.0f%% OEE=%.0f%% | z(net=%.1f fill=%.1f) influx=%s",
                         t["running"], t["solenoid"], t["silo_pct"], t["bags_total"], t["short_bags"],
                         t["over_bags"], t["giveaway_lb"], t["availability_pct"], t["performance_pct"],
                         t["quality_pct"], t["oee_pct"], t["net_z"], t["fill_z"], "ok" if influx_ok else "FAIL")
        except Exception as e:
            if isinstance(e, (IOError, ConnectionError)) or not plc.connected:
                log.error("plc read failed (%s), reconnecting", e)
                try:
                    plc.close()
                except Exception:
                    pass
                time.sleep(1)
                plc = connect_plc()
            else:
                log.exception("poll error: %s", e)
        time.sleep(POLL_SECONDS)


if __name__ == "__main__":
    main()
