# 🏆 AI Dev Tools Zoomcamp: Peer Review Self-Audit Checklist

Use this checklist to verify that your final project satisfies every criteria of the **DataTalks.Club AI Dev Tools Zoomcamp** grading rubric before submitting.

---

## 📋 1. Problem Description & Architecture (1–2 Points)
- [ ] **Clear Problem Statement:** `README.md` explains the problem being solved, the target user, and why an AI-driven solution is appropriate.
- [ ] **Architecture Diagram:** Visual diagram (Mermaid or image) showing the relationship between Frontend, Backend, LLM / Agent, and MCP Server.
- [ ] **Contract-First Specification:** `openapi.yaml` or typed interface models clearly documenting API routes and schemas.

---

## 💻 2. Working Application & UI (1–2 Points)
- [ ] **Interactive User Interface:** Web frontend (React, Vue, Streamlit, or equivalent) allowing the user to interact with the AI assistant or tool.
- [ ] **Real-Time Feedback:** Visual loading states, error alerts, and clean rendering of tool responses.
- [ ] **Responsive Design:** Functional on standard desktop viewports.

---

## 🔌 3. Model Context Protocol (MCP) Integration (1–2 Points)
- [ ] **Dedicated MCP Server:** Implemented via FastMCP or the official MCP SDK (in `mcp-server/`).
- [ ] **Typed Tools:** At least 2 distinct tools with Pydantic/Zod parameter validation and docstrings.
- [ ] **Context Resources:** At least 1 dynamic resource exposing application state or knowledge base data.
- [ ] **Prompt Templates:** At least 1 reusable prompt template defined via `@mcp.prompt`.
- [ ] **Local Verification:** MCP tools verified using `python scripts/test-mcp-tools.py`.

---

## 🧠 4. AI-Assisted Engineering Workflow (1–2 Points)
- [ ] **Workflow Documentation:** `docs/ai-workflow.md` (or detailed README section) documenting:
  - Initial prompts and iterative prompt refinements.
  - Multi-agent / subagent task delegation rationale.
  - Context engineering strategy (how context was formatted and injected).
- [ ] **Human-in-the-Loop Interventions:** Explicitly notes where the developer corrected AI hallucinations, refactored bad code, or tightened security guardrails.

---

## 🧪 5. Testing, Quality & Evaluations (1–2 Points)
- [ ] **Unit & Integration Tests:** Automated tests covering core application routes and tool logic (`pytest` or `npm test`).
- [ ] **LLM Evaluations Suite:** Runable eval script (`python evals/run_evals.py`) testing tool accuracy, schema conformance, and negative constraints on `eval_cases.json`.
- [ ] **Diff & Formatting Hygiene:** `git diff --check` clean with zero whitespace errors or leftover debug prints.

---

## 🐳 6. Reproducibility & One-Shot Deployment (1–2 Points)
- [ ] **Environment Template:** `.env.example` committed with all necessary keys and mock/default values.
- [ ] **Zero Committed Secrets:** No raw API keys, bearer tokens, or sensitive credentials in git history.
- [ ] **One-Shot Docker Launch:** The entire system starts cleanly with a single command:
  ```bash
  docker compose up -d --build
  ```
- [ ] **Verification Command:** Documented health check command verifying the service is healthy:
  ```bash
  curl -f http://localhost:8000/health
  ```

---

## 🎯 Submission Score Projection
| Rubric Criterion | Self-Score | Notes / Proof |
| :--- | :---: | :--- |
| Problem Description & Specs | /2 | Documented in README & product-spec.md |
| Working UI Application | /2 | Live frontend with real-time tool feedback |
| MCP Server Implementation | /2 | FastMCP server with tools, resources, prompts |
| AI Workflow Documentation | /2 | Documented in docs/ai-workflow.md |
| Tests & LLM Evals | /2 | Automated tests + evals suite passing |
| Docker Reproducibility | /2 | Tested via single-command docker compose up |
| **Total Projected Score** | **/12** | Ready for submission! |
