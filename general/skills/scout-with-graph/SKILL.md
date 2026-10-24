---
name: scout-with-graph
description: Map unfamiliar code with the repo-graph (graft) before reading files; cheapest-first, ranked vs exhaustive correctly.
---

# Skill: scout-with-graph

Use for "how does X work / where is Y / what breaks if I change Z".
Keeps the main session lean: one query usually replaces several file reads.

## Workflow (cheapest first)

1. `repo_map` — orient (directory clusters, hubs). Pick the scope prefix (e.g. `<project>/server/`).
2. `find_code "<question>"` — ranked hits with code inlined. The top node usually IS the answer; cite its `file:line`.
3. `file_api <file>` (skeleton) — skim a file's API (~200 tokens) instead of reading it whole.
4. `trace_calls <symbol>` — blast radius before a rename/refactor (`--direction out` for callees, `--depth N` transitive).
5. `find_all "<literal>"` — only when you need EVERY occurrence (ranked search is top-N, not complete).

## CLI ↔ MCP equivalence

| Goal | CLI | MCP tool |
|---|---|---|
| Orient | `graft map` | `graft_repo_map` |
| Understand | `graft ask "<q>" --source` | `graft_find_code` |
| Exhaustive | `graft grep "<literal>"` | `graft_find_all` |
| Callers/callees | `graft callers <sym> [--direction out] [--depth N]` | `graft_trace_calls` |
| Skim file | `graft skeleton <file>` | `graft_file_api` |
| Freshness / rebuild | `graft check` / `graft build` | (CLI only) |

## Rules

- Re-ask freely (cheap); reuse literal identifiers (symbol, error string, file name) as queries.
- Open source only at the exact `file:line` a node points to; if a span says "+N more lines", read that range before finalizing.
- `find_code` = top-N ranked (may miss hits). `find_all`/`grep` = exhaustive over indexed files; raw `grep -rn` only for unindexed files.
- Narrow monorepos with `--in <scope>/` once you know the scope.
- After big refactors run `graft build` (deterministic, $0, no key).
