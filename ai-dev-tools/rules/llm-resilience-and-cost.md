# Rule: LLM Resilience, Rate Limiting, and Cost Guardrails

- **Trigger:** Calling external LLM APIs, building autonomous agent loops, or integrating MCP tools.
- **Scope:** All AI Dev Tools applications, agent runtimes, and backend services.

## Core Principle: Bounded Autonomy & Fault Tolerance
Autonomous agents must operate within strict financial, iteration, and token guardrails. Unbounded loops, unhandled rate limits, or context window explosions can drain API credits or crash live demonstrations.

---

## 1. Loop Circuit Breakers (Runaway Prevention)

1. **Hard Turn Limit:**
   - Every multi-turn agent loop MUST enforce a hard maximum iteration cap (default: **6 turns**).
   - If the task is not completed within the turn limit, the agent must halt and report current state rather than continuing indefinitely.

2. **Repetition Detection (Infinite Loop Guard):**
   - Track the history of tool calls.
   - If the same tool is invoked with identical arguments twice in succession, abort the loop and ask for human clarification or switch strategy.

```python
MAX_TURNS = 6
previous_call = None

for turn in range(MAX_TURNS):
    action = agent.decide_action(state)
    if action == previous_call:
        logger.warning("Repetitive tool call detected. Breaking loop.")
        break
    previous_call = action
    # execute action...
```

---

## 2. Rate Limiting & Exponential Backoff

1. **Handle 429 & 503 Automatically:**
   - Implement exponential backoff with full jitter for all LLM API invocations.
   - Retry sequence: wait 1s, 2s, 4s (up to max 3 retries) before raising a user-facing error.

2. **Jitter Implementation:**
   - Always randomize delay intervals (`delay = base * (2 ** retry) + random.uniform(0, 0.5)`) to prevent thundering herd problems.

---

## 3. Graceful Model Fallbacks

Configure a prioritized model chain to guarantee availability:

1. **Primary Model (High Capability):**
   - E.g., `gemini-1.5-pro` or `gpt-4o` for complex tool selection, architecture decomposition, and reasoning.
2. **Fallback Model (Fast & High Rate Limit):**
   - E.g., `gemini-1.5-flash` or `gpt-4o-mini` if the primary model encounters rate limits (`429`), timeouts, or quota limits.

---

## 4. Token Budgeting & Tool Output Truncation

1. **Cap Tool Output Payloads:**
   - Tools returning external data (search results, file listings, database rows) MUST limit their output size (e.g. maximum 4KB or top 10 items).
   - Large payloads blow context windows, degrade model reasoning, and spike billing costs.

2. **Context Rolling Window:**
   - Maintain at most the last 5 conversation turns in active prompt context.
   - Older turns must be summarized or discarded rather than appending unlimited history.
