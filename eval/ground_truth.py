"""
ground truth: the answer computed straight from the data
--------------------------------------------------------
for a data question ("how many short bags in the last hour?") the right
answer is whatever the stored records say. these functions compute it from
the source of record, after the fact, so the benchmark can check whether
the chat answer contains that number.

  * bag, lot, alarm, downtime records -> SQL (TimescaleDB)
  * live status (silo level, OEE)     -> InfluxDB

each returns a number, or None if the store is not reachable.
"""

import os
import sys

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import config as cfg
import db


def _sql(sql, params):
    return db._execute(sql, params, returning=True)


def _num(v, nd=2):
    return None if v is None else round(float(v), nd)


# --- bags (SQL) ------------------------------------------------------------
def bag_count(minutes=60):
    return _sql("SELECT count(*) FROM bag_fill WHERE ts > now() - (%s * interval '1 minute')", (minutes,))


def short_bag_count(minutes=60):
    return _sql("SELECT count(*) FROM bag_fill WHERE result = 'short' "
                "AND ts > now() - (%s * interval '1 minute')", (minutes,))


def over_bag_count(minutes=60):
    return _sql("SELECT count(*) FROM bag_fill WHERE result = 'over' "
                "AND ts > now() - (%s * interval '1 minute')", (minutes,))


def avg_net_lb(minutes=60):
    return _num(_sql("SELECT avg(net_lb) FROM bag_fill WHERE ts > now() - (%s * interval '1 minute')",
                     (minutes,)))


def giveaway_lb(minutes=60):
    return _num(_sql("SELECT COALESCE(sum(giveaway_lb),0) FROM bag_fill "
                     "WHERE ts > now() - (%s * interval '1 minute')", (minutes,)), 1)


def current_lot_short_count():
    return _sql("SELECT count(*) FROM bag_fill b JOIN production_lot l USING (lot_id) "
                "WHERE l.ended_at IS NULL AND l.asset_id = %s AND b.result = 'short'", (cfg.ASSET_ID,))


# --- events (SQL) ------------------------------------------------------------
def stoppage_count(minutes=60):
    return _sql("SELECT count(*) FROM downtime_event WHERE started_at > now() - (%s * interval '1 minute')",
                (minutes,))


def alarm_event_count(minutes=60):
    return _sql("SELECT count(*) FROM alarm_event WHERE ts > now() - (%s * interval '1 minute')", (minutes,))


# --- live (InfluxDB) ---------------------------------------------------------
def _influx_last(field, minutes=15):
    try:
        from influxdb_client import InfluxDBClient
        c = InfluxDBClient(url=cfg.INFLUX_URL, token=cfg.INFLUX_TOKEN, org=cfg.INFLUX_ORG)
        flux = (f'from(bucket: "{cfg.INFLUX_BUCKET}") |> range(start: -{minutes}m) '
                f'|> filter(fn: (r) => r._measurement == "fill_status" and r._field == "{field}") |> last()')
        for t in c.query_api().query(flux):
            for rec in t.records:
                c.close()
                return _num(rec.get_value(), 1)
        c.close()
    except Exception:
        return None
    return None


def latest_silo_pct():
    return _influx_last("silo_pct")


def latest_oee():
    return _influx_last("oee_pct")


TRUTH_FNS = {f.__name__: f for f in (
    bag_count, short_bag_count, over_bag_count, avg_net_lb, giveaway_lb,
    current_lot_short_count, stoppage_count, alarm_event_count, latest_silo_pct, latest_oee)}


def compute(fn_name, args=None):
    fn = TRUTH_FNS.get(fn_name)
    if fn is None:
        raise KeyError(f"unknown ground-truth function '{fn_name}'. available: {sorted(TRUTH_FNS)}")
    return fn(**(args or {}))
