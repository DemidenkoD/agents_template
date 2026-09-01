# 🤖 Agent Guide: Mode Selection & Repository Inventory

> **Target Audience:** AI Agents (Antigravity, Cursor, Claude, Copilot, etc.) working inside or deploying configurations from this repository.  
> **Purpose:** Provide an autonomous decision tree for selecting the appropriate project setup, persona, and storage strategy, along with a full catalog of repository assets.

---

## 🧭 Autonomous Setup Selection Matrix

When interacting with the user, evaluate the project context against this decision tree to determine which setup and persona to activate:

```text
                               What is the user working on?
                                            │
           ┌────────────────────────────────┼────────────────────────────────┐
           ▼                                ▼                                ▼
    DataTalks.Club                   DataTalks.Club                   Personal Project,
    ML Zoomcamp / DE                 AI Dev Tools                    Client Repo, or
    Course Homework                  Zoomcamp Project               Someone Else's Codebase
           │                                │                                │
           ▼                                ▼                                ▼
┌──────────────────────┐        ┌──────────────────────┐        ┌──────────────────────┐
│  🧑‍🏫 Mentor Persona   │        │ 🚀 Autonomous Lead   │        │  🛡️ Guardian Persona  │
│                      │        │                      │        │                      │
│ - Learning first     │        │ - Proactive driver   │        │ - Safe sandbox       │
│ - Student self-codes │        │ - Decomposes goals   │        │ - Zero outside files │
│ - Boilerplate ready  │        │ - Integration tests  │        │   without permission │
│ - Non-destructive    │        │ - Minimal steering   │        │ - Log all changes    │
│   production extract │        │ - Commits agent pack │        │ - .git/info/exclude  │
└──────────────────────┘        └──────────────────────┘        └──────────────────────┘
           │                                │                                │
     Mode: ml-zoomcamp               Mode: ai-dev-tools            Mode: personal-project
```

### Detailed Mode Identification

| If the User Says / Mentions... | Selected Setup | Operating Persona | Storage Strategy |
| :--- | :--- | :--- | :--- |
| "ML Zoomcamp", "EDA notebook", "scikit-learn", "model training", "homework 1", "tabular data", "Streamlit app" | **`ml-zoomcamp`** | **Interactive Mentor & Assembler** | **Local Only:** `.agents/` and `AGENTS.md` added to `.gitignore`. Never committed to homework repos. |
| "AI Dev Tools", "Module 5", "Agent Extension Pack", "MCP server", "Full-stack app", "OpenAPI spec", "FastMCP" | **`ai-dev-tools`** | **Autonomous Tech Lead** | **Committed to Git:** `AGENTS.md`, `.agents/`, and extension packs are graded deliverables. |
| "my private repo", "someone else's codebase", "client project", "legacy code", "contributing to repo", "fix bug in this repo" | **`personal-project`** | **Careful Guardian** | **Local Only:** `.agents/` isolated via `.git/info/exclude`. All notes, tests, and logs live inside `.agents/`. |

---

## ⚡ How to Initialize Each Mode

When the user asks you to set up or bootstrap a project, execute [`setup.sh`](file:///mnt/d/Learning/ML_Zoomcamp/agents_template/setup.sh) or execute the equivalent directory copying:

### 1. ML Zoomcamp Mode (`./setup.sh ml-zoomcamp <target_dir>`)
- **What gets installed:**
  - Rules: `general/rules/*` + `ml-zoomcamp/rules/*` copied to `<target>/.agents/rules/`.
  - Skills: `ml-zoomcamp/skills/*` copied to `<target>/.agents/skills/`.
  - Boilerplates: `ml-zoomcamp/templates/*` copied to `<target>/.agents/templates/`.
- **Git Isolation Enforced:**
  - Appends `.agents/`, `AGENTS.md`, and `todo.md` to `.gitignore`.
- **Agent Behavioral Rules:**
  1. Never delete or overwrite student code cells in training notebooks (`preserve-user-code.md`).
  2. Provide doc shortcuts, tips & tricks, and function stubs with hidden solutions (`tutorial-layout.md`).
  3. Conduct code review first; only then extract verified code into production (`dual-notebook-workflow.md`).
  4. Never clutter production code with inline comments (`production-code-comments.md`).

### 2. AI Dev Tools Mode (`./setup.sh ai-dev-tools <target_dir>`)
- **What gets installed:**
  - Rules: `general/rules/*` + `ai-dev-tools/rules/*` copied to `<target>/.agents/rules/`.
  - Skills: `ai-dev-tools/skills/*` copied to `<target>/.agents/skills/`.
  - Root Instructions: `AGENTS.md` copied to `<target>/AGENTS.md`.
  - Extension Pack Stubs: `agent-capabilities/`, `agent-hooks/`, `mcp-server/`, `docs/`.
- **Git Tracking Enforced:**
  - All agent files are tracked in version control for peer review.
- **Agent Behavioral Rules:**
  1. Take the lead proactively; decompose high-level specifications independently (`autonomous-tech-lead.md`).
  2. Write integration tests and verify code empirically before reporting milestones.
  3. Document AI prompts, delegation steps, and human-in-the-loop review for peer grading (`ai-workflow-documentation.md`).

### 3. Personal Project / External Codebase Mode (`./setup.sh personal-project <target_dir>`)
- **What gets installed:**
  - Local Sandbox: `.agents/` with `context/`, `scripts/`, `logs/`, `changes/`, `rules/`, `skills/`.
  - Rules: `general/rules/*` + `personal-projects/rules/*` copied to `<target>/.agents/rules/`.
  - Skills: `personal-projects/skills/*` copied to `<target>/.agents/skills/`.
  - Roadmap: `.agents/todo.md` created inside `.agents/` (never in root).
- **Git Isolation Enforced:**
  - Appends `.agents/` to `<target>/.git/info/exclude` (so the host repository's `.gitignore` is not modified).
- **Agent Behavioral Rules:**
  1. Never modify wider project structure, rename folders, or delete files without permission (`external-codebase-guardrails.md`).
  2. Never create files outside of `.agents/` without an explicit user request.
  3. Write one-off test scripts only inside `.agents/scripts/`.
  4. Log every code change and its rationale into `.agents/changes/YYYY-MM-DD_<topic>.md`.
  5. Store codebase maps and discovered patterns in `.agents/context/` (`analyze-codebase-context`).

---

## 🗂️ Complete Repository Inventory

### Root Configuration
- [`AGENTS.md`](file:///mnt/d/Learning/ML_Zoomcamp/agents_template/AGENTS.md): Master behavioral instructions and universal persona declarations.
- [`README.md`](file:///mnt/d/Learning/ML_Zoomcamp/agents_template/README.md): High-level overview, matrix comparison, and user documentation.
- [`AGENT_README.md`](file:///mnt/d/Learning/ML_Zoomcamp/agents_template/AGENT_README.md): This file — agent decision engine and directory catalog.
- [`setup.sh`](file:///mnt/d/Learning/ML_Zoomcamp/agents_template/setup.sh): Automated shell script for bootstrapping target directories.

---

### `general/` — Universal Agent Standards
- `rules/dont-commit.md`: Prohibits auto-running `git commit`.
- `rules/dont-push.md`: Prohibits auto-running `git push`.
- `rules/package-management.md`: Grants freedom to install packages; mandates cleaning up unneeded packages.
- `rules/database-safety.md`: Prohibits dropping persistent databases without explicit user instructions.
- `rules/use-uv-zoomcamp.md`: Mandates `uv` as the default Python manager for all Zoomcamps.
- `rules/agent-storage-and-git-tracking.md`: Details the 3-way storage policy across project types.
- `skills/project-health-check/SKILL.md`: Audits environment, dependencies, and git working tree.

---

### `ml-zoomcamp/` — Interactive Mentor & Pipeline Assembler
- **Rules (`ml-zoomcamp/rules/`):**
  - `mentor-persona.md`: Core operating philosophy (learning first, assemble second).
  - `end-to-end-workflow.md`: The complete 6-stage pipeline from scaffold to Docker.
  - `preserve-user-code.md`: Non-destructive editing policy for training notebooks.
  - `dual-notebook-workflow.md`: Interactive training (`01_...`) vs clean production (`notebook_main.ipynb`).
  - `tutorial-layout.md`: 4-part exercise cell layout (Objectives, Intuition, Workspace with stubs, Collapsible Solution).
  - `production-code-comments.md`: No inline comment clutter in production code; Markdown headers only.
  - `concept-first.md`: Plain-English definitions explaining *what it is*, *why we use it*, and *how it works*.
  - `katex-math-formatting.md`: Math formatting standards avoiding indentation KaTeX parse errors.
- **Skills (`ml-zoomcamp/skills/`):**
  - `ml-scaffold-project`: Scaffolds standard ML Zoomcamp project directories and `uv` dependencies.
  - `ml-generate-tutorial-notebook`: Builds interactive 4-part exercise cells with doc shortcuts & stubs.
  - `ml-review-student-notebook`: Performs thorough code reviews on completed student cells without altering code.
  - `ml-extract-pipeline-scripts`: Refactors verified notebook logic to `src/` and generates `pytest` test suites.
  - `ml-scaffold-streamlit-app`: Builds interactive Streamlit web applications and Docker containers.
- **Templates (`ml-zoomcamp/templates/`):**
  - `todo-roadmap-template.md`: 11-stage project checklist.
  - `column-transformer-snippet.py`: Sklearn numerical & categorical preprocessing pipeline.
  - `evaluate-model-snippet.py`: Multi-metric evaluation helper.
  - `train-py-template.py`: Production pipeline training & serialization script.
  - `predict-py-template.py`: Standalone inference class.
  - `streamlit-app-template.py`: Streamlit UI portal.
  - `Dockerfile-template`: Multi-stage container definition.

---

### `ai-dev-tools/` — Autonomous Tech Lead & Agent Tooling
- **Rules (`ai-dev-tools/rules/`):**
  - `autonomous-tech-lead.md`: Directs agent to drive implementation proactively with minimal steering.
  - `agent-tool-design.md`: Guidelines for schema precision, prompt clarity, and idempotency.
  - `mcp-security.md`: Zero hardcoded credentials and input sanitization.
  - `homework-todo-workflow.md`: Generates interactive `todo.md` checklists from homework URLs or files.
  - `ai-workflow-documentation.md`: Guidance for logging prompts, context, and review for peer review scoring.
- **Skills (`ai-dev-tools/skills/`):**
  - `scaffold-ai-devtools-project`: Generates the complete full-stack app + Module 5 Agent Extension Pack.
  - `scaffold-homework-todo`: Parses homework markdown specifications into interactive checklists.
  - `scaffold-mcp-server`: Scaffolds Python FastMCP / MCP servers.
  - `scaffold-agent-plugin`: Generates Antigravity plugin manifests (`plugin.json`).
- **Templates (`ai-dev-tools/templates/`):**
  - `product-spec-template.md`: Complete product specification and user stories.
  - `openapi-template.yaml`: Contract-first OpenAPI 3.0 specification.
  - `docker-compose-template.yml`: Multi-service orchestration.
  - `agent-extension-pack-template.md`: Extension pack peer review documentation.
  - `permissions-template.md`: Security controls and access levels.

---

### `personal-projects/` — Careful Guardian & Non-Owner Guardrails
- **Rules (`personal-projects/rules/`):**
  - `local-agent-workspace.md`: Mandates `.agents/` as the safe local sandbox (context, scripts, logs, changes).
  - `external-codebase-guardrails.md`: Prohibits structural modifications or outside file creation without explicit user permission.
  - `production-code-quality.md`: Enforces `mypy` strict typing, `ruff` linting, and modular layered architecture.
  - `security-and-secrets.md`: Enforces secret scanning and `.env.example` requirements.
  - `test-driven-verification.md`: Requires automated test execution before declaring completion.
- **Skills (`personal-projects/skills/`):**
  - `analyze-codebase-context`: Safely audits someone else's codebase in read-only mode to extract maps and conventions.
  - `scaffold-prod-repo`: Scaffolds production-grade Python services with a clean repo footprint.
- **Templates (`personal-projects/templates/`):**
  - `codebase-map-template.md`: Architecture map and entrypoints outline.
  - `conventions-template.md`: Discovered style and pattern catalog.
  - `change-entry-template.md`: AI changelog entry template for `.agents/changes/`.

