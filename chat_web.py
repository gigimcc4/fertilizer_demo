#!/usr/bin/env python3
"""
web chat, split view
--------------------
the same pipeline as chat_health.py, as a web page: the live Grafana
dashboard on the left, the chat on the right, and a Data tab with the bag,
lot, alarm, downtime and chat-audit tables (with CSV download).

    python3 chat_web.py        # then open http://localhost:8600

  * white background, black text, colorblind-safe accents (Okabe-Ito), and
    status is never color-only: every chip has a text label
  * "show the data the model saw" reveals the exact block sent to the model

python standard library only for the server.
"""

import csv
import io
import json
import os
import socketserver
import sys
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import urlparse, parse_qs

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import chat_health as ch
import config as cfg
import db

PORT = int(os.environ.get("CHAT_WEB_PORT", "8600"))
BIND = os.environ.get("CHAT_WEB_BIND", "127.0.0.1")   # docker sets 0.0.0.0; compose publishes to this computer only
GRAFANA_EMBED = cfg.GRAFANA_EMBED_URL

# fixed, trusted queries for the Data tab (no user text -> no injection).
DATA_TABLES = {
    "bag_fill":       ("Bags",
                       "SELECT bag_id, ts, lot_id, shift_id, net_lb, fill_time_s, result, giveaway_lb "
                       "FROM bag_fill ORDER BY ts DESC"),
    "production_lot": ("Lots",
                       "SELECT l.lot_id, l.product_id, l.started_at, l.ended_at, count(b.*) AS bags, "
                       "round(avg(b.net_lb),2) AS avg_lb, count(*) FILTER (WHERE b.result='short') AS short, "
                       "count(*) FILTER (WHERE b.result='over') AS over, round(COALESCE(sum(b.giveaway_lb),0),1) AS giveaway_lb "
                       "FROM production_lot l LEFT JOIN bag_fill b USING (lot_id) "
                       "GROUP BY l.lot_id, l.product_id, l.started_at, l.ended_at ORDER BY l.started_at DESC"),
    "alarm_event":    ("Alarms",
                       "SELECT alarm_id, ts, lot_id, alarm_type, field, value, z_score, detail "
                       "FROM alarm_event ORDER BY ts DESC"),
    "downtime_event": ("Downtime",
                       "SELECT downtime_id, lot_id, started_at, ended_at, duration_s, reason_code, detail "
                       "FROM downtime_event ORDER BY started_at DESC"),
    "chat_audit":     ("Chat log (evidence)",
                       "SELECT audit_id, ts, user_id, question, model, left_network, "
                       "cost_usd, input_tokens, output_tokens FROM chat_audit ORDER BY ts DESC"),
    "eval_result":    ("Eval results",
                       "SELECT result_id, run_id, model, question, score, passed, cost_usd, latency_ms "
                       "FROM eval_result ORDER BY result_id DESC"),
}
DISPLAY_LIMIT = 500
EXPORT_LIMIT = 20000

PAGE = """<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Bagging Line 1</title>
<style>
  :root { --green:#009E73; --vermil:#D55E00; --blue:#0072B2; --ink:#000000; --paper:#ffffff; --muted:#3a3a3a; }
  * { box-sizing: border-box; }
  html, body { margin: 0; height: 100%; }
  body { background: var(--paper); color: var(--ink);
         font-family: system-ui, -apple-system, Arial, sans-serif;
         font-size: 16px; line-height: 1.5; display: flex; flex-direction: column; height: 100vh; }
  header { padding: 10px 20px; border-bottom: 3px solid var(--ink);
           display: flex; align-items: baseline; gap: 14px; flex: 0 0 auto; }
  header h1 { font-size: 18px; margin: 0; font-weight: 700; }
  header .sub { color: var(--muted); font-size: 13px; }

  /* Split: dashboard (main) + chat (companion panel on the right) */
  .split { display: flex; flex: 1 1 auto; min-height: 0; }
  .dash { flex: 1 1 62%; min-width: 0; border-right: 3px solid var(--ink);
          display: flex; flex-direction: column; }
  .dash iframe { flex: 1; width: 100%; border: 0; }
  .dash .cap { padding: 4px 10px; font-size: 12px; color: var(--muted); border-top: 2px solid var(--ink); }

  /* Main-area tabs: Dashboard | Data */
  .maintabs { display: flex; gap: 4px; border-bottom: 2px solid var(--ink); flex: 0 0 auto; padding: 0 8px; }
  .mtab { appearance: none; background: var(--paper); color: var(--muted); border: none;
          border-bottom: 4px solid transparent; padding: 8px 16px; font-size: 15px; font-weight: 600; cursor: pointer; }
  .mtab[aria-selected="true"] { color: var(--ink); border-bottom-color: var(--ink); }
  .mtab:focus-visible { outline: 3px solid var(--blue); outline-offset: 2px; }
  .mpanel { display: none; flex: 1 1 auto; min-height: 0; flex-direction: column; }
  .mpanel[data-active="true"] { display: flex; }

  .datapick { display: flex; flex-wrap: wrap; gap: 6px; padding: 8px; flex: 0 0 auto; }
  .dbtn { background: var(--paper); border: 2px solid var(--ink); padding: 4px 10px; cursor: pointer; font-size: 13px; }
  .dbtn[aria-pressed="true"] { background: var(--ink); color: var(--paper); }
  #datatable { flex: 1 1 auto; overflow: auto; padding: 0 8px 8px; min-height: 0; }
  table.grid { border-collapse: collapse; width: 100%; font-size: 12px; }
  table.grid th, table.grid td { border: 1px solid var(--ink); padding: 3px 6px; text-align: left;
                                 vertical-align: top; max-width: 380px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
  table.grid th { position: sticky; top: 0; background: #f2f2f2; }

  .chat { flex: 0 0 430px; max-width: 480px; min-width: 340px;
          display: flex; flex-direction: column; padding: 10px 14px; min-height: 0; }
  .toolbar { display: flex; align-items: center; gap: 8px; margin-bottom: 8px; flex: 0 0 auto; }
  .switch { display: inline-flex; align-items: center; gap: 6px; font-size: 14px; }

  #log { flex: 1 1 auto; overflow-y: auto; border: 2px solid var(--ink); padding: 10px; min-height: 0; margin-top: 8px; }
  #log:empty::before { content: "Answers appear here."; color: var(--muted); font-size: 14px; }
  .msg { margin: 0 0 12px; padding: 8px 10px; border-left: 6px solid var(--ink); }
  .msg.you { border-left-color: var(--blue); background: #f2f2f2; }
  .msg.bot { border-left-color: var(--green); }
  .msg .who { font-weight: 700; font-size: 12px; text-transform: uppercase;
              letter-spacing: .04em; margin-bottom: 3px; }
  .msg p { margin: 0; white-space: pre-wrap; }
  .chips { margin-top: 6px; display: flex; flex-wrap: wrap; gap: 6px; }
  .chip { font-size: 12px; border: 2px solid var(--ink); padding: 1px 6px;
          display: inline-flex; align-items: center; gap: 5px; }
  .dot { width: 9px; height: 9px; border-radius: 50%; display: inline-block; }
  .dot.green { background: var(--green); } .dot.vermil { background: var(--vermil); }
  .context { margin-top: 6px; border: 2px dashed var(--muted); padding: 8px;
             font-family: ui-monospace, Menlo, Consolas, monospace; font-size: 12px; white-space: pre-wrap; }

  .ex-row { margin: 8px 0; flex: 0 0 auto; }
  .ex { background: var(--paper); border: 2px solid var(--ink); padding: 4px 8px;
        margin: 0 5px 5px 0; cursor: pointer; font-size: 12px; }
  form { display: flex; gap: 8px; flex: 0 0 auto; }
  #q { flex: 1; font-size: 15px; padding: 8px 10px; border: 2px solid var(--ink); }
  button.send { background: var(--ink); color: var(--paper); border: 2px solid var(--ink);
                font-size: 15px; font-weight: 700; padding: 8px 16px; cursor: pointer; }
  button.send[disabled] { opacity: .5; cursor: progress; }
  #q:focus-visible, button:focus-visible, .ex:focus-visible { outline: 3px solid var(--blue); outline-offset: 2px; }

  @media (max-width: 900px) {
    .split { flex-direction: column; }
    .chat { flex-basis: auto; max-width: none; min-width: 0; }
    .dash { border-right: 0; border-bottom: 3px solid var(--ink); min-height: 50vh; }
  }
</style>
</head>
<body>
<header>
  <h1>Bagging Line 1</h1>
  <span class="sub">Brightfield Fertilizer (fictional) &middot; live dashboard + ask the data &middot; BACKEND_NOTE</span>
</header>

<div class="split">
  <section class="dash" aria-label="Main">
    <div class="maintabs" role="tablist" aria-label="Main views">
      <button class="mtab" id="mt-dash" role="tab" aria-selected="true" aria-controls="mp-dash">Dashboard</button>
      <button class="mtab" id="mt-data" role="tab" aria-selected="false" aria-controls="mp-data">Data</button>
    </div>
    <div class="mpanel" id="mp-dash" role="tabpanel" data-active="true">
      <iframe title="Grafana dashboard" src="GRAFANA_EMBED_URL"></iframe>
      <div class="cap">If this is blank, check that Grafana is up (<code>docker compose ps</code>), or open
        <a href="http://localhost:3000" target="_blank" rel="noopener">Grafana directly</a>.</div>
    </div>
    <div class="mpanel" id="mp-data" role="tabpanel" data-active="false">
      <div class="datapick" id="datapick"></div>
      <div style="padding:0 8px 4px; flex:0 0 auto;">
        <a id="dl" class="dbtn" style="display:none; text-decoration:none;" download>&#x2B07; Download CSV</a>
        <span id="dlnote" style="font-size:12px; color:var(--muted);"></span>
      </div>
      <div id="datatable">Pick a table above.</div>
    </div>
  </section>

  <section class="chat" aria-label="Ask the data">
    <div class="toolbar">
      <label class="switch"><input type="checkbox" id="showctx"> Show the data the model saw</label>
    </div>
    <form id="ask">
      <label for="q" style="position:absolute;left:-9999px;">Your question</label>
      <input id="q" type="text" autocomplete="off" placeholder="Ask about the line, a lot, a shift…">
      <button class="send" type="submit">Ask</button>
    </form>
    <div class="ex-row">
      <button class="ex">Is the bagging line healthy right now?</button>
      <button class="ex">How many short bags are in the current lot?</button>
      <button class="ex">Which lots had short fills in the last week, and on which shift?</button>
      <button class="ex">How much product did we give away this week?</button>
      <button class="ex">Why are fill times going up?</button>
    </div>
    <div id="log" aria-live="polite"></div>
  </section>
</div>

<script>
  // --- Main tabs: Dashboard | Data ---
  const MTABS = [["mt-dash","mp-dash"],["mt-data","mp-data"]];
  function mselect(id){ for(const [t,p] of MTABS){ const on=t===id;
    document.getElementById(t).setAttribute("aria-selected",on);
    document.getElementById(p).setAttribute("data-active",on);} }
  MTABS.forEach(([t])=>document.getElementById(t).addEventListener("click",()=>mselect(t)));

  // --- Data tab: pick a governance/evidence table, render rows ---
  const DATA_TABLES = [["bag_fill","Bags"],["production_lot","Lots"],["alarm_event","Alarms"],
                       ["downtime_event","Downtime"],["chat_audit","Chat log (evidence)"],["eval_result","Eval results"]];
  const datapick = document.getElementById("datapick");
  DATA_TABLES.forEach(([key,label])=>{
    const b=document.createElement("button"); b.className="dbtn"; b.textContent=label;
    b.setAttribute("aria-pressed","false");
    b.addEventListener("click",()=>loadTable(key,b)); datapick.appendChild(b);
  });
  const dl=document.getElementById("dl"), dlnote=document.getElementById("dlnote");
  async function loadTable(key,btn){
    datapick.querySelectorAll(".dbtn").forEach(x=>x.setAttribute("aria-pressed", x===btn));
    dl.href="/data.csv?table="+encodeURIComponent(key); dl.style.display="inline-block";
    const el=document.getElementById("datatable"); el.textContent="Loading…";
    try{
      const d=await (await fetch("/data?table="+encodeURIComponent(key))).json();
      if(d.error){ el.textContent="["+d.error+"]"; dlnote.textContent=""; return; }
      if(!d.rows||!d.rows.length){ el.textContent="No rows yet."; dlnote.textContent=""; return; }
      dlnote.textContent=" showing "+d.rows.length+" most-recent rows (download for full history)";
      let h='<table class="grid"><thead><tr>'+d.columns.map(c=>'<th>'+esc(c)+'</th>').join('')+'</tr></thead><tbody>';
      for(const r of d.rows){ h+='<tr>'+r.map(v=>{const s=String(v??''); return '<td title="'+esc(s)+'">'+esc(s)+'</td>';}).join('')+'</tr>'; }
      el.innerHTML=h+'</tbody></table>';
    }catch(e){ el.textContent="[request failed: "+e+"]"; }
  }

  const log = document.getElementById("log");
  const showctx = document.getElementById("showctx");
  showctx.addEventListener("change", ()=>document.querySelectorAll(".context")
      .forEach(c=>c.style.display = showctx.checked ? "block":"none"));

  function esc(s){ const d=document.createElement("div"); d.textContent=s??""; return d.innerHTML; }
  function addMsg(cls, who, text){
    const el=document.createElement("div"); el.className="msg "+cls;
    el.innerHTML='<div class="who">'+esc(who)+'</div><p>'+esc(text)+'</p>';
    log.appendChild(el); log.scrollTop=log.scrollHeight; return el;
  }
  async function ask(question){
    addMsg("you","You",question);
    const pending=addMsg("bot","Assistant","…thinking…");
    const btn=document.querySelector(".send"); btn.disabled=true;
    try{
      const r=await fetch("/ask",{method:"POST",headers:{"Content-Type":"application/json"},
                                  body:JSON.stringify({question})});
      const d=await r.json();
      pending.querySelector("p").textContent = d.answer || d.error || "(no answer)";
      const onprem = d.left_network===false;
      const chips=document.createElement("div"); chips.className="chips";
      chips.innerHTML =
        '<span class="chip"><span class="dot '+(onprem?"green":"vermil")+'"></span>'+
          (onprem?"On-prem, nothing left":"Cloud, data left network")+'</span>'+
        '<span class="chip">'+esc(d.model||"")+'</span>'+
        '<span class="chip">$'+(d.cost!=null?Number(d.cost).toFixed(4):"?")+'</span>'+
        '<span class="chip">'+(d.latency_ms!=null?d.latency_ms+" ms":"")+'</span>'+
        '<span class="chip"><span class="dot '+((d.data_age_s!=null&&d.data_age_s>60)?"vermil":"green")+'"></span>data '+
          (d.data_age_s!=null?Math.round(d.data_age_s)+"s old":"age n/a")+'</span>';
      pending.appendChild(chips);
      if(d.context_sent){
        const c=document.createElement("div"); c.className="context";
        c.style.display = showctx.checked ? "block":"none";
        c.textContent = "Data sent to the model (exactly what it saw):\\n\\n"+d.context_sent;
        pending.appendChild(c);
      }
    }catch(e){ pending.querySelector("p").textContent="[request failed: "+e+"]"; }
    btn.disabled=false;
  }
  document.getElementById("ask").addEventListener("submit",e=>{
    e.preventDefault();
    const q=document.getElementById("q").value.trim();
    if(!q) return; document.getElementById("q").value=""; ask(q);
  });
  document.querySelectorAll(".ex").forEach(b=>b.addEventListener("click",()=>ask(b.textContent)));
</script>
</body>
</html>
"""


def run_pipeline(question):
    return ch.answer_and_log(question, user_id="web")


class Handler(BaseHTTPRequestHandler):
    def log_message(self, *a):  # quiet
        pass

    def _send(self, code, ctype, body):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)

    def do_GET(self):
        path = urlparse(self.path).path
        if path == "/":
            note = ("local model, nothing leaves the building" if cfg.LLM_BACKEND != "anthropic"
                    else "cloud model, questions + data leave the network")
            html = PAGE.replace("GRAFANA_EMBED_URL", GRAFANA_EMBED).replace("BACKEND_NOTE", note)
            self._send(200, "text/html; charset=utf-8", html.encode())
        elif path == "/data":
            qs = parse_qs(urlparse(self.path).query)
            entry = DATA_TABLES.get(qs.get("table", [""])[0])
            if not entry:
                self._send(400, "application/json", b'{"error":"unknown table"}')
                return
            self._send(200, "application/json",
                       json.dumps(db.query_rows(entry[1] + f" LIMIT {DISPLAY_LIMIT}")).encode())
        elif path == "/data.csv":
            qs = parse_qs(urlparse(self.path).query)
            key = qs.get("table", [""])[0]
            entry = DATA_TABLES.get(key)
            if not entry:
                self._send(400, "text/plain", b"unknown table")
                return
            data = db.query_rows(entry[1] + f" LIMIT {EXPORT_LIMIT}")
            buf = io.StringIO()
            w = csv.writer(buf)
            w.writerow(data.get("columns", []))
            for r in data.get("rows", []):
                w.writerow(r)
            body = buf.getvalue().encode("utf-8")
            self.send_response(200)
            self.send_header("Content-Type", "text/csv; charset=utf-8")
            self.send_header("Content-Disposition", f'attachment; filename="{key}.csv"')
            self.send_header("Content-Length", str(len(body)))
            self.end_headers()
            self.wfile.write(body)
        else:
            self._send(404, "text/plain", b"not found")

    def do_POST(self):
        if self.path.split("?")[0] != "/ask":
            self._send(404, "text/plain", b"not found")
            return
        try:
            n = int(self.headers.get("Content-Length", 0))
            question = json.loads(self.rfile.read(n) or b"{}").get("question", "").strip()
            if not question:
                self._send(400, "application/json", b'{"error":"empty question"}')
                return
            result = run_pipeline(question)
            self._send(200, "application/json", json.dumps(result).encode())
        except Exception as e:
            self._send(200, "application/json", json.dumps({"error": str(e)}).encode())


class FastServer(ThreadingHTTPServer):
    """Skip the reverse-DNS getfqdn() call in the default server_bind, which
    can hang for seconds (or until Ctrl+C) on some macOS network configs."""
    def server_bind(self):
        socketserver.TCPServer.server_bind(self)
        host, port = self.server_address[:2]
        self.server_name = host
        self.server_port = port


def main():
    print(f"chat web page:  http://localhost:{PORT}")
    print(f"backend: {cfg.LLM_BACKEND} ("
          + (f"local model {cfg.OLLAMA_MODEL})" if cfg.LLM_BACKEND != "anthropic" else f"cloud {cfg.ANTHROPIC_MODEL})"))
    print("the poller should be running so there's fresh data. Ctrl+C to stop.")
    FastServer((BIND, PORT), Handler).serve_forever()


if __name__ == "__main__":
    main()
