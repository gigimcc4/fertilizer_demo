# data dictionary

## InfluxDB (bucket `bagline1`)

### measurement `fill_status`, one point per poll (every 0.5 s live, every minute in the backfill)

tag `line` = `bagline1`

| field | meaning |
| --- | --- |
| running | run light on (1/0) |
| motor | conveyor motor (1/0) |
| solenoid | silo gate open (1/0) |
| full_light | bag full latch (1/0) |
| silo_pct | silo level, % |
| flow_lbs | gate flow, lb/s (12.0 clean) |
| bag_count | the scale's raw counter (%MW1, wraps at 65536) |
| bags_total | bags since the poller started |
| short_bags, over_bags | bags outside the limits since the poller started |
| giveaway_lb | product over the label weight since the poller started |
| availability_pct, performance_pct, quality_pct, oee_pct | OEE since the poller started |
| alarm | any alarm condition active this poll (1/0) |
| spc_alarm | an spc anomaly is latched (1/0) |
| net_z, fill_z | z-scores of the latest bag's weight and fill time vs the lot's baseline (its first 30 bags) |

### measurement `bag`, one point per bag

tags `line`, `lot`, `result` (`ok` / `short` / `over`)

| field | meaning |
| --- | --- |
| net_lb | net weight from the scale |
| fill_time_s | how long the gate was open |

## TimescaleDB / postgres (database `plant`)

| table | one row per | key columns |
| --- | --- | --- |
| asset | line | asset_id, name, ideal_rate (bags/min) |
| product | product | product_id, name, guaranteed_analysis, label_net_lb |
| production_lot | lot | lot_id, product_id, started_at, ended_at (NULL = running now) |
| shift | shift | A day 6-14, B swing 14-22, C night 22-6, plant time (`PLANT_TZ`) |
| bag_fill | bag | ts, lot_id, shift_id, net_lb, fill_time_s, result, giveaway_lb. a hypertable on ts |
| alarm_event | alarm, on the transition into it | ts, lot_id, alarm_type, field, value, z_score, detail, source (`auto` / `backfill` / `operator`) |
| downtime_event | stop | started_at, ended_at, duration_s, reason_code (`stopped` / `starved` / `fill_fault` / `maintenance`), lot_id |
| alarm_ack | acknowledgment | alarm_id, acked_by, note. nothing writes it yet: who saw the alarm is the open question in the drift story |
| poller_heartbeat | every 10 s | status, influx_write_ok. proves the edge loop is alive |
| chat_audit | question | question, context_sent (exactly what the model saw), answer, model, tokens, cost_usd, left_network |
| golden_qa, eval_run, eval_result | eval item / run / answer | see `eval/` |
| model_pricing | model | $ per million tokens, mirrors pricing.py |

### alarm types

| alarm_type | raised when |
| --- | --- |
| short_fill | bag net < `SHORT_LIMIT_LB` (49.5) |
| overfill | bag net > `OVER_LIMIT_LB` (51.5) |
| spc | bag weight or fill time more than 3 std devs from the lot's baseline (first 30 bags of the lot) |
| fill_timeout | gate open longer than `FILL_TIMEOUT_S` (12 s) |
| starved | running, no bag for 25 s, gate not open |
| silo_low | silo under 15% |
| downtime | the run light went off |

## PLC tags

see the README, "the ladder".
