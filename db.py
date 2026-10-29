"""
sql layer (TimescaleDB / PostgreSQL)
------------------------------------
the one place that talks to the relational store. the poller, the chat
layer, the backfill and the eval harness all import from here.

  * graceful degrade: if postgres is down, every function logs a warning and
    returns None instead of crashing, so the edge loop keeps running on
    InfluxDB alone.
  * engine-portable: plain psycopg2 + standard sql. for Microsoft SQL Server,
    swap the driver (pyodbc) and connection string; the statements barely change.
"""

import logging
import os
from datetime import datetime
from zoneinfo import ZoneInfo

import psycopg2

import config as cfg

log = logging.getLogger("db")

PLANT_TZ = ZoneInfo(os.environ.get("PLANT_TZ", "America/New_York"))

_conn = None
_warned = False


def get_conn():
    """a live connection, or None if the database is unreachable. never raises."""
    global _conn, _warned
    try:
        if _conn is None or _conn.closed:
            _conn = psycopg2.connect(
                host=cfg.PG_HOST, port=cfg.PG_PORT, dbname=cfg.PG_DB,
                user=cfg.PG_USER, password=cfg.PG_PASS, connect_timeout=3,
            )
            _conn.autocommit = True
            log.info("connected to sql store at %s:%s/%s", cfg.PG_HOST, cfg.PG_PORT, cfg.PG_DB)
            _warned = False
        return _conn
    except Exception as e:
        if not _warned:
            log.warning("sql store unavailable (%s), continuing without it", e)
            _warned = True
        _conn = None
        return None


def _execute(sql, params=None, returning=False):
    """run one statement. returns the first column of the first row when
    `returning` is True. logs and swallows errors."""
    global _conn
    conn = get_conn()
    if conn is None:
        return None
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            if returning:
                row = cur.fetchone()
                return row[0] if row else None
    except Exception as e:
        log.warning("sql statement failed (%s), skipping", e)
        _conn = None
    return None


def query_rows(sql, params=None):
    """read-only SELECT -> {columns, rows}, json-safe. callers pass fixed,
    trusted sql (no user text goes into the query string)."""
    global _conn
    conn = get_conn()
    if conn is None:
        return {"columns": [], "rows": [], "error": "sql store unavailable"}
    try:
        with conn.cursor() as cur:
            cur.execute(sql, params)
            cols = [d[0] for d in cur.description]
            rows = [[v if (isinstance(v, (int, float, bool)) or v is None) else str(v)
                     for v in r] for r in cur.fetchall()]
            return {"columns": cols, "rows": rows}
    except Exception as e:
        _conn = None
        return {"columns": [], "rows": [], "error": str(e)}


# --- shift + lot context -----------------------------------------------

def shift_for(ts_utc):
    """'A' day 6-14, 'B' swing 14-22, 'C' night 22-6, in plant local time."""
    h = ts_utc.astimezone(PLANT_TZ).hour
    if 6 <= h < 14:
        return "A"
    if 14 <= h < 22:
        return "B"
    return "C"


def current_lot(asset_id):
    """the open lot on this line (ended_at IS NULL), newest first."""
    return _execute(
        "SELECT lot_id FROM production_lot WHERE asset_id = %s AND ended_at IS NULL "
        "ORDER BY started_at DESC LIMIT 1", (asset_id,), returning=True)


def start_lot(asset_id, product_id, bags_target=2000, lot_id=None, started_at=None):
    """close the open lot and start a new one. returns the new lot_id."""
    started_at = started_at or datetime.now(PLANT_TZ)
    lot_id = lot_id or "L" + started_at.astimezone(PLANT_TZ).strftime("%y%m%d-%H%M")
    _execute("UPDATE production_lot SET ended_at = %s WHERE asset_id = %s AND ended_at IS NULL",
             (started_at, asset_id))
    _execute("""INSERT INTO production_lot (lot_id, asset_id, product_id, bags_target, started_at)
                VALUES (%s, %s, %s, %s, %s) ON CONFLICT (lot_id) DO NOTHING""",
             (lot_id, asset_id, product_id, bags_target, started_at))
    return lot_id


# --- event inserts -------------------------------------------------------

def record_bag(asset_id, lot_id, ts, net_lb, fill_time_s, result, giveaway_lb):
    return _execute(
        """INSERT INTO bag_fill (ts, asset_id, lot_id, shift_id, net_lb, fill_time_s, result, giveaway_lb)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING bag_id""",
        (ts, asset_id, lot_id, shift_for(ts), net_lb, fill_time_s, result, giveaway_lb),
        returning=True,
    )


def record_alarm(asset_id, alarm_type, field=None, value=None, z_score=None,
                 detail=None, lot_id=None, source="auto", ts=None):
    if ts is None:
        return _execute(
            """INSERT INTO alarm_event (asset_id, lot_id, alarm_type, field, value, z_score, detail, source)
               VALUES (%s, %s, %s, %s, %s, %s, %s, %s) RETURNING alarm_id""",
            (asset_id, lot_id, alarm_type, field, value, z_score, detail, source), returning=True)
    return _execute(
        """INSERT INTO alarm_event (ts, asset_id, lot_id, alarm_type, field, value, z_score, detail, source)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING alarm_id""",
        (ts, asset_id, lot_id, alarm_type, field, value, z_score, detail, source), returning=True)


def open_downtime(asset_id, started_at, reason_code=None, detail=None, lot_id=None, source="auto"):
    return _execute(
        """INSERT INTO downtime_event (asset_id, lot_id, started_at, reason_code, detail, source)
           VALUES (%s, %s, %s, %s, %s, %s) RETURNING downtime_id""",
        (asset_id, lot_id, started_at, reason_code, detail, source), returning=True)


def close_downtime(downtime_id, ended_at, duration_s):
    if downtime_id is None:
        return
    _execute("UPDATE downtime_event SET ended_at = %s, duration_s = %s WHERE downtime_id = %s",
             (ended_at, duration_s, downtime_id))


def record_heartbeat(asset_id, status, influx_write_ok, tick, detail=None):
    _execute(
        """INSERT INTO poller_heartbeat (asset_id, status, influx_write_ok, tick, detail)
           VALUES (%s, %s, %s, %s, %s)""",
        (asset_id, status, influx_write_ok, tick, detail))


def record_chat(user_id, question, context_sent, answer, model,
                window_minutes, input_tokens, output_tokens, left_network,
                cache_write_tokens=0, cache_read_tokens=0, cost_usd=0):
    """the governance record: what was asked, exactly what data went to the
    model, what came back, the cost, and whether it left the network."""
    return _execute(
        """INSERT INTO chat_audit
               (user_id, question, context_sent, answer, model, window_minutes,
                input_tokens, output_tokens, cache_write_tokens, cache_read_tokens,
                cost_usd, left_network)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING audit_id""",
        (user_id, question, context_sent, answer, model, window_minutes,
         input_tokens, output_tokens, cache_write_tokens, cache_read_tokens,
         cost_usd, left_network),
        returning=True,
    )


# --- eval harness --------------------------------------------------------

def upsert_golden(tag, question, golden_answer, must_include=None, notes=None):
    existing = _execute("SELECT golden_id FROM golden_qa WHERE question = %s",
                        (question,), returning=True)
    if existing is not None:
        return existing
    return _execute(
        """INSERT INTO golden_qa (tag, question, golden_answer, must_include, notes)
           VALUES (%s, %s, %s, %s, %s) RETURNING golden_id""",
        (tag, question, golden_answer, must_include, notes), returning=True)


def start_eval_run(model, n_items, notes=None):
    return _execute("INSERT INTO eval_run (model, n_items, notes) VALUES (%s, %s, %s) RETURNING run_id",
                    (model, n_items, notes), returning=True)


def finish_eval_run(run_id, mean_score, total_cost_usd):
    _execute("UPDATE eval_run SET mean_score = %s, total_cost_usd = %s WHERE run_id = %s",
             (mean_score, total_cost_usd, run_id))


def record_eval_result(run_id, golden_id, model, question, golden_answer,
                       model_answer, score, passed, input_tokens,
                       output_tokens, cost_usd, latency_ms):
    _execute(
        """INSERT INTO eval_result
               (run_id, golden_id, model, question, golden_answer, model_answer,
                score, passed, input_tokens, output_tokens, cost_usd, latency_ms)
           VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)""",
        (run_id, golden_id, model, question, golden_answer, model_answer,
         score, passed, input_tokens, output_tokens, cost_usd, latency_ms))
