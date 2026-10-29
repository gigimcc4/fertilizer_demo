#!/usr/bin/env bash
# export the collected data to data/backup-<date>/ : a full sql dump, one csv
# per table, and the InfluxDB telemetry as csv.
#
#   ./run.sh backup        last 30 days of telemetry
#   ./backup.sh -7d        last week
set -e
cd "$(dirname "$0")"
set -a; . ./.env; set +a

OUT="data/backup-$(date +%Y-%m-%d_%H%M%S)"
RANGE="${1:--30d}"
mkdir -p "$OUT"
echo ">> backing up to $OUT (telemetry range $RANGE)"

docker compose exec -T timescaledb pg_dump -U "$PG_USER" -d "$PG_DB" > "$OUT/plant_full.sql"
for t in asset product production_lot shift bag_fill alarm_event downtime_event alarm_ack \
         poller_heartbeat chat_audit golden_qa eval_run eval_result; do
  docker compose exec -T timescaledb psql -U "$PG_USER" -d "$PG_DB" -qAt \
    -c "COPY (SELECT * FROM $t) TO STDOUT WITH CSV HEADER" > "$OUT/$t.csv" || rm -f "$OUT/$t.csv"
done

docker compose exec -T influxdb influx query --org "$INFLUX_ORG" --token "$INFLUX_TOKEN" --raw \
  "from(bucket:\"$INFLUX_BUCKET\") |> range(start: $RANGE)" > "$OUT/influx_telemetry.csv" \
  || echo "   (influx export skipped)"

ls -la "$OUT"
echo ">> data/ is git-ignored, so backups stay on this computer."
