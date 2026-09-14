# START HERE (Agent Onboarding Guide)

Read **3 files**, skim **1**, run **1 command**. Everything else is loaded on demand.
Do NOT read the entire repository into context upfront.

---

## 1. Start: Read 3 Files, Run 1 Command

| # | File | Purpose | Size |
|---|---|---|---|
| 1 | `AGENTS.md` (root) | Non-negotiable architectural invariants and safety rules. | ~100 lines |
| 2 | `.agents/todo.md` | Active tasks, priorities, and ownership roadmap. | ~50 lines |
| 3 | `.agents/DEV_DIARY.md` (top entry) | Latest handoff, recent findings, and current state. | ~30 lines |
| 4 | Run Verification Command | Execute `bash .agents/scripts/verify.sh` (or test runner) to confirm baseline health. | 1 command |

---

## 2. Information Tiers (Prevent Context Bloat)

| Tier | Resources | When to Load |
|---|---|---|
| **Tier 0 (Core)** | The 3 files + 1 command above | **Every session** |
| **Tier 1 (Architecture)** | `.agents/context/codebase-map.md`, `.agents/context/architecture.md` | Only when exploring unfamiliar subsystems |
| **Tier 2 (On-Demand Skills)** | Specific skill directories (`.agents/skills/<skill>/SKILL.md`) | Only when explicitly executing that domain task |
| **Tier 3 (Deep Archive)** | Historical logs, old change records, raw specs | Never load upfront; search with targeted tools only |

---

## 3. Multi-Subagent Delegation Pattern

When working on complex or multi-step tasks, preserve your context by delegating:
1. **Scout / Recon Subagent (Read-only):** Explores foreign files, traces schemas, and queries documentation. Returns a concise summary of exact files and lines to edit.
2. **Implementation Worker (Isolated):** Implements focused changes in a separate context.
3. **Reviewer / Verifier Subagent:** Executes static analysis, automated test suites, and formatting checks.

---

## 4. End of Session: Write 1, Run 2

1. **Prepend an entry to `.agents/DEV_DIARY.md`:**
   - Record Goal, Technical Findings, Scopes modified, Exact verification commands & outputs, and Handoff.
2. **Execute `.agents/scripts/session-end-check.sh`:**
   - Programmatically verifies diary presence, no leftover reservation markers, and clean `git diff --check`.
3. **Execute Tier 2 Verification:**
   - Run full regression suite or `verify.sh commit`.
