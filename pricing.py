"""
Model pricing + cost math (one place to edit)
---------------------------------------------
Used by BOTH the live chat layer (to log the cost of each question)
and the evaluation harness (to compare cost across models on the golden
set). prices are USD per million tokens, as of Aug 2026.

VERIFY against https://platform.claude.com/docs/en/about-claude/pricing
before quoting numbers to a client - prices change, and the cache
multipliers below are the standard Anthropic ephemeral-cache rates
(cache WRITE = 1.25x input, cache READ = 0.10x input), not a per-model quote.

Local models (Ollama) are listed at $0 - that's the whole point of the
"cost analysis" story: cloud buys you capability per token; local buys you
zero marginal cost and nothing leaving the building. This table lets you
put a number on that trade.
"""

# USD per 1,000,000 tokens
PRICING = {
    # model_id                : (input,  output)
    "claude-opus-5":            (5.00,   25.00),
    "claude-sonnet-5":          (2.00,   10.00),
    "claude-haiku-4-5-20251001":(1.00,    5.00),
    "claude-fable-5":           (10.00,  50.00),
    # Local / on-prem inference - no per-token cost, nothing leaves the building
    "ollama/llama3":            (0.0,     0.0),
    "ollama/llama3.2":          (0.0,     0.0),
    "ollama/llama3.1":          (0.0,     0.0),
    "ollama/mistral":           (0.0,     0.0),
    "ollama/qwen2.5":           (0.0,     0.0),
    "ollama/phi3":              (0.0,     0.0),
    "ollama/gemma2":            (0.0,     0.0),
}

CACHE_WRITE_MULT = 1.25   # writing to the prompt cache costs 1.25x the input rate
CACHE_READ_MULT = 0.10    # reading from the cache costs 0.10x the input rate


def cost_usd(model, input_tokens=0, output_tokens=0,
             cache_write_tokens=0, cache_read_tokens=0):
    """Return the USD cost of one call. Unknown model -> 0.0 (and it's on
    you to add it to PRICING). `input_tokens` should be the NON-cached input
    (Anthropic bills cache reads/writes separately from plain input)."""
    if model not in PRICING:
        return 0.0
    in_rate, out_rate = PRICING[model]
    per = 1_000_000
    return round(
        (input_tokens * in_rate
         + output_tokens * out_rate
         + cache_write_tokens * in_rate * CACHE_WRITE_MULT
         + cache_read_tokens * in_rate * CACHE_READ_MULT) / per,
        6,
    )
