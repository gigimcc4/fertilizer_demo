#!/usr/bin/env python3
"""
backfill: two weeks of bagging history
--------------------------------------
writes a made-up but consistent history so the dashboard and the chat have
lots, shifts and days to talk about. seeded, so it is the same every time.

the line runs day (A) and swing (B) shift, 6:00-22:00 plant time, every
day. one lot per day. the story in the data:

  * days 9-7 ago, swing shift: the silo gate slowly cakes up. bag weights
    stay fine (the level sensor still stops each fill), but fill time climbs
    and bags per minute drop. 7 days ago at 6:00 the gate is cleaned.
  * 3 days ago, swing shift, 16:00-16:40: the level sensor drifts and trips
    early. the spc alarm fires within minutes, but the run of short bags goes
    on until the sensor is recalibrated at 16:40. nobody acknowledged the alarm.
  * yesterday, 10:30: the refill truck is late, the silo runs dry, the gate
    opens on an empty silo and the line starves for ~35 minutes.
  * every shift has a few short stops, and a rare overfilled bag.

writes the same shapes the live poller does:
  InfluxDB: fill_status (one point per minute) and bag (one per bag)
  SQL:      production_lot, bag_fill, alarm_event, downtime_event

    python3 backfill.py            # 14 days (./run.sh seed)
    python3 backfill.py --days 7

run it once, after `docker compose up`. running again adds a second copy.
"""

import argparse
import random
from datetime import datetime, timedelta

from influxdb_client import InfluxDBClient, Point
from influxdb_client.client.write_api import SYNCHRONOUS
from psycopg2.extras import execute_values

import config as cfg
import db

TZ = db.PLANT_TZ
SEED = 42
SPACING_S = 2.8            # conveyor + handling time per bag, on top of the fill
BASE_FILL_S = 4.2
SILO_LB = 20000.0


def classify(net):
    return "short" if net < cfg.SHORT_LIMIT_LB else "over" if net > cfg.OVER_LIMIT_LB else "ok"


def day_plan(rng, day_idx, date):
    """downtime windows [(start_local, minutes, reason, detail)] and story flags for one day."""
    t0 = datetime(date.year, date.month, date.day, 6, 0, tzinfo=TZ)
    windows = []
    for _ in range(rng.randint(2, 5)):   # ordinary short stops
        start = t0 + timedelta(minutes=rng.randint(20, 15 * 60))
        windows.append((start, rng.randint(2, 9), "stopped", "operator stop (jam, bag change, break)"))
    if day_idx == 7:
        windows.append((t0, 40, "maintenance", "gate cleaned, caked product removed"))
    if day_idx == 3:
        windows.append((t0.replace(hour=16, minute=40), 25, "fill_fault", "level sensor recalibrated after short fills"))
    if day_idx == 1:
        windows.append((t0.replace(hour=10, minute=30), 35, "starved", "silo empty, refill truck late"))
    return windows


def clog_factor(day_idx, local):
    """1.0 = clean gate. builds on swing shift days 9-7 ago."""
    if day_idx not in (9, 8):
        return 1.0
    hrs = (local.hour - 14) + local.minute / 60 if local.hour >= 14 else 0
    base = 0.85 if day_idx == 8 else 1.0
    return max(0.55, base - 0.04 * hrs) if local.hour >= 14 else (0.9 if day_idx == 8 else 1.0)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--days", type=int, default=14)
    args = ap.parse_args()
    rng = random.Random(SEED)

    conn = db.get_conn()
    if conn is None:
        raise SystemExit("can't reach the sql store. is `docker compose up -d` running?")
    influx = InfluxDBClient(url=cfg.INFLUX_URL, token=cfg.INFLUX_TOKEN, org=cfg.INFLUX_ORG)
    wapi = influx.write_api(write_options=SYNCHRONOUS)

    today = datetime.now(TZ).date()
    silo = SILO_LB * 0.8
    totals = {"bags": 0, "short": 0, "over": 0, "lots": 0}

    for day_idx in range(args.days, 0, -1):
        date = today - timedelta(days=day_idx)
        product = "15-0-15-50" if date.weekday() == 2 else "10-10-10-50"
        lot = f"L{date:%y%m%d}"
        start = datetime(date.year, date.month, date.day, 6, 0, tzinfo=TZ)
        end = start + timedelta(hours=16)
        with conn.cursor() as cur:
            cur.execute("INSERT INTO production_lot (lot_id, asset_id, product_id, bags_target, started_at, ended_at) "
                        "VALUES (%s,%s,%s,%s,%s,%s) ON CONFLICT (lot_id) DO NOTHING",
                        (lot, cfg.ASSET_ID, product, 7000, start, end))
        totals["lots"] += 1

        windows = day_plan(rng, day_idx, date)
        bags, alarms, downs, points = [], [], [], []
        shift_stats = {}
        t = start
        carry = 0.0
        drift_alarmed = False
        clog_spc_alarmed = False

        for w_start, mins, reason, detail in windows:
            w_end = w_start + timedelta(minutes=mins)
            downs.append((cfg.ASSET_ID, lot, w_start, w_end, mins * 60, reason, detail, "backfill"))
            if reason == "starved":
                alarms.append((w_start - timedelta(minutes=12), lot, "silo_low", "silo_pct", 14, None,
                               "silo at 14%, under 15%"))
                alarms.append((w_start, lot, "fill_timeout", "fill_time_s", 13.0, None,
                               "gate open 13 s with no level signal (limit 12 s): sensor fault, empty silo or blocked gate"))
                alarms.append((w_start + timedelta(seconds=25), lot, "starved", "silo_pct", 0, None,
                               "running but no bag for 25 s (silo empty, silo 0%)"))
            elif reason == "stopped":
                alarms.append((w_start, lot, "downtime", "running", 0, None, "line stopped"))

        while t < end:
            local = t.astimezone(TZ)
            shift = "A" if local.hour < 14 else "B"
            st = shift_stats.setdefault(shift, {"min": 0, "up": 0, "bags": 0, "good": 0, "short": 0,
                                                "over": 0, "give": 0.0})
            st["min"] += 1
            down = next((w for w in windows if w[0] <= t < w[0] + timedelta(minutes=w[1])), None)
            if day_idx == 1 and local.hour == 10 and local.minute < 30:
                silo = SILO_LB * 0.2 * (1 - local.minute / 30)   # truck late, silo draining
            if down and down[2] == "starved":
                silo = 0.0
            if down:
                carry = 0.0
            else:
                st["up"] += 1
                factor = clog_factor(day_idx, local)
                fill_mean = BASE_FILL_S / factor
                carry += 60.0
                while carry > 0:
                    fill_s = round(max(3.5, rng.gauss(fill_mean, 0.12)), 1)
                    cycle = fill_s + SPACING_S
                    if carry < cycle:
                        break
                    carry -= cycle
                    bag_t = t + timedelta(seconds=60 - carry)
                    drift = day_idx == 3 and local.hour == 16 and local.minute < 40
                    if drift:
                        progress = local.minute / 40
                        net = rng.gauss(50.25 - 2.2 * min(progress * 1.6, 1.0), 0.25)
                    else:
                        net = rng.gauss(50.3, 0.22)
                    if rng.random() < 0.002:
                        net += rng.uniform(2.0, 4.0)
                    net = round(net, 1)
                    res = classify(net)
                    give = round(max(0.0, net - cfg.LABEL_NET_LB), 2)
                    bags.append((bag_t, cfg.ASSET_ID, lot, shift, net, fill_s, res, give))
                    st["bags"] += 1
                    st["give"] += give
                    st["good"] += res == "ok"
                    st["short"] += res == "short"
                    st["over"] += res == "over"
                    if res == "short":
                        alarms.append((bag_t, lot, "short_fill", "net_lb", net, None,
                                       f"bag {net:.1f} lb, under the {cfg.SHORT_LIMIT_LB:.1f} lb limit (label 50 lb), lot {lot}"))
                    elif res == "over":
                        alarms.append((bag_t, lot, "overfill", "net_lb", net, None,
                                       f"bag {net:.1f} lb, over the {cfg.OVER_LIMIT_LB:.1f} lb limit, {give:.1f} lb given away, lot {lot}"))
                    if drift and not drift_alarmed and net < 49.9:
                        alarms.append((bag_t, lot, "spc", "net_lb", net, -3.4,
                                       f"bag weight {net:.1f} lb is -3.4 std devs from this lot's baseline"))
                        drift_alarmed = True
                    if factor < 0.9 and not clog_spc_alarmed:
                        alarms.append((bag_t, lot, "spc", "fill_time_s", fill_s, 3.6,
                                       f"fill time {fill_s:.1f} s is +3.6 std devs from this lot's baseline "
                                       f"(a slowing gate or low flow shows up here first)"))
                        clog_spc_alarmed = True
                    silo -= net
                    if silo < SILO_LB * 0.2 and not (day_idx == 1 and local.hour == 10):
                        silo = SILO_LB * 0.9      # truck on time
                    points.append(Point("bag").tag("line", cfg.ASSET_ID).tag("lot", lot).tag("result", res)
                                  .field("net_lb", float(net)).field("fill_time_s", float(fill_s)).time(bag_t))
                if down is None and day_idx == 1 and local.hour == 11 and local.minute == 5:
                    silo = SILO_LB * 0.9          # late truck finally unloads
            a = st["up"] / st["min"]
            p = min(st["bags"] / (cfg.IDEAL_BAGS_PER_MIN * max(st["up"], 1)), 1.0)
            q = st["good"] / st["bags"] if st["bags"] else 1.0
            points.append(Point("fill_status").tag("line", cfg.ASSET_ID)
                          .field("running", 0 if down else 1).field("silo_pct", round(100 * silo / SILO_LB, 1))
                          .field("flow_lbs", round(12.0 * clog_factor(day_idx, local), 1))
                          .field("bags_total", st["bags"]).field("short_bags", st["short"])
                          .field("over_bags", st["over"]).field("giveaway_lb", round(st["give"], 1))
                          .field("availability_pct", round(a * 100, 1)).field("performance_pct", round(p * 100, 1))
                          .field("quality_pct", round(q * 100, 1)).field("oee_pct", round(a * p * q * 100, 1))
                          .field("alarm", 1 if down else 0).field("spc_alarm", 0)
                          .field("net_z", 0.0).field("fill_z", 0.0).time(t))
            t += timedelta(minutes=1)

        with conn.cursor() as cur:
            execute_values(cur, "INSERT INTO bag_fill (ts, asset_id, lot_id, shift_id, net_lb, fill_time_s, result, giveaway_lb) VALUES %s", bags)
            execute_values(cur, "INSERT INTO alarm_event (ts, lot_id, alarm_type, field, value, z_score, detail, asset_id, source) VALUES %s",
                           [a + (cfg.ASSET_ID, "backfill") for a in alarms])
            execute_values(cur, "INSERT INTO downtime_event (asset_id, lot_id, started_at, ended_at, duration_s, reason_code, detail, source) VALUES %s", downs)
        try:
            for i in range(0, len(points), 5000):
                wapi.write(bucket=cfg.INFLUX_BUCKET, org=cfg.INFLUX_ORG, record=points[i:i + 5000])
        except Exception as e:
            print(f"  InfluxDB write failed ({e}); sql history was still written")

        n_short = sum(1 for b in bags if b[6] == "short")
        n_over = sum(1 for b in bags if b[6] == "over")
        totals["bags"] += len(bags)
        totals["short"] += n_short
        totals["over"] += n_over
        print(f"{date} {lot} {product:12s} bags={len(bags):5d} short={n_short:3d} over={n_over:2d} "
              f"downtime={sum(w[1] for w in windows):3d} min")

    influx.close()
    print(f"\ndone: {totals['lots']} lots, {totals['bags']} bags, {totals['short']} short, {totals['over']} over.")
    print("open Grafana and set the time range to 'Last 14 days' to see it.")


if __name__ == "__main__":
    main()
