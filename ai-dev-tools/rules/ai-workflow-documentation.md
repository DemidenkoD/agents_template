# Rule: AI-Assisted Workflow Documentation

- **Trigger:** Developing projects in AI Dev Tools Zoomcamp
- **Scope:** Project documentation (`README.md`, `docs/ai-workflow.md`)

## Policy
In AI Dev Tools Zoomcamp projects, peer reviewers evaluate how effectively AI was used with engineering discipline. The project MUST document:

1. **Prompt & Task Delegation Log:**
   - Record representative initial prompts, iterative refinements, and subagent delegations.
   - Explain the reasoning behind how tasks were split between frontend, backend, and agent tooling.
2. **Context Engineering:**
   - Document how context was provided to the agent (e.g. `AGENTS.md`, OpenAPI specs, product specs, targeted file references).
3. **Human-in-the-Loop Review & Verification:**
   - Document where the developer intervened to correct agent errors, refactor bad suggestions, or add security guardrails.
   - List the testing commands (`pytest`, `npm test`, linting) used to empirically verify agent-generated code.

