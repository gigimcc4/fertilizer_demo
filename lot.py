"""
start a new production lot
--------------------------
closes the lot that is running and opens a new one. every bag after this
is recorded against the new lot (the poller picks it up within 30 s).

    python3 lot.py 15-0-15-50              # ./run.sh lot 15-0-15-50
    python3 lot.py 10-10-10-50 --bags 3000

products are in the product table (sql/schema.sql).
"""

import argparse

import config as cfg
import db

ap = argparse.ArgumentParser()
ap.add_argument("product_id", help="e.g. 10-10-10-50 or 15-0-15-50")
ap.add_argument("--bags", type=int, default=2000, help="bags planned for this lot")
args = ap.parse_args()

known = db.query_rows("SELECT product_id FROM product")
ids = [r[0] for r in known.get("rows", [])]
if known.get("error"):
    raise SystemExit(f"can't reach the sql store: {known['error']}")
if args.product_id not in ids:
    raise SystemExit(f"unknown product '{args.product_id}'. known: {', '.join(ids)}")

lot = db.start_lot(cfg.ASSET_ID, args.product_id, args.bags)
print(f"new lot {lot} ({args.product_id}, {args.bags} bags planned). the previous lot is closed.")
