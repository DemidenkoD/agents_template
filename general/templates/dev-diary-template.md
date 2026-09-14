# Shared Developer Diary

**Repository**: `<project-name>`  
**Purpose**: Chronological log of all autonomous agent and developer work sessions.  
**Rule**: Append a new entry at the top for every completed task or handoff. Never silently edit files without recording scope and verification evidence.

---

## [YYYY-MM-DD HH:MM:SS UTC] Agent: <AgentName> | Branch: <branch>
- **Goal**: Brief description of the problem addressed or feature implemented.
- **Findings**:
  - Key discoveries, architectural context, root cause of issues identified.
  - Design decisions, trade-offs, or non-obvious rationale.
- **Scopes modified**: Explicit file list (e.g. `src/auth/service.py`, `tests/test_auth.py`, `compose.yaml`).
- **Verification**: Exact commands executed and their output (e.g. `pytest tests/ (24/24 passed in 0.8s)`, `mypy passed`, `session-end-check.sh OK`).
- **Handoff**: Status summary and suggested next command for the human or subsequent agent.

---
