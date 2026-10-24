# Rule: Subagent Workflow for Course Projects (companion)

- **Trigger:** task splits into independent streams (frontend + backend, research + implement).
- **Scope:** companion to `general/rules/multi-agent-orchestration.md` (which owns tiering, workspaces, non-blocking). This file owns the concrete course flow. Do not duplicate that file.

## Flow: Scout → parallel workers → Reviewer

1. **Scout (read-only, `inherit`):** map the area with `scout-with-graph` skill; return file:line list + risks. No code changes.
2. **Parallel workers (`branch` for edits, `inherit` for research):** one stream per worker (e.g. UI worker, API worker). Max depth **2** (parent → worker; workers never spawn).
3. **Reviewer (`inherit` or `branch`):** checks diff, runs affected typecheck/tests, returns accept / fix-list. Parent merges.

## Git hygiene (workers)

- Status with `git status -s` and `git diff --stat` only. Never bare `git diff`, `git status -vv`, or unpaged dumps.
- One stream = one branch (`course/<topic>-<stream>`); workers never push to `main`.
- Workers stop before gates: no commit/merge/push unless the parent explicitly orders it.

## Diary handoff (keeps sessions lean)

Each worker ends with a 5-line handoff: `branch / files touched / checks run + result / remaining / next command`. Parent appends it to the session diary (`DEV_DIARY.md` or equivalent) and starts a fresh context past ~150k tokens.

## When NOT to spawn

Single-file fix, pure lookup, or anything a `graft ask` answers in one hit — do it inline.
