# 🤖 Master AI Agent Template Repository

A master repository of **Antigravity agent rules, skills, boilerplates, and templates** tailored for **Full-Stack Production Applications**, **Personal Projects / External Codebases**, **AI Tool Development**, and **DataTalks.Club Courses** (ML Zoomcamp, Data Engineering, MLOps).

> 🤖 **For AI Agents:** Read [`AGENT_README.md`](./AGENT_README.md) for the autonomous setup decision tree, operating persona rules, and full directory catalog.

---

## 🎭 The 4 Core Agent Personas

| Dimension | Full-Stack Production | Personal Projects / External Codebase | AI Dev Tools | ML Zoomcamp |
| :--- | :--- | :--- | :--- | :--- |
| **Agent Persona** | **Architect & Release Lead** | **Careful Guardian** | **Autonomous Tech Lead** | **Interactive Mentor & Assembler** |
| **Primary Goal** | Architectural discipline, zero-downtime release, two-tier verification | Safe sandbox, minimal outside touch, log all changes | Take the lead, drive goals with minimal steering | Teach concepts, documentation shortcuts, review code |
| **Code Ownership** | Collaborative / Lead; full regression gates | User drives; agent strictly edits requested files | Agent drives full-stack implementation | **Student writes core code**; agent assembles verified code |
| **Agent Footprint** | Committed to Git (`AGENTS.md`, `.agents/`, CI/CD) | Local only (`.agents/` via `.git/info/exclude`) | Committed to Git (`AGENTS.md`, `.agents/`, pack) | Local only (`.gitignore` or global `~/.gemini/`) |
| **`.agents/` Contents** | `DEV_DIARY.md`, `START_HERE.md`, `scripts/`, `context/`, `rules/` | `DEV_DIARY.md`, `START_HERE.md`, `todo.md`, `scripts/`, `logs/` | Project rules, skills, MCP servers, extension pack | Predefined boilerplate, tutorial skills, stubs |

---

## ⚡ Quick Start: One-Line Project Setup

Use the included [`setup.sh`](./setup.sh) script to initialize any project in seconds:

```bash
# 1. Initialize Full-Stack Production Service (Decoupled CI/CD, DB safety, Diary, Two-tier testing)
./setup.sh fullstack-production /path/to/my-web-app

# 2. Initialize Personal Project or Someone Else's Codebase (Safe Guardian mode)
./setup.sh personal-project /path/to/my-repo

# 3. Initialize AI Dev Tools Project (Committed repo mode + Extension Pack stubs)
./setup.sh ai-dev-tools /path/to/my-ai-app

# 4. Initialize ML Zoomcamp Homework / Project (Local-only mode)
./setup.sh ml-zoomcamp /path/to/my-homework
```

---

## 🏛️ Enterprise Agent Architecture & Best Practices

### 1. Developer Diary Protocol (`.agents/DEV_DIARY.md`)
- **Single Source of Truth:** Chronological audit log preventing context amnesia between restarts or multi-agent turns.
- **Strict Schema:** Every session records `Goal`, `Findings` (technical rationale), `Scopes modified` (exact file list), `Verification` (exact commands & results), and `Handoff`.
- **Fast Onboarding (`.agents/START_HERE.md`):** Agents read only 3 files and run 1 command on startup, protecting context limits.

### 2. Two-Tier Verification Architecture (`.agents/scripts/verify.sh`)
- **Tier 1 (Inner Loop):** Fast (<1s) domain-targeted checks during active coding (e.g. `verify.sh auth`).
- **Tier 2 (Outer Gate):** Comprehensive regression check (`verify.sh commit`) running full test suites, static typing (`tsc`, `mypy`), linters, locale parity, and `git diff --check`.
- **Golden Rule:** *Never declare success without executing checks.*

### 3. Concurrent Multi-Agent Collaboration & Coordination
- **Zero-Collision Reservations (`.agents/reservations.json`):** Concurrent agents (e.g. Antigravity, OpenCode, Claude, Cursor, Copilot) declare active file reservations before editing.
- **Acyclic Architectural Partitioning:** Independent subagents are assigned orthogonal boundaries (MCP tools vs API routes vs UI frontend vs tests).
- **Asynchronous Sync via Developer Diary:** Agents record turn goals, active scopes, findings, and handoffs in `DEV_DIARY.md` for seamless context across sessions.

### 4. Git Commit Strategy for AI Tools
- **Never Auto-Push:** Push authority is strictly reserved for the human developer.
- **Atomic Conventional Commits:** Meaningful milestone commits (`feat(mcp): ...`, `fix(agent): ...`).
- **Pre-Commit Verification Gates:** Enforces `git diff --check` (clean formatting, no whitespace errors), passing unit tests, and zero leaked secrets or temporary reservation markers.
- **Human Review Gate:** Agents stage verified files and propose exact commit commands for one-click human execution.

### 5. Pragmatic One-Shot Deployment (AI Tools)
- **Zero-Bloat Containerization:** Lightweight single-file `docker-compose.yml` and multi-stage `Dockerfile`.
- **No Complex Sagas:** AI dev tools avoid heavy blue-green migration pipelines and multi-locale verification scripts in favor of fast, reliable one-time deployment.

### 6. Decoupled 3-Workflow CI/CD Standard (Full-Stack Production Mode)
- **Build Containers (`build-containers.yml`):** Layer-cached container compilation directly on host/CI without touching live traffic or databases.
- **Release App & Run Migrations (`release-app.yml`):** Zero-data-loss deployments with pre-release snapshots, schema migrations, rolling container swaps, and live `/api/health` checks.
- **Reset Database & Redis (`reset-data.yml`):** Dedicated, confirmation-protected (`confirm: RESET`) maintenance workflow that flushes cache, applies schema migrations, and seeds baseline personas.

### 7. Automated Session End Gate (`session-end-check.sh`)
- Automated verification script checking that:
  1. A diary entry is present for the session.
  2. No leftover `AGENT-RESERVE` temporary markers remain.
  3. `git diff --check` passes with zero whitespace or conflict errors.

---

## 📂 Repository Structure

```text
agents_template/
├── AGENTS.md                                # Master instructions file for AI agents
├── AGENT_README.md                          # Agent decision tree & inventory catalog
├── README.md                                # Main repository documentation & guide
├── setup.sh                                 # One-line bootstrapper for any project
│
├── general/                                 # Universal rules, scripts & templates
│   ├── rules/
│   │   ├── developer-diary-protocol.md      # Rule: Mandatory DEV_DIARY.md logging & handoff
│   │   ├── two-tier-verification.md         # Rule: Inner loop (<1s) vs Outer gate regression
│   │   ├── session-completion-and-handoff.md# Rule: Pre-handoff checklist & automated gates
│   │   ├── database-safety.md               # Rule: Pre-migration snapshots & additive changes
│   │   ├── dont-commit.md                   # Rule: Never auto-commit changes
│   │   ├── dont-push.md                     # Rule: Never auto-push to remotes
│   │   ├── repo-lifecycle-safety.md         # Rule: No unauthorized repo deletion or hard resets
│   │   ├── large-data-files.md              # Rule: Prevent committing raw datasets or heavy weights
│   │   ├── secrets-and-env-hygiene.md       # Rule: Zero secret exposure, sanitized .env.example
│   │   ├── package-management.md            # Rule: Package installation & mandatory cleanup
│   │   ├── use-uv-zoomcamp.md               # Rule: Enforce 'uv' package manager for Python/Zoomcamp
│   │   ├── multi-agent-orchestration.md     # Rule: Multi-subagent delegation & workspace isolation
│   │   ├── subagent-workflow-for-course.md    # Rule: Course-generic scout/exec/verify subagent workflow
│   │   ├── mcp-server-usage.md                # Rule: MCP server usage & inspection workflow
│   │   ├── playwright-recording-and-demo.md   # Rule: Playwright recording & demo video pipeline
│   │   └── agent-storage-and-git-tracking.md# Rule: Storage policies across project modes
│   ├── scripts/
│   │   ├── session-end-check.sh             # Script: Universal post-session validation gate
│   │   └── verify-template.sh               # Script: Two-tier verification runner template
│   ├── skills/
│   │   ├── project-health-check/            # Skill: Audit env, deps & git working tree
│   │   ├── record-demo/                     # Skill: Record narrated UI demo videos
│   │   └── scout-with-graph/                # Skill: Read-only repo-graph scouting
│   └── templates/
│       ├── dev-diary-template.md            # Template: Standardized DEV_DIARY.md starter
│       ├── start-here-template.md           # Template: Standardized START_HERE.md onboarding guide
│       ├── opencode-mcp-template.json       # Template: MCP server config starter
│       └── playwright-demo-config-template.ts # Template: Playwright demo recording config
│
├── fullstack-production/                    # Enterprise fullstack standards (Architect Persona)
│   ├── rules/
│   │   ├── decoupled-deployment-and-db-safety.md # Rule: 3-workflow CI/CD & zero-data-loss release
│   │   └── production-environment-and-role-gating.md # Rule: Secret isolation & role-gated dev tooling
│   ├── scripts/
│   │   └── check-locale-parity.sh           # Script: Multilingual translation key parity validator
│   └── templates/github-workflows/
│       ├── build-containers-template.yml    # Workflow: Layer-cached container build
│       ├── release-app-template.yml         # Workflow: Zero-data-loss release & schema migration
│       └── reset-data-template.yml          # Workflow: Guarded cache flush & fixture reset
│
├── ai-dev-tools/                            # AI & Agent development tools (Driver Persona)
│   ├── rules/
│   │   ├── autonomous-tech-lead.md          # Rule: Proactive, goal-driven execution with minimal steering
│   │   ├── concurrent-multi-agent-workflow.md# Rule: Zero-collision multi-agent coordination & reservations
│   │   ├── commit-strategy.md               # Rule: Conventional commits, pre-commit gates & human approval
│   │   ├── llm-evaluations.md               # Rule: Empirical AI verification, schema checks & test datasets
│   │   ├── llm-resilience-and-cost.md       # Rule: Circuit breakers, rate limits, jitter & model fallbacks
│   │   ├── prompt-engineering.md            # Rule: Prompt catalog, variable interpolation & injection defense
│   │   ├── one-shot-deployment.md           # Rule: Pragmatic single-file Docker & compose setup
│   │   ├── agent-tool-design.md             # Rule: Clean tool schemas, context isolation & prompts
│   │   ├── mcp-security.md                  # Rule: Zero hardcoded secrets, safe tool execution
│   │   ├── homework-todo-workflow.md        # Rule: Generate interactive todo.md checklist for homeworks
│   │   └── ai-workflow-documentation.md     # Rule: Documenting prompts, context, and review
│   ├── scripts/
│   │   └── test-mcp-tools.py                # Script: Fast local MCP stdio client test runner (<1s)
│   ├── skills/
│   │   ├── scaffold-ai-devtools-project/    # Skill: Scaffold full-stack app + Extension Pack
│   │   ├── scaffold-homework-todo/          # Skill: Parse homework URL/md into interactive todo.md
│   │   ├── scaffold-mcp-server/             # Skill: Build Model Context Protocol (MCP) server
│   │   └── scaffold-agent-plugin/           # Skill: Scaffold new agent plugin or skill set
│   └── templates/
│       ├── fastmcp-starter.py               # Template: Production FastMCP server with tools & resources
│       ├── evals-template.py                # Template: Standalone evaluation runner script
│       ├── eval-cases-template.json         # Template: Sample evaluation dataset
│       ├── system-prompt-template.md        # Template: Injection-defended system prompt
│       ├── zoomcamp-review-checklist.md     # Template: Peer review self-audit checklist (0-12 pts)
│       ├── product-spec-template.md         # Template: Product specification & user stories
│       ├── openapi-template.yaml            # Template: Contract-first OpenAPI definition
│       ├── docker-compose-template.yml      # Template: Single-file container orchestration
│       ├── agent-extension-pack-template.md # Template: Extension pack documentation
│       ├── permissions-template.md          # Template: Permissions & security boundary spec
│       └── reservations-template.json       # Template: Multi-agent reservation manifest
│
├── personal-projects/                       # Personal projects & external codebases (Guardian Persona)
│   ├── rules/
│   │   ├── local-agent-workspace.md         # Rule: Self-contained local .agents/ structure
│   │   ├── external-codebase-guardrails.md  # Rule: Non-owner protection & minimal outside edits
│   │   ├── production-code-quality.md       # Rule: Strict typing, linting, clean architecture
│   │   ├── security-and-secrets.md          # Rule: Env variable isolation & secret scanning
│   │   └── test-driven-verification.md      # Rule: Automated test coverage before declaring completion
│   ├── skills/
│   │   ├── analyze-codebase-context/        # Skill: Read-only codebase audit & adaptation extraction
│   │   ├── scaffold-prod-repo/              # Skill: Scaffold production-grade repo with local .agents/
│   │   └── safely-branch-and-test/          # Skill: Isolated branch testing and validation
│   └── templates/
│       ├── codebase-map-template.md         # Template for .agents/context/codebase-map.md
│       ├── conventions-template.md          # Template for .agents/context/conventions.md
│       ├── change-entry-template.md         # Template for AI change log entries in .agents/changes/
│       └── reservations-template.json       # Template for .agents/reservations.json multi-agent locking
│
├── ai-dev-tools/                            # AI & Agent development tools (Driver Persona)
│   ├── rules/
│   │   ├── autonomous-tech-lead.md          # Rule: Proactive, goal-driven execution with minimal steering
│   │   ├── agent-tool-design.md             # Rule: Clean tool schemas, context isolation & prompts
│   │   ├── mcp-security.md                  # Rule: Zero hardcoded secrets, safe tool execution
│   │   ├── homework-todo-workflow.md        # Rule: Generate interactive todo.md checklist for homeworks
│   │   └── ai-workflow-documentation.md     # Rule: Documenting prompts, context, and review
│   ├── skills/
│   │   ├── scaffold-ai-devtools-project/    # Skill: Scaffold full-stack app + Extension Pack
│   │   ├── scaffold-homework-todo/          # Skill: Parse homework URL/md into interactive todo.md
│   │   ├── scaffold-mcp-server/             # Skill: Build Model Context Protocol (MCP) server
│   │   └── scaffold-agent-plugin/           # Skill: Scaffold new agent plugin or skill set
│   └── templates/
│       ├── product-spec-template.md         # Product specification & user stories
│       ├── openapi-template.yaml            # Contract-first OpenAPI definition
│       ├── docker-compose-template.yml      # Multi-service container orchestration
│       ├── agent-extension-pack-template.md # Extension pack documentation
│       └── permissions-template.md          # Permissions & security boundary spec
│
└── ml-zoomcamp/                             # ML Zoomcamp specific workflows (Mentor Persona)
    ├── rules/
    │   ├── mentor-persona.md                # Rule: Learning-first teaching & production assembler
    │   ├── end-to-end-workflow.md           # Rule: Master 6-stage ML Zoomcamp workflow pipeline
    │   ├── preserve-user-code.md            # Rule: Non-destructive editing in training notebooks
    │   ├── dual-notebook-workflow.md        # Rule: Interactive tutorial vs clean production notebook
    │   ├── tutorial-layout.md               # Rule: 4-part exercise cell with doc shortcuts & stubs
    │   ├── production-code-comments.md      # Rule: Clean production code (no inline comments)
    │   ├── concept-first.md                 # Rule: Intuitive concept-first ML explanations
    │   └── katex-math-formatting.md         # Rule: Safe inline KaTeX rendering in notebooks
    ├── skills/
    │   ├── ml-scaffold-project/             # Skill: Scaffold ML Zoomcamp project structure
    │   ├── ml-generate-tutorial-notebook/   # Skill: Pre-populate imports, stubs, & hidden solutions
    │   ├── ml-review-student-notebook/      # Skill: Review student code & provide suggestions
    │   ├── ml-extract-pipeline-scripts/     # Skill: Non-destructive extraction to src/*.py
    │   └── ml-scaffold-streamlit-app/       # Skill: Scaffold Streamlit UI for inference
    └── templates/
        ├── todo-roadmap-template.md         # 11-stage ML Zoomcamp project checklist
        ├── column-transformer-snippet.py    # Sklearn ColumnTransformer preprocessing snippet
        ├── evaluate-model-snippet.py        # Model evaluation metrics & reporting helper
        ├── train-py-template.py             # Production model training & serialization script
        ├── predict-py-template.py           # Inference module template
        ├── streamlit-app-template.py        # Streamlit UI template
        └── Dockerfile-template              # Container definition template
```
