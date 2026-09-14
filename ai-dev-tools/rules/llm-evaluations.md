# Rule: LLM & Tool Evaluation Standards

- **Trigger:** Developing, testing, or optimizing LLM prompts, agent workflows, and MCP tools.
- **Scope:** All AI Dev Tools projects, evaluation scripts, and test suites.

## Core Principle: Empirical AI Verification
Prompt engineering without evaluations is guessing. Every AI tool, agent capability, or prompt template must be evaluated empirically across a curated suite of test cases rather than relying on manual ad-hoc testing.

---

## 1. The Three Tiers of AI Evaluation

1. **Tier 1: Deterministic Schema & Syntax Assertions (Fast & Free):**
   - **Schema Conformance:** Did the LLM output valid JSON matching the exact Pydantic/Zod schema?
   - **Tool Parameter Completeness:** Were all required tool arguments present and of the correct type?
   - **Constraint Verification:** Did the output respect length caps, forbidden keywords, or required prefix formats?

2. **Tier 2: Tool Calling & Intent Accuracy:**
   - **Correct Tool Selection:** When presented with user query X, did the model choose tool Y over tool Z?
   - **Negative Tool Calling:** When presented with queries outside the tool's domain, did the model refuse to call tools rather than hallucinating parameters?
   - **Argument Precision:** Did the model correctly extract entities from the query into the tool arguments?

3. **Tier 3: Semantic Quality & LLM-as-a-Judge:**
   - **Factual Accuracy:** Does the answer accurately reflect the retrieved tool data?
   - **Tone & Style:** Does the output follow persona guidelines (e.g. concise, friendly, Markdown-formatted)?
   - **Scoring Rubric:** Evaluate outputs on a binary pass/fail or 1–5 scale using an independent judge model with a frozen scoring prompt.

---

## 2. Test Dataset Structure (`eval_cases.json`)

Maintain a version-controlled dataset of evaluation test cases covering:
1. **Happy Path:** Standard, unambiguous user queries.
2. **Edge Cases:** Vague queries, missing arguments, or conflicting instructions.
3. **Domain Boundaries:** Queries that should NOT trigger tools.
4. **Adversarial / Injection Tests:** Queries attempting to bypass system prompt constraints or extract instructions.

Each test case must specify:
```json
{
  "id": "eval-001",
  "input": "What is the weather in Berlin tomorrow?",
  "expected_tool": "get_weather",
  "expected_args": {"city": "Berlin"},
  "must_contain": ["temperature", "forecast"],
  "must_not_contain": ["error", "unknown"]
}
```

---

## 3. Latency & Token Budget Tracking

Every evaluation run must measure:
- **Latency:** Time-to-first-token and total completion duration (flagging regressions > 3000ms).
- **Token Efficiency:** Prompt token count vs completion token count (flagging token bloat).
- **Cost Estimation:** Estimated cost per 1,000 queries based on active model pricing.

---

## 4. Evaluation Workflow

- Run evaluations before finalizing agent tools or prompt changes:
  ```bash
  python evals/run_evals.py
  ```
- Any PR or submission must document the eval pass rate (e.g. `20/20 test cases passing (100%), avg latency: 850ms`).
