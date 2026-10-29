"""
chat with the line data
-----------------------
plain-English questions over what the edge poller recorded:

    "is the bagging line healthy right now?"
    "how many short bags in the current lot?"
    "which lots had short fills this week, and on which shift?"
    "how much product did we give away yesterday?"

how it works:
  1. pulls the last few minutes from InfluxDB (live status) and the bag,
     lot, alarm and downtime records from SQL
  2. turns that into one compact text block
  3. sends the question + that block to a model

two backends, set with LLM_BACKEND in .env:
  * ollama (default): a local model. nothing leaves the building, no key.
        ollama pull llama3.2
  * anthropic: the Claude API (needs ANTHROPIC_API_KEY). the text block
        leaves the network, and the audit log records that.

either way the queries, the prompt and the audit record are the same.
only the model call changes.

    python3 chat_health.py        # terminal chat
    python3 chat_web.py           # browser, next to the dashboard
"""

import json
import sys
import time
import urllib.request
from datetime import datetime, timezone

from influxdb_client import InfluxDBClient

import config as cfg
import db
import pricing

USER_ID = "operator"   # in a deployment this comes from sign-in
TZ = db.PLANT_TZ.key   # plant local time zone name, used in every timestamp the model sees

SYSTEM = (
    "You are a plant-floor assistant for a fertilizer bagging line. You answer a plant "
    "manager's questions using only the data block provided. Be short and direct, plain "
    "language. Start with 'As of <assessment time>'. "
    "Bags are labeled 50 lb net. A 'short' bag is under the short limit, an 'over' bag is "
    "over the over limit, and giveaway is product over the label weight given away free. "
    "Short bags are a compliance risk; giveaway is a cost. "
    "Use the LIVE section for 'right now' questions and the HISTORY section for past "
    "days, lots and shifts. Only state numbers that appear in the data. If the data "
    "cannot answer the question, say so. If the newest reading is more than 60 seconds "
    "old, warn that the data may be stale."
)


# --- live window (InfluxDB) -------------------------------------------------
def fetch_live(minutes=15):
    client = InfluxDBClient(url=cfg.INFLUX_URL, token=cfg.INFLUX_TOKEN, org=cfg.INFLUX_ORG)
    flux = f'''
    from(bucket: "{cfg.INFLUX_BUCKET}")
      |> range(start: -{int(minutes)}m)
      |> filter(fn: (r) => r._measurement == "fill_status")
      |> last()'''
    latest, ts = {}, None
    for table in client.query_api().query(flux):
        for rec in table.records:
            latest[rec.get_field()] = rec.get_value()
            ts = max(ts, rec.get_time()) if ts else rec.get_time()
    client.close()
    return latest, ts


def live_section(minutes, now):
    """returns (lines, age_s of the newest reading or None)."""
    lines = ["LIVE (InfluxDB, newest reading from the edge poller):"]
    try:
        latest, ts = fetch_live(minutes)
    except Exception as e:
        return lines + [f"  live data unavailable ({e}). treat line status as UNKNOWN."], None
    if not latest:
        return lines + [f"  no readings in the last {minutes} minutes. the poller may be stopped. "
                        f"treat line status as UNKNOWN, not healthy."], None
    age = (now - ts).total_seconds()
    g = latest.get
    lines += [
        f"  newest reading {ts.astimezone(db.PLANT_TZ).strftime('%Y-%m-%d %H:%M:%S')} ({age:.0f}s old"
        f"{', STALE' if age > 60 else ''})",
        f"  running={bool(g('running'))} gate_open={bool(g('solenoid'))} silo={g('silo_pct')}% "
        f"gate_flow={g('flow_lbs')} lb/s (nominal 12.0)",
        f"  since the poller started: bags={g('bags_total')} short={g('short_bags')} "
        f"over={g('over_bags')} giveaway={g('giveaway_lb')} lb",
        f"  OEE={g('oee_pct')}% (availability {g('availability_pct')}%, performance "
        f"{g('performance_pct')}%, quality {g('quality_pct')}%)",
        f"  spc z-scores of the latest bag: weight {g('net_z')}, fill time {g('fill_z')}",
    ]
    return lines, age


# --- history (SQL) -----------------------------------------------------------
def _rows(sql, params=None):
    r = db.query_rows(sql, params)
    return r.get("rows", []), r.get("error")


def history_section(days=30):
    out = [f"HISTORY (SQL, last {days} days). times are plant local time ({TZ}). "
           f"limits: short < {cfg.SHORT_LIMIT_LB} lb, over > {cfg.OVER_LIMIT_LB} lb, label {cfg.LABEL_NET_LB:.0f} lb."]

    rows, err = _rows(
        "SELECT l.lot_id, p.name, to_char(l.started_at AT TIME ZONE %s,'YYYY-MM-DD HH24:MI'), "
        "COALESCE(to_char(l.ended_at AT TIME ZONE %s,'YYYY-MM-DD HH24:MI'),'running now'), "
        "count(b.*), round(avg(b.net_lb),2), min(b.net_lb), "
        "count(*) FILTER (WHERE b.result='short'), count(*) FILTER (WHERE b.result='over'), "
        "round(COALESCE(sum(b.giveaway_lb),0),1), round(avg(b.fill_time_s),2) "
        "FROM production_lot l JOIN product p USING (product_id) "
        "LEFT JOIN bag_fill b ON b.lot_id = l.lot_id "
        "WHERE l.started_at > now() - (%s * interval '1 day') OR l.ended_at IS NULL "
        "GROUP BY l.lot_id, p.name, l.started_at, l.ended_at ORDER BY l.started_at DESC LIMIT 40",
        (TZ, TZ, days))
    if err:
        return "\n".join(out + [f"  history unavailable ({err})"])
    out.append("Lots (lot, product, start, end, bags, avg lb, min lb, short, over, giveaway lb, avg fill s):")
    for r in rows:
        out.append("  - " + " | ".join(str(v) for v in r))

    rows, _ = _rows(
        "SELECT to_char(ts AT TIME ZONE %s,'YYYY-MM-DD') d, shift_id, count(*), "
        "count(*) FILTER (WHERE result='short'), count(*) FILTER (WHERE result='over'), "
        "round(sum(giveaway_lb),1), round(avg(fill_time_s),2) FROM bag_fill "
        "WHERE ts > now() - (%s * interval '1 day') GROUP BY 1,2 ORDER BY 1 DESC, 2 LIMIT 120", (TZ, days))
    if rows:
        out.append("By day and shift (plant date, shift A day 6-14 / B swing 14-22 / C night, bags, short, over, giveaway lb, avg fill s):")
        out += ["  - " + " | ".join(str(v) for v in r) for r in rows]

    rows, _ = _rows(
        "SELECT to_char(ts AT TIME ZONE %s,'YYYY-MM-DD HH24:MI'), alarm_type, COALESCE(lot_id,''), "
        "COALESCE(detail,'') FROM alarm_event WHERE ts > now() - (%s * interval '1 day') "
        "AND alarm_type <> 'short_fill' AND alarm_type <> 'overfill' ORDER BY ts DESC LIMIT 50", (TZ, days))
    if rows:
        out.append("Other alarms, newest first (short/over bags are counted in the tables above):")
        out += ["  - " + " | ".join(str(v) for v in r) for r in rows]

    rows, _ = _rows(
        "SELECT to_char(started_at AT TIME ZONE %s,'YYYY-MM-DD HH24:MI'), COALESCE(duration_s,0), "
        "COALESCE(reason_code,''), COALESCE(lot_id,''), COALESCE(detail,'') FROM downtime_event "
        "WHERE started_at > now() - (%s * interval '1 day') ORDER BY started_at DESC LIMIT 40", (TZ, days))
    if rows:
        out.append("Downtime, newest first (start, seconds, reason, lot, detail):")
        out += ["  - " + " | ".join(str(v) for v in r) for r in rows]
    return "\n".join(out)


def build_prompt_context(minutes=15, now=None):
    """the one text block the model sees (and the audit log stores), plus the
    age in seconds of the newest live reading."""
    now = now or datetime.now(timezone.utc)
    head = (f"Assessment time (now, plant local time {TZ}): "
            f"{now.astimezone(db.PLANT_TZ).strftime('%Y-%m-%d %H:%M:%S')}.")
    live, age = live_section(minutes, now)
    hist = history_section(30)
    return head + "\n\n" + "\n".join(live) + "\n\n" + hist, age


# --- model backends ---------------------------------------------------------
def _user_content(question, context):
    return f"Line data:\n{context}\n\nQuestion: {question}"


def ask_claude(question, context):
    import anthropic
    client = anthropic.Anthropic()   # reads ANTHROPIC_API_KEY
    msg = client.messages.create(
        model=cfg.ANTHROPIC_MODEL, max_tokens=600,
        system=[{"type": "text", "text": SYSTEM, "cache_control": {"type": "ephemeral"}}],
        messages=[{"role": "user", "content": _user_content(question, context)}],
    )
    u = msg.usage
    return msg.content[0].text, {
        "input_tokens": getattr(u, "input_tokens", 0) or 0,
        "output_tokens": getattr(u, "output_tokens", 0) or 0,
        "cache_write_tokens": getattr(u, "cache_creation_input_tokens", 0) or 0,
        "cache_read_tokens": getattr(u, "cache_read_input_tokens", 0) or 0,
    }


def ask_ollama(question, context):
    payload = {"model": cfg.OLLAMA_MODEL, "stream": False, "messages": [
        {"role": "system", "content": SYSTEM},
        {"role": "user", "content": _user_content(question, context)}]}
    req = urllib.request.Request(f"{cfg.OLLAMA_URL}/api/chat", data=json.dumps(payload).encode(),
                                 headers={"Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=180) as resp:
        data = json.loads(resp.read())
    return data.get("message", {}).get("content", "").strip(), {
        "input_tokens": data.get("prompt_eval_count", 0) or 0,
        "output_tokens": data.get("eval_count", 0) or 0,
        "cache_write_tokens": 0, "cache_read_tokens": 0}


def ask_llm(question, context):
    """returns (answer, usage, model_str, left_network)."""
    if cfg.LLM_BACKEND == "anthropic":
        answer, usage = ask_claude(question, context)
        return answer, usage, cfg.ANTHROPIC_MODEL, True
    answer, usage = ask_ollama(question, context)
    return answer, usage, f"ollama/{cfg.OLLAMA_MODEL}", False


def answer_and_log(question, user_id=USER_ID, minutes=15):
    """the full pipeline, used by the terminal chat and the web page."""
    now = datetime.now(timezone.utc)
    context, data_age_s = build_prompt_context(minutes, now)
    t0 = time.time()
    answer, usage, model_str, left = ask_llm(question, context)
    latency_ms = int((time.time() - t0) * 1000)
    cost = pricing.cost_usd(model_str, usage["input_tokens"], usage["output_tokens"],
                            usage["cache_write_tokens"], usage["cache_read_tokens"])
    audit_id = db.record_chat(
        user_id=user_id, question=question, context_sent=context, answer=answer,
        model=model_str, window_minutes=minutes,
        input_tokens=usage["input_tokens"], output_tokens=usage["output_tokens"],
        cache_write_tokens=usage["cache_write_tokens"], cache_read_tokens=usage["cache_read_tokens"],
        cost_usd=cost, left_network=left)
    return {"answer": answer, "model": model_str, "left_network": left, "cost": cost,
            "latency_ms": latency_ms, "context_sent": context, "audit_id": audit_id, "usage": usage,
            "data_age_s": data_age_s}


def main():
    if cfg.LLM_BACKEND == "anthropic":
        import os
        if not os.environ.get("ANTHROPIC_API_KEY"):
            sys.exit("LLM_BACKEND=anthropic but ANTHROPIC_API_KEY is not set (put it in .env)")
        where = f"cloud model {cfg.ANTHROPIC_MODEL} (the data block leaves the network)"
    else:
        where = f"local model {cfg.OLLAMA_MODEL} via Ollama (nothing leaves the building)"
    print(f"ask the bagging line. using {where}. type 'exit' to quit.\n")
    while True:
        q = input("> ").strip()
        if q.lower() in ("exit", "quit"):
            break
        if not q:
            continue
        try:
            r = answer_and_log(q)
        except Exception as e:
            print(f"\n[model call failed: {e}]")
            if cfg.LLM_BACKEND != "anthropic":
                print(f"is Ollama running, and is the model pulled?  ollama pull {cfg.OLLAMA_MODEL}\n")
            continue
        print(f"\n{r['answer']}\n")
        scope = "left the network" if r["left_network"] else "stayed on-prem"
        print(f"[audit #{r['audit_id']}, {r['model']}, {r['usage']['input_tokens']} in / "
              f"{r['usage']['output_tokens']} out tokens, ~${r['cost']:.4f}, {r['latency_ms']} ms, data {scope}]\n")


if __name__ == "__main__":
    main()
