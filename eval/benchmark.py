"""
benchmark the chat layer against golden answers
-----------------------------------------------
runs each question in eval/golden_answers.yaml through the SAME pipeline the
chat uses (same data block, same system prompt), then scores it:

  * grounded items: the true value is computed from the stored data
    (eval/ground_truth.py) and the answer must contain it
  * concept items: keyword coverage + word overlap with a reference answer

every result is written to eval_run / eval_result with score and cost, so
"is the local model good enough?" has evidence behind it.

    python3 eval/benchmark.py --mock                   # no model, proves the harness
    python3 eval/benchmark.py                          # whatever LLM_BACKEND is set to
    python3 eval/benchmark.py --backend anthropic      # needs ANTHROPIC_API_KEY

    SELECT model, mean_score, total_cost_usd FROM eval_run ORDER BY ts DESC;

the scoring functions are deliberately simple. swap in your own rubric
(LLM-as-judge, embeddings) and keep the (score 0-1, passed) contract.
"""

import argparse
import os
import re
import sys
import time

import yaml

sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
import config as cfg
import db
import pricing

import ground_truth

GOLDEN_FILE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "golden_answers.yaml")
_NUM_RE = re.compile(r"-?\d+(?:\.\d+)?")


def score_numeric(answer, true_value, tolerance):
    if true_value is None:
        return 0.0, False
    nums = [float(x) for x in _NUM_RE.findall(answer or "")]
    hit = any(abs(n - float(true_value)) <= tolerance for n in nums)
    return (1.0 if hit else 0.0), hit


def score_text(answer, golden, must_include=None):
    ans = (answer or "").lower()
    keys = [k.strip().lower() for k in (must_include or "").split(",") if k.strip()]
    kw = (sum(1 for k in keys if k in ans) / len(keys)) if keys else None
    gold = set((golden or "").lower().split())
    overlap = (len(gold & set(ans.split())) / len(gold)) if gold else 0.0
    final = round(0.7 * kw + 0.3 * overlap, 3) if kw is not None else round(overlap, 3)
    return final, final >= 0.6


def answer_mock(hint):
    return f"Based on the data, the answer is {hint}.", {
        "input_tokens": 40, "output_tokens": 30, "cache_write_tokens": 0, "cache_read_tokens": 0}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--mock", action="store_true", help="stub model, no key, proves the harness")
    ap.add_argument("--backend", choices=["ollama", "anthropic"], help="override LLM_BACKEND")
    args = ap.parse_args()
    if args.backend:
        cfg.LLM_BACKEND = args.backend
    import chat_health as ch   # after the override, so it sees the backend

    with open(GOLDEN_FILE) as f:
        golden = yaml.safe_load(f)

    model = "mock" if args.mock else (cfg.ANTHROPIC_MODEL if cfg.LLM_BACKEND == "anthropic"
                                      else f"ollama/{cfg.OLLAMA_MODEL}")
    run_id = db.start_eval_run(model, len(golden), notes="benchmark.py")
    print(f"\neval run #{run_id}  model={model}  items={len(golden)}\n" + "-" * 72)

    scores, total_cost = [], 0.0
    for item in golden:
        q = item["question"]
        grounded = "truth" in item
        if grounded:
            spec = item["truth"]
            true_value = ground_truth.compute(spec["fn"], spec.get("args"))
            golden_str = f"{true_value}{spec.get('unit', '')}" if true_value is not None else "N/A (no data)"
        else:
            golden_str = (item.get("golden_answer") or "").strip()

        gid = db.upsert_golden(item.get("tag"), q, golden_str, item.get("must_include"), item.get("notes"))
        t0 = time.time()
        if args.mock:
            ans, usage = answer_mock(golden_str)
            model_str = "mock"
        else:
            context, _ = ch.build_prompt_context()
            ans, usage, model_str, _ = ch.ask_llm(q, context)
        latency_ms = int((time.time() - t0) * 1000)

        if grounded:
            sc, passed = score_numeric(ans, true_value, spec.get("tolerance", 0))
        else:
            sc, passed = score_text(ans, golden_str, item.get("must_include"))

        cost = pricing.cost_usd(model_str, usage["input_tokens"], usage["output_tokens"],
                                usage["cache_write_tokens"], usage["cache_read_tokens"])
        scores.append(sc)
        total_cost += cost
        db.record_eval_result(run_id, gid, model_str, q, golden_str, ans, sc, passed,
                              usage["input_tokens"], usage["output_tokens"], cost, latency_ms)
        kind = "grounded" if grounded else "concept"
        print(f"[{'PASS' if passed else 'FAIL'}] {kind:8s} score={sc:.2f} truth={golden_str[:14]:14s} "
              f"${cost:.4f}  {q[:42]}")

    mean = round(sum(scores) / len(scores), 3) if scores else 0.0
    db.finish_eval_run(run_id, mean, round(total_cost, 6))
    print("-" * 72)
    print(f"mean score {mean:.3f}   total cost ${total_cost:.4f}   recorded as eval_run #{run_id}\n")


if __name__ == "__main__":
    main()
