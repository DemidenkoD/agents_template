# 🤖 Agent Guide: Mode Selection & Repository Inventory

> **Target Audience:** AI Agents (Antigravity, Cursor, Claude, Copilot, etc.) working inside or deploying configurations from this repository.  
> **Purpose:** Provide an autonomous decision tree for selecting the appropriate project setup, persona, and storage strategy, along with a full catalog of repository assets.

---

## 🧭 Autonomous Setup Selection Matrix

When interacting with the user, evaluate the project context against this decision tree to determine which setup and persona to activate:

```text
                               What is the user working on?
                                            │
           ┌──────────────────────┬─────────┴────────────┬────────────────────────┐
           ▼                      ▼                      ▼                        ▼
    DataTalks.Club         DataTalks.Club         Full-Stack App,          Personal Project,
    ML Zoomcamp / DE       AI Dev Tools           Web Service, API,        Client Repo, or
    Course Homework        Zoomcamp Project       SaaS, Production DB      Someone Else's Codebase
           │                      │                      │                        │
           ▼                      ▼                      ▼                        ▼
┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐ ┌──────────────────────┐
│  🧑‍🏫 Mentor Persona   │ │ 🚀 Autonomous Lead   │ │ 🏗️ Enterprise       │ │  🛡️ Guardian Persona  │
│                      │ │                      │ │   Architect & Lead   │ │                      │
│ - Learning first     │ │ - Proactive driver   │ │ - Modular & strictly │ │ - Safe sandbox       │
│ - Student self-codes │ │ - Decomposes goals   │ │   typed boundaries   │ │ - Zero outside files │
│ - Boilerplate ready  │ │ - Integration tests  │ │ - Two-tier verify    │ │   without permission │
│ - Non-destructive    │ │ - Minimal steering   │ │ - Decoupled CI/CD    │ │ - Log all changes    │
│   production extract │ │ - Commits agent pack │ │ - DEV_DIARY protocol │ │ - .git/info/exclude  │
└──────────────────────┘ └──────────────────────┘ └──────────────────────┘ └──────────────────────┘
           │                      │                      │                        │
     Mode: ml-zoomcamp      Mode: ai-dev-tools     Mode: fullstack-prod     Mode: personal-project
```

### Detailed Mode Identification

| If the User Says / Mentions... | Selected Setup | Operating Persona | Storage Strategy |
| :--- | :--- | :--- | :--- |
| "ML Zoomcamp", "EDA notebook", "scikit-learn", "model training", "homework 1", "tabular data", "Streamlit app" | **`ml-zoomcamp`** | **Interactive Mentor & Assembler** | **Local Only:** `.agents/` and `AGENTS.md` added to `.gitignore`. Never committed to homework repos. |
| "AI Dev Tools", "Module 5", "Agent Extension Pack", "MCP server", "FastMCP", "homework submission" | **`ai-dev-tools`** | **Autonomous Tech Lead** | **Committed to Git:** `AGENTS.md`, `.agents/`, and extension packs are graded deliverables. |
| "full-stack", "production app", "web service", "Nuxt/Next/FastAPI", "Postgres/Drizzle/Prisma", "CI/CD release", "enterprise SaaS" | **`fullstack-production`** | **Enterprise Architect & Release Lead** | **Committed to Git:** `AGENTS.md`, `.agents/`, `DEV_DIARY.md`, and CI/CD templates are tracked for team & multi-agent visibility. |
| "my private repo", "someone else's codebase", "client project", "legacy code", "contributing to repo", "fix bug in this repo" | **`personal-project`** | **Careful Guardian** | **Local Only:** `.agents/` isolated via `.git/info/exclude`. All notes, tests, and logs live inside `.agents/`. |

---

## ⚡ How to Initialize Each Mode

When the user asks you to set up or bootstrap a project, execute `./setup.sh` or perform the equivalent directory copying:

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

### 3. Full-Stack Production Mode (`./setup.sh fullstack-production <target_dir>`)
- **What gets installed:**
  - Root Rules: Master enterprise `AGENTS.md` installed at `<target>/AGENTS.md`.
  - Rules: Universal standards (`general/rules/*`) + production engineering standards (`personal-projects/rules/*`) copied to `<target>/.agents/rules/`.
  - Skills: Code auditing and health verification (`personal-projects/skills/*`, `general/skills/*`) copied to `<target>/.agents/skills/`.
  - Verification & Session Scripts: `session-end-check.sh`, `verify-template.sh` (as `verify.sh`), and `check-locale-parity.sh` copied to `<target>/.agents/scripts/`.
  - Documentation: Initialized `DEV_DIARY.md` and onboarding `START_HERE.md` installed.
  - Workflows: Decoupled CI/CD pipeline templates copied to `<target>/.github/workflows/`.
- **Git Tracking Enforced:**
  - `.agents/` rules, verification scripts, CI/CD templates, and `DEV_DIARY.md` are tracked in version control for multi-agent handoffs and continuous delivery.
- **Agent Behavioral Rules:**
  1. Log plan, hypothesis, scope, validation, and commit suggestions in `DEV_DIARY.md` on every turn (`developer-diary-protocol.md`).
  2. Enforce the two-tier verification strategy: inner loop unit tests (<1s) during dev, outer loop integration before completion (`two-tier-verification.md`).
  3. Keep deployment decoupled: build containers separately from running database migrations; never wipe databases in release workflows (`decoupled-deployment-and-db-safety.md`).
  4. Enforce strict boundary between server and client config; protect production auth flows and role-gate development tooling (`production-environment-and-role-gating.md`).
  5. Run `.agents/scripts/session-end-check.sh` before declaring tasks complete (`session-completion-and-handoff.md`).

### 4. Personal Project / External Codebase Mode (`./setup.sh personal-project <target_dir>`)
- **What gets installed:**
  - Local Sandbox: `.agents/` with `context/`, `scripts/`, `logs/`, `changes/`, `rules/`, `skills/`.
  - Rules: `general/rules/*` + `personal-projects/rules/*` copied to `<target>/.agents/rules/`.
  - Skills: `personal-projects/skills/*` copied to `<target>/.agents/skills/`.
  - Verification & Safety Scripts: `session-end-check.sh`, `verify-template.sh` copied to `<target>/.agents/scripts/`.
  - Diary & Reservations: Starter `DEV_DIARY.md` and multi-agent `reservations.json` created inside `.agents/`.
  - Roadmap: `.agents/todo.md` created inside `.agents/` (never in root).
- **Git Isolation Enforced:**
  - Appends `.agents/` to `<target>/.git/info/exclude` (so the host repository's `.gitignore` is not modified).
- **Agent Behavioral Rules:**
  1. Never modify wider project structure, rename folders, or delete files without permission (`external-codebase-guardrails.md`).
  2. Never create files outside of `.agents/` without an explicit user request.
  3. Write one-off test scripts only inside `.agents/scripts/`.
  4. Log every code change and its rationale into `.agents/DEV_DIARY.md` and `.agents/changes/`.
  5. Coordinate subagent file reservations via `.agents/reservations.json`.

---

## 🗂️ Complete Repository Inventory

### Root Configuration
- `AGENTS.md`: Master behavioral instructions, universal invariants, and persona declarations.
- `README.md`: High-level overview, matrix comparison, and user documentation.
- `AGENT_README.md`: This file — agent decision engine, setup guides, and repository catalog.
- `setup.sh`: Automated multi-mode bootstrap script for local or full-stack projects.

---

### `general/` — Universal Standards, Scripts & Templates
- **Rules (`general/rules/`):**
  - `developer-diary-protocol.md`: Mandatory operational protocol for maintaining `DEV_DIARY.md`.
  - `two-tier-verification.md`: Fast inner test loop (<1s) vs full pre-handoff regression suite.
  - `decoupled-deployment-and-db-safety.md`: 3-workflow decoupled release standard (build, release with migrations, guarded reset).
  - `production-environment-and-role-gating.md`: Boundary separation for credentials, public auth, and role-gated dev tooling.
  - `session-completion-and-handoff.md`: 4-gate pre-completion verification checklist.
  - `dont-commit.md`: Prohibits auto-running `git commit`.
  - `dont-push.md`: Prohibits auto-running `git push`.
  - `package-management.md`: Grants freedom to install packages; mandates cleaning up unneeded packages.
  - `database-safety.md`: Distinguishes migrations from destructive database wipes; enforces backups.
  - `use-uv-zoomcamp.md`: Mandates `uv` as the default Python manager for all Zoomcamps.
  - `agent-storage-and-git-tracking.md`: Details the storage policies across project types.
- **Scripts (`general/scripts/`):**
  - `session-end-check.sh`: Automated pre-completion validator (diary presence, reservation cleanup, `git diff --check`).
  - `verify-template.sh`: Two-tier verification runner template for fast unit tests vs slow end-to-end tests.
- **Templates (`general/templates/`):**
  - `dev-diary-template.md`: Standard structured `DEV_DIARY.md` template.
  - `start-here-template.md`: Standard fast onboarding guide for automated agents.
- **Skills (`general/skills/`):**
  - `project-health-check/SKILL.md`: Audits environment, dependencies, and git working tree.

---

### `fullstack-production/` — Enterprise Full-Stack Service (Architect Persona)
- **Rules (`fullstack-production/rules/`):**
  - `decoupled-deployment-and-db-safety.md`: 3-workflow decoupled release standard (build, release with migrations, guarded reset).
  - `production-environment-and-role-gating.md`: Secret boundary isolation, clean public auth, and role-gated in-app developer tooling.
- **Scripts (`fullstack-production/scripts/`):**
  - `check-locale-parity.sh`: Portable multilingual i18n key parity validator.
- **Templates (`fullstack-production/templates/github-workflows/`):**
  - `build-containers-template.yml`: Standalone container build & test pipeline.
  - `release-app-template.yml`: Zero-downtime deployment & migration runner.
  - `reset-data-template.yml`: Manually triggered, environment-guarded database & cache reset workflow.

---

### `ai-dev-tools/` — Autonomous Tech Lead & Agent Tooling
- **Rules (`ai-dev-tools/rules/`):**
  - `autonomous-tech-lead.md`: Directs agent to drive implementation proactively with minimal steering.
  - `concurrent-multi-agent-workflow.md`: Multi-agent collaboration, acyclic task partitioning, and `.agents/reservations.json` file reservation registry.
  - `commit-strategy.md`: Pre-commit gates (`git diff --check`, tests, zero leaks), Conventional Commits standard, never auto-pushing, and human-in-the-loop commit proposals.
  - `llm-evaluations.md`: Empirical AI verification, schema checks, tool selection accuracy, and test datasets (`eval_cases.json`).
  - `llm-resilience-and-cost.md`: Loop circuit breakers, rate limits, exponential backoff with jitter, and model fallbacks.
  - `prompt-engineering.md`: Decoupled prompt catalog, standard variable interpolation (`{{var}}`), and prompt injection defense.
  - `one-shot-deployment.md`: Pragmatic, lightweight single-file Docker and compose containerization without enterprise saga bloat.
  - `agent-tool-design.md`: Guidelines for schema precision, prompt clarity, and idempotency.
  - `mcp-security.md`: Zero hardcoded credentials and input sanitization.
  - `homework-todo-workflow.md`: Generates interactive `todo.md` checklists from homework URLs or files.
  - `ai-workflow-documentation.md`: Guidance for logging prompts, context, and review for peer review scoring.
- **Scripts (`ai-dev-tools/scripts/`):**
  - `test-mcp-tools.py`: Fast local MCP stdio client runner for instant CLI tool inspection in <1s.
- **Skills (`ai-dev-tools/skills/`):**
  - `scaffold-ai-devtools-project`: Generates the complete full-stack app + Module 5 Agent Extension Pack.
  - `scaffold-homework-todo`: Parses homework markdown specifications into interactive checklists.
  - `scaffold-mcp-server`: Scaffolds Python FastMCP / MCP servers.
  - `scaffold-agent-plugin`: Generates Antigravity plugin manifests (`plugin.json`).
- **Templates (`ai-dev-tools/templates/`):**
  - `fastmcp-starter.py`: Production-ready FastMCP server with typed Pydantic tools, dynamic resources, and prompt templates.
  - `evals-template.py`: Standalone evaluation runner measuring tool accuracy, text assertions, latency, and tokens.
  - `eval-cases-template.json`: Starter evaluation test cases covering happy path, negative calling, and injection shields.
  - `system-prompt-template.md`: Injection-shielded system prompt template with clear section demarcation.
  - `zoomcamp-review-checklist.md`: Pre-submission peer review scorecard matching DataTalks.Club criteria (0–12 pts).
  - `product-spec-template.md`: Complete product specification and user stories.
  - `openapi-template.yaml`: Contract-first OpenAPI 3.0 specification.
  - `docker-compose-template.yml`: Minimal single-file multi-service orchestration.
  - `agent-extension-pack-template.md`: Extension pack peer review documentation.
  - `permissions-template.md`: Security controls and access levels.
  - `reservations-template.json`: Agent reservation manifest for multi-agent file access coordination.


---

### `personal-projects/` — Careful Guardian & Non-Owner Guardrails
- **Rules (`personal-projects/rules/`):**
  - `local-agent-workspace.md`: Mandates `.agents/` as the safe local sandbox (context, scripts, logs, changes).
  - `external-codebase-guardrails.md`: Prohibits structural modifications or outside file creation without explicit user permission.
  - `production-code-quality.md`: Enforces strict typing, linting, and modular layered architecture.
  - `security-and-secrets.md`: Enforces secret scanning and `.env.example` requirements.
  - `test-driven-verification.md`: Requires automated test execution before declaring completion.
- **Skills (`personal-projects/skills/`):**
  - `analyze-codebase-context`: Safely audits someone else's codebase in read-only mode to extract maps and conventions.
  - `scaffold-prod-repo`: Scaffolds production-grade Python services with a clean repo footprint.
- **Templates (`personal-projects/templates/`):**
  - `codebase-map-template.md`: Architecture map and entrypoints outline.
  - `conventions-template.md`: Discovered style and pattern catalog.
  - `change-entry-template.md`: AI changelog entry template for `.agents/changes/`.
  - `reservations-template.json`: Agent reservation manifest for multi-agent file access coordination.

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

