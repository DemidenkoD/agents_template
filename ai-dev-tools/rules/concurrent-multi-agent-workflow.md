# Rule: Concurrent Multi-Agent Workflow and Coordination

- **Trigger:** Multiple AI agents (Antigravity, OpenCode, Claude, Cursor, Copilot, or subagents) working concurrently on the repository.
- **Scope:** All AI Dev Tools projects, subagents, and automated workflows.

## Core Principle: Zero-Collision Collaboration
When multiple agents or subagents operate concurrently in the same codebase, they must coordinate explicitly to avoid overwrite races, duplicate effort, and merge conflicts.

---

## 1. Architectural Task Partitioning

1. **Contract-First Independence:**
   - Before launching concurrent agents, finalize and freeze shared interface contracts (e.g. `openapi.yaml`, shared TypeScript interfaces, or Pydantic models).
   - Agents work against the frozen contract rather than against live, mutating peer code.

2. **Orthogonal Boundary Assignment:**
   - Partition concurrent agents strictly by subsystem or directory layer:
     - **Agent A (Tools/MCP):** `mcp-server/`, `agent-capabilities/`
     - **Agent B (Backend API):** `backend/`, API route handlers
     - **Agent C (Frontend UI):** `frontend/`, client components
     - **Agent D (Verification & Docs):** `tests/`, `docs/`, `README.md`
   - Never assign two active agents to the same file simultaneously.

---

## 2. File Reservation Protocol

1. **Reservation Manifest (`.agents/reservations.json`):**
   - Active agents register their file or folder reservations before beginning modifications:
     ```json
     {
       "reservations": [
         {
           "agent": "Antigravity",
           "scope": "mcp-server/weather_tool.py",
           "task": "Implement weather lookup tool",
           "acquired_at": "2026-09-14T14:30:00Z"
         }
       ]
     }
     ```

2. **In-Code Reservation Marker (Optional):**
   - For granular component reservations, an agent may place a temporary marker at the top of the file:
     ```typescript
     // AGENT-RESERVE: Antigravity - Implementing weather schema
     ```
   - **Strict Rule:** If a file or component has an active reservation for another agent, DO NOT modify it. Wait for the reservation to clear or coordinate via the developer diary.

3. **Mandatory Teardown:**
   - Upon completing the task, the agent MUST remove its reservation from `.agents/reservations.json` and delete any temporary `AGENT-RESERVE` comments before completing the turn.

---

## 3. Asynchronous Coordination via Developer Diary (`DEV_DIARY.md`)

When multiple agents run in different sessions or across different LLM providers, `DEV_DIARY.md` is the single source of truth for agent-to-agent situational awareness.

1. **Turn Entry Protocol:**
   - Before starting, inspect the latest entries in `DEV_DIARY.md` to identify what peer agents completed and what blockers exist.
   - At the conclusion of your turn, prepend a structured diary entry:
     ```markdown
     ## [YYYY-MM-DD HH:MM UTC] Agent: <AgentName> | Scope: <Subsystem>
     - **Goal**: What was attempted in this session.
     - **Active Reservations**: Files held or released during this turn.
     - **Changes Made**: Concrete files created or modified with rationale.
     - **Verification**: Tests executed and their output (`npm test`, `pytest`).
     - **Blockers & Handoff**: Explicit context, unresolved issues, or next steps for the incoming agent.
     ```

---

## 4. Subagent Delegation Best Practices

1. **Single Responsibility:**
   - Give each subagent a single, tightly bounded responsibility with explicit read/write boundaries (e.g., "Implement the weather tool function inside `mcp-server/tools/weather.py` and run pytest on that file").
2. **Read-Only Researchers:**
   - Use read-only subagents for codebase exploration, documentation searches, or log auditing so they cannot accidentally mutate active source files.
3. **Orchestrator Integration:**
   - The primary orchestrator agent is responsible for receiving subagent outputs, running end-to-end integration checks, and updating the shared diary.
