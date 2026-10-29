#!/usr/bin/env bash
# fertilizer_demo: shortcuts. everything runs in docker.
#
#   ./run.sh up              start everything (builds the python image the first time)
#   ./run.sh ps              what's running
#   ./run.sh logs [svc]      follow logs (plant, poller, web, softplc, openplc ...)
#   ./run.sh event <name>    fire a scenario: clog | drift | silo_low | stuck | clear | stop | start
#   ./run.sh lot <product>   start a new lot, e.g. ./run.sh lot 15-0-15-50
#   ./run.sh seed [--days N] write two weeks of history (once)
#   ./run.sh chat            chat in the terminal (the web page is http://localhost:8600)
#   ./run.sh bench [--mock]  score the chat against eval/golden_answers.yaml
#   ./run.sh backup          export the data to data/backup-<date>/
#   ./run.sh down            stop everything (data is kept)
set -e
cd "$(dirname "$0")"

if [ ! -f .env ]; then
  echo "no .env yet. make one first:   cp .env.example .env"
  exit 1
fi

case "${1:-help}" in
  up)     docker compose up -d --build && docker compose ps && echo && \
          echo "dashboard  http://localhost:3000" && echo "chat       http://localhost:8600" ;;
  down)   docker compose down ;;
  ps)     docker compose ps ;;
  logs)   shift; docker compose logs -f --tail 50 "$@" ;;
  event)  [ -n "$2" ] || { echo "usage: ./run.sh event <clog|drift|silo_low|stuck|clear|stop|start>"; exit 1; }
          mkdir -p data && : > "data/event_$2.flag" && echo "event '$2' sent. watch: ./run.sh logs plant poller" ;;
  lot)    shift; docker compose exec poller python lot.py "$@" ;;
  seed)   shift; docker compose exec poller python backfill.py "$@" ;;
  chat)   docker compose exec -it web python chat_health.py ;;
  bench)  shift; docker compose exec web python eval/benchmark.py "$@" ;;
  backup) shift; bash ./backup.sh "$@" ;;
  *)      sed -n '2,15p' "$0" ;;
esac
