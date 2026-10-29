-- =====================================================================
-- fertilizer_demo: relational / sql layer (TimescaleDB / PostgreSQL)
-- =====================================================================
-- InfluxDB holds the raw tick stream ("what was the silo level at 10:03:04").
-- this database holds the context you join against and the record of what
-- happened:
--
--   * which line, which lot, which shift
--   * every bag: net weight, fill time, in spec or not
--   * alarm and downtime events
--   * every question asked of the chat layer, with the exact data sent
--
-- the bag + lot tables are the traceability story: when an inspector or a
-- customer asks about a lot, you can show every bag that went into it.
--
-- auto-loaded by the timescaledb container on first start
-- (mounted into /docker-entrypoint-initdb.d/).
-- to point a plant at Microsoft SQL Server instead, the tables map 1:1;
-- only types (BIGSERIAL -> IDENTITY, TIMESTAMPTZ -> DATETIME2,
-- BOOLEAN -> BIT) and the driver in db.py change.
-- =====================================================================

CREATE EXTENSION IF NOT EXISTS timescaledb;

-- ---------------------------------------------------------------------
-- 1. asset registry
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS asset (
    asset_id     TEXT PRIMARY KEY,          -- 'bagline1'
    name         TEXT NOT NULL,
    asset_type   TEXT NOT NULL,             -- 'line' | 'machine' | 'sensor'
    location     TEXT,
    ideal_rate   NUMERIC,                   -- ideal bags per minute, for OEE performance
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- ---------------------------------------------------------------------
-- 2. product + production lot
--    a lot is one run of one product. the label promises a net weight and
--    a guaranteed analysis (N-P-K). the fill line controls the weight; the
--    analysis comes from blending upstream, so it is recorded, not measured here.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS product (
    product_id         TEXT PRIMARY KEY,    -- '10-10-10-50'
    name               TEXT NOT NULL,       -- 'all-purpose 10-10-10'
    guaranteed_analysis TEXT,               -- 'total N 10%, available P2O5 10%, soluble K2O 10%'
    label_net_lb       NUMERIC NOT NULL     -- 50
);

CREATE TABLE IF NOT EXISTS production_lot (
    lot_id       TEXT PRIMARY KEY,          -- 'L261029-A'
    asset_id     TEXT REFERENCES asset(asset_id),
    product_id   TEXT REFERENCES product(product_id),
    bags_target  INTEGER,
    started_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    ended_at     TIMESTAMPTZ               -- NULL = the lot running now
);

-- ---------------------------------------------------------------------
-- 3. shifts
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS shift (
    shift_id   TEXT PRIMARY KEY,            -- 'A' | 'B' | 'C'
    name       TEXT NOT NULL,
    start_hour SMALLINT NOT NULL,           -- 0-23, plant local time
    end_hour   SMALLINT NOT NULL
);

-- ---------------------------------------------------------------------
-- 4. bag fill record (one row per bag off the scale)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bag_fill (
    bag_id       BIGSERIAL,
    ts           TIMESTAMPTZ NOT NULL DEFAULT now(),
    asset_id     TEXT REFERENCES asset(asset_id),
    lot_id       TEXT REFERENCES production_lot(lot_id),
    shift_id     TEXT REFERENCES shift(shift_id),
    net_lb       NUMERIC NOT NULL,          -- from the scale
    fill_time_s  NUMERIC,                   -- how long the gate was open
    result       TEXT NOT NULL,             -- 'ok' | 'short' | 'over'
    giveaway_lb  NUMERIC NOT NULL DEFAULT 0,-- product over the label weight, given away free
    PRIMARY KEY (bag_id, ts)
);
SELECT create_hypertable('bag_fill', 'ts', if_not_exists => TRUE);
CREATE INDEX IF NOT EXISTS idx_bag_fill_lot ON bag_fill (lot_id, ts DESC);

-- ---------------------------------------------------------------------
-- 5. alarm events
--    every time the deterministic edge logic raises a flag it lands here
--    once, on the transition into the alarm, with a type and a reason.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS alarm_event (
    alarm_id    BIGSERIAL PRIMARY KEY,
    ts          TIMESTAMPTZ NOT NULL DEFAULT now(),
    asset_id    TEXT REFERENCES asset(asset_id),
    lot_id      TEXT,
    alarm_type  TEXT NOT NULL,             -- 'short_fill' | 'overfill' | 'fill_timeout' | 'spc' | 'starved' | 'silo_low' | 'downtime'
    field       TEXT,                      -- 'net_lb' | 'fill_time_s' | 'silo_pct' ...
    value       NUMERIC,
    z_score     NUMERIC,
    detail      TEXT,
    source      TEXT NOT NULL DEFAULT 'auto'   -- 'auto' (edge logic) | 'operator'
);
CREATE INDEX IF NOT EXISTS idx_alarm_event_ts ON alarm_event (ts DESC);

-- ---------------------------------------------------------------------
-- 6. downtime events (start, end, duration, reason)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS downtime_event (
    downtime_id  BIGSERIAL PRIMARY KEY,
    asset_id     TEXT REFERENCES asset(asset_id),
    lot_id       TEXT,
    started_at   TIMESTAMPTZ NOT NULL,
    ended_at     TIMESTAMPTZ,
    duration_s   INTEGER,
    reason_code  TEXT,                      -- 'stopped' | 'starved' | 'fill_fault' ...
    detail       TEXT,
    source       TEXT NOT NULL DEFAULT 'auto'
);
CREATE INDEX IF NOT EXISTS idx_downtime_started ON downtime_event (started_at DESC);

-- ---------------------------------------------------------------------
-- 7. alarm acknowledgments (who saw it, when, what they noted)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS alarm_ack (
    ack_id     BIGSERIAL PRIMARY KEY,
    alarm_id   BIGINT REFERENCES alarm_event(alarm_id),
    acked_by   TEXT NOT NULL,
    acked_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    note       TEXT
);

-- ---------------------------------------------------------------------
-- 8. chat audit
--    every question asked of the model, with the EXACT data sent to it.
--    for a cloud model that snippet is what left the building.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS chat_audit (
    audit_id       BIGSERIAL PRIMARY KEY,
    ts             TIMESTAMPTZ NOT NULL DEFAULT now(),
    user_id        TEXT,
    question       TEXT NOT NULL,
    context_sent   TEXT NOT NULL,
    answer         TEXT,
    model          TEXT NOT NULL,
    window_minutes INTEGER,
    input_tokens   INTEGER,
    output_tokens  INTEGER,
    cache_write_tokens INTEGER DEFAULT 0,
    cache_read_tokens  INTEGER DEFAULT 0,
    cost_usd       NUMERIC DEFAULT 0,
    left_network   BOOLEAN NOT NULL DEFAULT TRUE   -- TRUE = cloud model, FALSE = local (Ollama)
);
CREATE INDEX IF NOT EXISTS idx_chat_audit_ts ON chat_audit (ts DESC);

-- ---------------------------------------------------------------------
-- 9. poller heartbeat (is the edge loop alive and writing?)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS poller_heartbeat (
    hb_id           BIGSERIAL PRIMARY KEY,
    ts              TIMESTAMPTZ NOT NULL DEFAULT now(),
    asset_id        TEXT,
    status          TEXT NOT NULL,          -- 'ok' | 'degraded'
    influx_write_ok BOOLEAN NOT NULL,
    tick            BIGINT,
    detail          TEXT
);
CREATE INDEX IF NOT EXISTS idx_heartbeat_ts ON poller_heartbeat (ts DESC);

-- =====================================================================
-- evaluation layer (score the chat layer against answers computed from the data)
-- =====================================================================
CREATE TABLE IF NOT EXISTS golden_qa (
    golden_id     BIGSERIAL PRIMARY KEY,
    tag           TEXT,
    question      TEXT NOT NULL,
    golden_answer TEXT NOT NULL,
    must_include  TEXT,
    notes         TEXT
);

CREATE TABLE IF NOT EXISTS eval_run (
    run_id         BIGSERIAL PRIMARY KEY,
    ts             TIMESTAMPTZ NOT NULL DEFAULT now(),
    model          TEXT NOT NULL,
    n_items        INTEGER,
    mean_score     NUMERIC,
    total_cost_usd NUMERIC,
    notes          TEXT
);

CREATE TABLE IF NOT EXISTS eval_result (
    result_id     BIGSERIAL PRIMARY KEY,
    run_id        BIGINT REFERENCES eval_run(run_id),
    golden_id     BIGINT REFERENCES golden_qa(golden_id),
    model         TEXT NOT NULL,
    question      TEXT,
    golden_answer TEXT,
    model_answer  TEXT,
    score         NUMERIC,
    passed        BOOLEAN,
    input_tokens  INTEGER,
    output_tokens INTEGER,
    cost_usd      NUMERIC,
    latency_ms    INTEGER
);
CREATE INDEX IF NOT EXISTS idx_eval_result_run ON eval_result (run_id);

-- =====================================================================
-- seed data (a made-up company; nothing here describes an existing plant)
-- =====================================================================
INSERT INTO asset (asset_id, name, asset_type, location, ideal_rate)
VALUES ('bagline1', 'Bagging Line 1', 'line', 'Brightfield Fertilizer (fictional) / bagging room', 9)
ON CONFLICT (asset_id) DO NOTHING;

INSERT INTO product (product_id, name, guaranteed_analysis, label_net_lb) VALUES
    ('10-10-10-50', 'all-purpose 10-10-10, 50 lb',
     'total N 10%, available P2O5 10%, soluble K2O 10%', 50),
    ('15-0-15-50',  'pasture 15-0-15, 50 lb',
     'total N 15%, soluble K2O 15%', 50)
ON CONFLICT (product_id) DO NOTHING;

INSERT INTO shift (shift_id, name, start_hour, end_hour) VALUES
    ('A', 'day',   6, 14),
    ('B', 'swing', 14, 22),
    ('C', 'night', 22, 6)
ON CONFLICT (shift_id) DO NOTHING;

-- the lot running when you first start the stack. the poller attaches every
-- new bag to whichever lot has ended_at IS NULL. start a new lot with:
--   ./run.sh lot 15-0-15-50
INSERT INTO production_lot (lot_id, asset_id, product_id, bags_target, started_at)
VALUES ('L-START-01', 'bagline1', '10-10-10-50', 2000, now())
ON CONFLICT (lot_id) DO NOTHING;

-- reference price list, mirrors pricing.py so cost is queryable in sql too
CREATE TABLE IF NOT EXISTS model_pricing (
    model            TEXT PRIMARY KEY,
    input_per_mtok   NUMERIC,
    output_per_mtok  NUMERIC,
    is_local         BOOLEAN DEFAULT FALSE
);
INSERT INTO model_pricing (model, input_per_mtok, output_per_mtok, is_local) VALUES
    ('claude-opus-5',              5.00, 25.00, FALSE),
    ('claude-sonnet-5',            2.00, 10.00, FALSE),
    ('claude-haiku-4-5-20251001',  1.00,  5.00, FALSE),
    ('ollama/llama3.2',            0.00,  0.00, TRUE),
    ('ollama/mistral',             0.00,  0.00, TRUE)
ON CONFLICT (model) DO NOTHING;
