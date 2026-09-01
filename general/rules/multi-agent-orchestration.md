# Rule: Multi-Agent Orchestration & Subagent Delegation

- **Trigger:** Complex tasks, parallel frontend/backend development, background research, isolated branch testing
- **Scope:** Universal across all projects and harnesses supporting subagent spawning

## Core Multi-Agent Principles

1. **Model Tiering & Cost-Efficiency:**
   - **Fast / Lightweight Tasks (`flash` / `flash_lite`):** Delegate quick documentation searches, code linting audits, schema validation, and targeted lookups to smaller, faster models.
   - **High-Reasoning Tasks (`pro` / `inherit`):** Reserve deeper reasoning models for system architecture design, complex algorithmic logic, and critical security audits.

2. **Workspace Isolation (`inherit` vs `branch` vs `share`):**
   - **`Workspace: "inherit"`:** Used for read-only research subagents or agents collaborating on shared project files.
   - **`Workspace: "branch"`:** Used when a subagent is making experimental changes, testing refactors, or writing unverified code. Prevents corruption of the parent agent's working tree.
   - **`Workspace: "share"`:** Used for shared git worktree environments.

3. **Autonomous Team Roles by Project Mode:**
   - **AI Dev Tools (Full-Stack Pod):** Parent Tech Lead coordinates `frontend-agent`, `backend-agent`, and `qa-security-agent` concurrently.
   - **ML Zoomcamp (Tutor & Research):** Tutor handles student interaction; background `research` subagents query API docs or parameter grids without cluttering the notebook chat.
   - **Personal / External Projects (Scout & Branch Worker):** Read-only `scout` maps foreign code; isolated `branch` worker implements changes safely in `.agents/scripts/`.

4. **Reactive Non-Blocking Coordination:**
   - Agents must NOT poll or sleep waiting for subagents. The harness wakes up the parent automatically when a subagent completes or sends a message (`send_message`).

