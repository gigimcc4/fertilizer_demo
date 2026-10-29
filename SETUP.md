# setup

step by step, from nothing to a running line, a dashboard and a chat. each step ends with what you should see. if you don't see it, check **troubleshooting** at the bottom.

## what you need

| | needed for | get it |
| --- | --- | --- |
| Docker Desktop | everything | https://www.docker.com/products/docker-desktop/ |
| a browser | dashboard and chat | |
| Ollama | the chat, with a local model (optional) | https://ollama.com |
| OpenPLC Editor | running the ladder in OpenPLC (optional, path B) | https://autonomylogic.com/ |

python, the databases, Grafana and the PLC runtime all come as containers. you don't install them.

## 1. get the code and make your settings file

```
git clone <this repo>
cd fertilizer_demo
cp .env.example .env
```

open `.env` and change the four `change-me-...` values (InfluxDB password and token, postgres password, Grafana password). any text works. the InfluxDB password needs at least 8 characters.

**set these before the first start.** InfluxDB and TimescaleDB only read them the first time they create their data. if you change them later, see "changed a password" in troubleshooting.

## 2. start it (path A: soft PLC, nothing else to install)

`.env` starts with the soft PLC: the silo fill ladder running in python, with the same addresses as OpenPLC. open Docker Desktop, wait until it says running, then:

```
./run.sh up
```

the first time takes a few minutes (it downloads the images and builds the python one). then:

```
./run.sh ps
```

**you should see** `softplc`, `plant`, `poller`, `web`, `influxdb`, `timescaledb` and `grafana`, all `Up` (or `running`).

```
./run.sh logs plant poller
```

**you should see** lines like `bag 3: 50.3 lb in 4.2 s (silo 85%)` from plant, and `run=True gate=... bags=3 (short 0, over 0)` from poller, about every 7 seconds. Ctrl+C stops following the logs (the line keeps running).

## 3. the dashboard (Grafana)

open http://localhost:3000.

**you should see** "Fertilizer Bagging Line 1" with OEE, silo level, bag weight and fill time filling in. you're viewing without logging in, which is set up for this computer only. to edit panels, sign in (bottom left) with `GRAFANA_ADMIN_USER` / `GRAFANA_ADMIN_PASSWORD` from `.env`.

nothing to click to connect data: the InfluxDB and TimescaleDB data sources and the dashboard load from `grafana/` on start. if you want to see them, go to Connections > Data sources.

time range is top right. "Last 30 minutes" for live, "Last 14 days" after you load the history (step 5).

## 4. the chat

### local model (default, nothing leaves the building)

1. install Ollama and open it
2. in a terminal: `ollama pull llama3.2` (about 2 GB, once)
3. open http://localhost:8600 and click one of the example questions

**you should see** the dashboard on the left, the chat on the right, and an answer that starts "As of ...". the chip under it says "On-prem, nothing left". the container reaches Ollama on your computer through `host.docker.internal`.

a small local model gives shorter, rougher answers than a large cloud model. that trade is part of the demo: `./run.sh bench` puts a number on it (step 8).

### Claude API instead

put your key in `.env` and switch the backend:

```
LLM_BACKEND=anthropic
ANTHROPIC_API_KEY=sk-ant-...
```

then `docker compose up -d web` to restart the chat with the new settings. the chip now says the data left the network, and `chat_audit` records it.

### terminal chat

```
./run.sh chat
```

## 5. load two weeks of history (once)

```
./run.sh seed
```

**you should see** one line per day, like `2026-10-26 L261026 10-10-10-50  bags= 7859 short=...`, then `done`. set Grafana to "Last 14 days". the lots table now has a row per day, and the chat can answer about past lots and shifts.

run it once. running it again adds a second copy of the history.

## 6. scenarios

```
./run.sh event drift
./run.sh logs poller
```

**you should see**, within a couple of minutes, `ALARM spc: bag weight ...` and then `ALARM short_fill: bag 48.6 lb ...`. then:

```
./run.sh event clear
```

all the scenarios are listed in the README. `clog` takes about three minutes to show in the fill time panel.

## 7. a new lot

```
./run.sh lot 15-0-15-50
```

closes the current lot and opens a new one. the poller picks it up within 30 seconds. products are in the `product` table in `sql/schema.sql`.

## 8. score the chat

```
./run.sh bench --mock     # proves the harness, no model
./run.sh bench            # uses LLM_BACKEND from .env
```

each question in `eval/golden_answers.yaml` goes through the same pipeline as the chat. grounded questions are checked against numbers computed from the database. results land in `eval_run` and `eval_result` (and the Data tab).

---

## path B: your ladder in OpenPLC

this runs `plc/` (the silo fill ladder from the lab) in the OpenPLC runtime instead of the soft PLC. everything else stays the same.

### B1. switch the PLC in .env

```
# COMPOSE_PROFILES=softplc
# PLC_HOST=softplc
COMPOSE_PROFILES=openplc
PLC_HOST=openplc
```

then:

```
docker compose down
./run.sh up
```

**you should see** `openplc` in `./run.sh ps` instead of `softplc`. the plant and poller logs say `plc not reachable` or show no bags yet. that's expected: the runtime is empty until you upload the ladder.

### B2. upload the ladder with OpenPLC Editor

1. open OpenPLC Editor, then open the `plc` folder in this repo as the project
2. Device > Configuration: board **OpenPLC Runtime v4**, IP `127.0.0.1`, Connect. log in to the runtime when asked
3. check the Modbus server (Device > Modbus, or the server under `devices/servers`): **enabled**, port **1502**. this is already set in `plc/devices/servers/modbus.json`
4. Build and upload, then start the PLC (play button)
5. open the debugger if you want to watch the rungs

**you should see**, within a few seconds, `bag 1: ...` in `./run.sh logs plant`, and the debugger showing `prox`, `solenoid`, `full_light` and `motor` taking turns.

### B3. the address map (where the bits live in modbus)

python can't write a PLC's physical inputs (`%IX`) over modbus. it can write PLC memory (`%MX`, `%MW`). so the inputs plant_sim drives are `%MX` here, where the lab had `%IX`. the outputs stay `%QX`.

OpenPLC runtime v4 lays out modbus in order, using the buffer sizes in `plc/devices/servers/modbus.json`:

| PLC address | modbus table | first address | with this project's settings |
| --- | --- | --- | --- |
| `%QX0.0` ... | coils | 0 | `%QX0.0` = coil 0 |
| `%MX0.0` ... | coils | right after the `%QX` bits (`qxBits`) | `%MX0.0` = coil 8192 |
| `%IX0.0` ... | discrete inputs (read only) | 0 | not used |
| `%QW0` ... | holding registers | 0 | not used |
| `%MW0` ... | holding registers | right after the `%QW` words (`qwCount`) | `%MW0` = holding 1024 |

the Editor's Modbus server screen has an **Address Mapping Reference** table computed from your buffer sizes. that table is the source of truth. if you change the buffer sizes, change `MX_COIL_OFFSET` and `MW_REG_OFFSET` in `config.py` (or `.env`) to match. reference: [OpenPLC modbus addressing](https://edge.autonomylogic.com/docs/openplc-editor/communication/modbus/addressing).

the full tag list is in the README under "the ladder".

### B4. back to the soft PLC

swap the two lines in `.env` back, then `docker compose down && ./run.sh up`.

---

## the pieces, if you want to look inside

| what | where | sign in |
| --- | --- | --- |
| dashboard | http://localhost:3000 | view without signing in. edit: Grafana admin from `.env` |
| chat | http://localhost:8600 | none |
| InfluxDB | http://localhost:8086 | `INFLUX_ADMIN_USER` / `INFLUX_ADMIN_PASSWORD`. Data Explorer > bucket `bagline1` > `fill_status` or `bag` |
| TimescaleDB | `docker compose exec timescaledb psql -U plantfloor -d plant` | none from inside the container |
| OpenPLC runtime | port 8443, through OpenPLC Editor | the runtime login |

a few queries to try in psql:

```sql
-- every lot, with short bags and giveaway
SELECT lot_id, count(*) bags, count(*) FILTER (WHERE result='short') short,
       round(sum(giveaway_lb)) giveaway_lb
FROM bag_fill GROUP BY lot_id ORDER BY lot_id;

-- what the chat sent to the model, and whether it left the network
SELECT ts, question, model, left_network, cost_usd FROM chat_audit ORDER BY ts DESC LIMIT 5;
```

every port is published on `127.0.0.1`, so none of this is reachable from other computers on your network.

## running the python on your computer instead

for editing and debugging: `./setup.sh` makes a `.venv` with the pinned packages. the top of `setup.sh` shows how to point the scripts at the containers. stop the matching container first (`docker compose stop plant`) so two copies don't run at once.

## troubleshooting

| problem | fix |
| --- | --- |
| `no .env yet` | `cp .env.example .env` |
| `port is already allocated` | another stack is using the port. the garage door project uses 1502 and 8443; onprem-edge-demo uses 8086, 5432 and 3000. stop it (`docker compose down` in that folder) or `docker ps` to find what's running |
| plant/poller logs say `plc not reachable` | soft PLC: check `softplc` is up in `./run.sh ps`. OpenPLC: the ladder isn't uploaded or started yet (B2), or `PLC_HOST` in `.env` doesn't match `COMPOSE_PROFILES` |
| OpenPLC running, but no bags | the Modbus server is off or not on 1502 (B2 step 3), or the program in the runtime is a different project. upload `plc/` again |
| `Could not verify MD5` in the Editor | click OK, then Build and upload. the runtime was empty |
| dashboard panels say "No data" | wait a minute after start. if the lots table works but the InfluxDB panels don't, the token in `.env` changed after the first start (next row) |
| changed a password or token after the first start | the databases kept the old one. to start fresh: `docker compose down -v` (deletes the data), then `./run.sh up` |
| chat: `model call failed` or connection refused | Ollama isn't running, or the model isn't pulled: `ollama pull llama3.2`. on Linux, Ollama has to listen on all interfaces: `OLLAMA_HOST=0.0.0.0 ollama serve` |
| chat answers `UNKNOWN` | the poller isn't writing. `./run.sh logs poller` |
| the dashboard is blank inside the chat page | open http://localhost:3000 once in the same browser, then reload the chat page |
| line stopped and won't restart | `./run.sh event start`. if a scenario is still active, `./run.sh event clear` first |
| mode C, bag sits at the spout | expected with this ladder (see limits in the README). use mode A or B |
