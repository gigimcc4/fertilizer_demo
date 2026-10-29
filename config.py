"""
one place for settings
----------------------
every script imports from here. values come from environment variables
(docker compose reads them from .env), with defaults that work when you run
the python scripts on your own computer against the docker containers.

copy .env.example to .env and change values there, not here.
"""

import os


def _env(name, default):
    return os.environ.get(name, default)


# --- plc (OpenPLC runtime, or soft_plc.py standing in for it) -------------
PLC_HOST = _env("PLC_HOST", "127.0.0.1")
PLC_PORT = int(_env("PLC_PORT", "1502"))

# OpenPLC runtime v4 modbus map (see SETUP.md, "the address map"):
#   %QX0.n  -> coil n                (plc outputs)
#   %MX0.n  -> coil 8192 + n         (bits python writes)
#   %MW n   -> holding register 1024 + n
# if your runtime's modbus settings differ, change the two offsets here.
MX_COIL_OFFSET = int(_env("MX_COIL_OFFSET", "8192"))
MW_REG_OFFSET = int(_env("MW_REG_OFFSET", "1024"))

# outputs the ladder drives (%QX0.0 - %QX0.4)
COIL = {
    "motor": 0,        # %QX0.0  conveyor motor
    "solenoid": 1,     # %QX0.1  silo gate / fill valve
    "run_light": 2,    # %QX0.2
    "fill_light": 3,   # %QX0.3
    "full_light": 4,   # %QX0.4
}

# inputs python writes (%MX0.0 - %MX0.6). in the LogixPro lab these were %IX.
MX = {
    "start": 0,        # %MX0.0  start pushbutton (pulse)
    "stop": 1,         # %MX0.1  stop pushbutton, wired normally closed: TRUE = not pressed
    "prox": 2,         # %MX0.2  bag in position at the fill spout
    "level": 3,        # %MX0.3  level / fill-complete sensor
    "mode_a": 4,       # %MX0.4  continuous: fill, then move on
    "mode_b": 5,       # %MX0.5  fill, then wait for start to release
    "mode_c": 6,       # %MX0.6  no fill, wait for start to release
}

# words the scale writes into plc memory (%MW0 - %MW4)
MW = {
    "bag_net_x10": 0,      # %MW0  last completed bag, net lb x10 (502 = 50.2 lb)
    "bag_count": 1,        # %MW1  bags completed (wraps at 65536)
    "fill_time_ds": 2,     # %MW2  last bag fill time, deciseconds (52 = 5.2 s)
    "silo_pct": 3,         # %MW3  silo level, percent
    "flow_x10": 4,         # %MW4  gate flow rate, lb/s x10
}

# --- line / product --------------------------------------------------------
ASSET_ID = _env("ASSET_ID", "bagline1")
LABEL_NET_LB = float(_env("LABEL_NET_LB", "50.0"))     # what the bag says
SHORT_LIMIT_LB = float(_env("SHORT_LIMIT_LB", "49.5"))  # below this = short fill alarm
OVER_LIMIT_LB = float(_env("OVER_LIMIT_LB", "51.5"))    # above this = overfill alarm
IDEAL_BAGS_PER_MIN = float(_env("IDEAL_BAGS_PER_MIN", "9"))
FILL_TIMEOUT_S = float(_env("FILL_TIMEOUT_S", "12"))    # gate open longer than this = alarm

# --- data stores -----------------------------------------------------------
INFLUX_URL = _env("INFLUX_URL", "http://localhost:8086")
INFLUX_TOKEN = _env("INFLUX_TOKEN", "change-me-influx-token")
INFLUX_ORG = _env("INFLUX_ORG", "plantfloor")
INFLUX_BUCKET = _env("INFLUX_BUCKET", "bagline1")

PG_HOST = _env("PG_HOST", "localhost")
PG_PORT = int(_env("PG_PORT", "5432"))
PG_DB = _env("PG_DB", "plant")
PG_USER = _env("PG_USER", "plantfloor")
PG_PASS = _env("PG_PASS", "change-me-pg-password")

# --- chat ------------------------------------------------------------------
LLM_BACKEND = _env("LLM_BACKEND", "ollama").lower()          # ollama | anthropic
OLLAMA_MODEL = _env("OLLAMA_MODEL", "llama3.2")
OLLAMA_URL = _env("OLLAMA_URL", "http://localhost:11434")
ANTHROPIC_MODEL = _env("ANTHROPIC_MODEL", "claude-sonnet-5")
GRAFANA_EMBED_URL = _env(
    "GRAFANA_EMBED_URL",
    "http://localhost:3000/d/fert-bagline1/fertilizer-bagging-line-1"
    "?orgId=1&kiosk&refresh=5s&from=now-30m&to=now",
)

# --- scenario trigger files (./run.sh event <name>) ------------------------
DATA_DIR = _env("DATA_DIR", os.path.join(os.path.dirname(os.path.abspath(__file__)), "data"))
