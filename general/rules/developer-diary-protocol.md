# Rule: Developer Diary Protocol & Session Handoff

- **Trigger:** Any agent coding session, refactor, bugfix, or architectural change
- **Scope:** Universal across all projects (Personal, AI Dev Tools, Full-Stack, Zoomcamp)

## Core Philosophy
In multi-agent and multi-turn development, context windows are finite and memory fades between restarts. A shared **Developer Diary** (`.agents/DEV_DIARY.md`) serves as the single chronological source of truth across all contributors (human and AI).

---

## The Mandatory Schema

Every completed task or session MUST append an entry to `.agents/DEV_DIARY.md` using this exact structure:

```markdown
## [YYYY-MM-DD HH:MM:SS UTC] Agent: <AgentName> | Branch: <branch> | Upstream base: <commit>
- **Goal**: Clear, 1-2 sentence description of what this session set out to accomplish.
- **Findings**:
  - Technical discoveries, root-cause analyses, architectural decisions made, and bugs identified.
  - Non-obvious rationale for changes or trade-offs accepted.
- **Scopes modified**: Explicit list of files and directories modified, created, or deleted.
- **Verification**: Exact commands executed and their output (e.g., `bun test (48/48 passed in 1.2s)`, `verify.sh admin (16/16 pass)`, `session-end-check.sh OK`).
- **Handoff**: Clear status for the next agent or human (e.g. "Clean working tree, uncommitted per protocol", or "Committed as <hash>, ready for deployment").
```

---

## Operating Invariants

1. **No Silent Changes:** Every modified file MUST be accounted for in the diary entry under `Scopes modified`. Never touch files outside the declared scope.
2. **Exact Evidence:** Never write "Tests passed" without recording the specific command and result summary.
3. **Chronological Append-Only:** New entries are placed at the top of the chronological log (or appended chronologically as defined by project convention) without editing or deleting prior agents' entries.
4. **Automated Enforcement:** Before declaring completion, the agent MUST run `.agents/scripts/session-end-check.sh` to programmatically verify that a diary entry is recorded for the current session.
