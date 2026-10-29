#!/usr/bin/env bash
# ---------------------------------------------------------------------
# optional: run the python scripts on your own computer instead of in docker
# (handy for editing and debugging). creates .venv and installs the exact
# pinned versions from requirements.lock.txt.
#
#   ./setup.sh
#   source .venv/bin/activate
#   set -a; source .env; set +a      # load your settings
#   export PLC_HOST=127.0.0.1 PG_HOST=localhost INFLUX_URL=http://localhost:8086 OLLAMA_URL=http://localhost:11434
#   python3 plant_sim.py             # etc.
#
# if you do this, stop the same service in docker first so two copies
# don't run at once, e.g.  docker compose stop plant
# ---------------------------------------------------------------------
set -e

# Run from this script's own folder, so .venv lands in the project root
# regardless of where you invoke setup.sh from.
cd "$(dirname "$0")"

# the Anthropic SDK (pydantic) needs Python 3.10 or newer.
# macOS often ships an older python3, so pick the newest one available.
pick_python() {
  for p in python3.13 python3.12 python3.11 python3.10 python3; do
    if command -v "$p" >/dev/null 2>&1; then
      if "$p" -c 'import sys; raise SystemExit(0 if sys.version_info >= (3,10) else 1)' 2>/dev/null; then
        echo "$p"; return 0
      fi
    fi
  done
  return 1
}

PYBIN="$(pick_python)" || {
  echo "ERROR: Need Python 3.10 or newer, but none was found."
  echo "Your default python3 is: $(python3 --version 2>&1)"
  echo ""
  echo "install a newer python, then run ./setup.sh again:"
  echo "    brew install python@3.12        # if you use Homebrew"
  echo "    # or download from https://www.python.org/downloads/"
  exit 1
}

echo ">> Using $PYBIN ($($PYBIN --version 2>&1))"
echo ">> Creating virtual environment in .venv/ ..."
"$PYBIN" -m venv .venv

echo ">> Upgrading pip ..."
./.venv/bin/pip install --quiet --upgrade pip

echo ">> Installing pinned dependencies from requirements.lock.txt ..."
./.venv/bin/pip install --quiet -r requirements.lock.txt

echo ""
echo "Done. Everyone who runs this now has identical package versions."
echo "Activate the environment with:"
echo "    source .venv/bin/activate     (macOS / Linux)"
echo "    .venv\\Scripts\\activate        (Windows PowerShell)"
echo ""
echo "see the top of setup.sh for how to point the scripts at the docker containers."
