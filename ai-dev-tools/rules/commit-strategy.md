# Rule: Git Commit Strategy for AI Dev Tools

- **Trigger:** Any Git operation, staging, committing, or milestone reporting.
- **Scope:** All AI Dev Tools projects and automated agent workflows.

## Core Principle: Human Gate & Atomic Integrity
AI agents work with engineering discipline. Commits must be atomic, cleanly verified, and follow conventional commit standards. **Push authority belongs exclusively to the human developer.**

---

## 1. Non-Negotiable Git Guardrails

1. **NEVER Auto-Push (`dont-push.md`):**
   - The agent MUST NEVER run `git push` autonomously. Only the human developer pushes code to remote repositories.
2. **Never Blind-Commit:**
   - Do not commit code that has not been executed, built, or verified against automated tests.
   - Do not bundle unrelated changes (e.g. mixing dependency updates, frontend UI tweaks, and backend MCP changes into one massive commit).

---

## 2. Commit Message Standards (Conventional Commits)

All commit messages must follow the Conventional Commits specification:

```text
<type>(<scope>): <short, imperative description in present tense>

[optional longer body explaining 'why' and non-obvious design decisions]
```

### Allowed Types:
- `feat`: A new user-facing or agent-facing capability (e.g. `feat(mcp): implement search tool with input validation`).
- `fix`: A bug fix (e.g. `fix(auth): correct token parsing in request middleware`).
- `test`: Adding or updating unit/integration tests (e.g. `test(mcp): add end-to-end tool execution test suite`).
- `refactor`: Code restructuring without changing external behavior (e.g. `refactor(server): split route handlers by domain`).
- `docs`: Documentation updates (e.g. `docs(readme): add agent extension pack setup instructions`).
- `chore`: Dependency updates, tooling, or project configuration (e.g. `chore(deps): update fastmcp to 0.4.0`).

---

## 3. Pre-Commit Verification Gate

Before staging or proposing a commit, verify that all four gates pass:

1. **Code Compiles / Syntax Clean:**
   - Run linter or typecheck (e.g., `npm run build`, `python -m py_compile ...`, or `ruff check`).
2. **Tests Pass:**
   - Run relevant unit or integration tests (`npm test`, `pytest`).
3. **Diff Hygiene Clean:**
   - Run `git diff --check` to ensure no whitespace errors, CRLF corruption, or unresolved merge conflict markers exist.
4. **Zero Artifact Leakage:**
   - Ensure no credentials, API keys, `.env` files, temporary debug prints, or `AGENT-RESERVE` comments are staged.

---

## 4. Agent Commit Execution vs Human Proposal

Depending on user preference and workflow phase:

### Mode A: Propose Commit for Human Approval (Default)
When a milestone is verified:
1. Stage the relevant files: `git add <file1> <file2>`
2. Show the user the exact staged file list and the suggested commit command:
   ```bash
   git add mcp-server/tools/weather.py tests/test_weather.py
   git commit -m "feat(mcp): add weather tool with schema validation"
   ```
3. Stop and wait for the user to review or confirm.

### Mode B: Checkpoint Commits on Local Branches (When Instructed)
If the user explicitly directs the agent to commit locally on a dedicated feature branch:
- Execute the commit using the Conventional Commit format.
- Confirm the commit hash and modified scope in `DEV_DIARY.md`.
- **Never push the branch to remote.**
