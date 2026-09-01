# Rule: Agent Storage & Git-Tracking Policy

- **Trigger:** Initializing new projects, creating `.agents/` configurations, configuring `.gitignore`
- **Scope:** Universal across all course and personal projects

## Standard Antigravity Folder Convention
Antigravity automatically discovers project-level customizations in:
- Root rules file: `AGENTS.md` (or `GEMINI.md`)
- Root agents folder: `.agents/` (or `.agent/`, `_agents/`)
  - `.agents/rules/*.md`
  - `.agents/skills/<skill-name>/SKILL.md`
  - `.agents/templates/`
- Global machine-wide folder: `~/.gemini/config/`

---

## Strategy Comparison Matrix

| Project Category | Git Status | Location of `todo.md` | Contains App `logs/` & `changes/`? | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **ML Zoomcamp** | **Local Only** | Local `todo.md` (or `.agents/todo.md`) | Optional | Personal tutor & documentation shortcuts; never pollutes homework PRs |
| **AI Dev Tools** | **Committed to Git** | Project root `todo.md` | No (standard repo docs) | Course deliverable, peer review evaluation & extension pack |
| **Personal Projects** | **Local Only** | Inside `.agents/todo.md` | **Yes (`.agents/logs/`, `.agents/changes/`)** | Zero clutter in private repo; private log debugging & AI change tracking |

---

## Strategy 1: Local-Only Mode (ML Zoomcamp)
- Add `.agents/`, `AGENTS.md`, and `todo.md` to `.gitignore` or `.git/info/exclude`.
- Or install skills machine-wide in `~/.gemini/config/skills/`.

## Strategy 2: Committed Repo Mode (AI Dev Tools)
- `AGENTS.md`, `.agents/`, and the Agent Extension Pack (`agent-capabilities/`, `agent-hooks/`, `mcp-server/`, `docs/`) MUST be committed to Git for peer review.

## Strategy 3: Self-Contained Local Agent Workspace (Personal Projects)
- `.agents/` MUST be listed in `.gitignore`.
- Keep the project root minimal and clean.
- Place all agent files, tasks, logs, and change history inside `.agents/`:
  ```text
  .agents/
  ├── todo.md          # Local roadmap & task list
  ├── logs/            # Application logs & debug traces for AI analysis
  ├── changes/         # AI-generated changelogs detailing what changed and why
  ├── rules/           # Project rules
  └── skills/          # Project skills
  ```
