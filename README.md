# 🤖 DataTalks.Club AI Agent Template Repository

A master repository of **Antigravity agent rules, skills, boilerplates, and templates** tailored for DataTalks.Club courses (ML Zoomcamp, Data Engineering, MLOps, AI Dev Tools), AI Tool Development, and Production Personal Projects / External Codebases.

> 🤖 **For AI Agents:** Read [`AGENT_README.md`](./AGENT_README.md) for the autonomous setup decision tree, operating persona rules, and full directory catalog.

---

## 🎭 The 3 Core Agent Personas

| Dimension | AI Dev Tools | ML Zoomcamp | Personal Projects / External Codebase |
| :--- | :--- | :--- | :--- |
| **Agent Persona** | **Autonomous Tech Lead** | **Interactive Mentor & Assembler** | **Careful Guardian** |
| **Primary Goal** | Take the lead, drive goals with minimal steering | Teach concepts, documentation shortcuts, review code | Safe sandbox, minimal outside touch, log all changes |
| **Code Ownership** | Agent drives full-stack implementation | **Student writes core code**; agent assembles verified code | User drives; agent strictly edits requested files |
| **Agent Footprint** | Committed to Git (`AGENTS.md`, `.agents/`, pack) | Local only (`.gitignore` or global `~/.gemini/`) | Local only (`.agents/` via `.git/info/exclude`) |
| **`.agents/` Contents** | Project rules, skills, MCP servers | Predefined boilerplate, tutorial skills | `context/`, `scripts/`, `logs/`, `changes/`, `todo.md` |

---

## ⚡ Quick Start: One-Line Project Setup

Use the included [`setup.sh`](file:///mnt/d/Learning/ML_Zoomcamp/agents_template/setup.sh) script to initialize any project in seconds:

```bash
# 1. Initialize ML Zoomcamp Homework / Project (Local-only mode)
./setup.sh ml-zoomcamp /path/to/my-homework

# 2. Initialize AI Dev Tools Project (Committed repo mode + Extension Pack stubs)
./setup.sh ai-dev-tools /path/to/my-ai-app

# 3. Initialize Personal Project or Someone Else's Codebase (Safe Guardian mode)
./setup.sh personal-project /path/to/my-repo
```

---

## 🔄 ML Zoomcamp End-to-End Workflow

```text
  ┌─────────────────────────┐
  │  1. Scaffold Project    │  (ml-scaffold-project with uv)
  └────────────┬────────────┘
               ▼
  ┌─────────────────────────┐
  │  2. Generate TODO List  │  (scaffold-homework-todo)
  └────────────┬────────────┘
               ▼
  ┌─────────────────────────┐
  │  3. Training Notebooks  │  (ml-generate-tutorial-notebook: pre-populated imports,
  └────────────┬────────────┘   static strings, column lists, stubs & hidden solutions)
               ▼
  ┌─────────────────────────┐
  │  4. Student Self-Coding │  (ml-review-student-notebook: agent reviews & suggests
  └────────────┬────────────┘   without modifying training cells)
               ▼
  ┌─────────────────────────┐
  │  5. Production Extract  │  (ml-extract-pipeline-scripts: non-destructively copies into
  └────────────┬────────────┘   notebook_main.ipynb or src/*.py classes, no comment clutter)
               ▼
  ┌─────────────────────────┐
  │  6. Tests & Application │  (pytest unit tests in tests/, Streamlit in app/app.py,
  └─────────────────────────┘   and Docker containerization)
```

---

## 📂 Repository Structure

```text
agents_template/
├── AGENTS.md                            # Master instructions file for AI agents
├── README.md                            # Main repository documentation & guide
├── setup.sh                             # One-line bootstrapper for any project
│
├── general/                             # Universal rules & skills
│   ├── rules/
│   │   ├── dont-commit.md               # Rule: Never auto-commit changes
│   │   ├── dont-push.md                 # Rule: Never auto-push to remotes
│   │   ├── repo-lifecycle-safety.md     # Rule: No unauthorized repo creation/deletion or hard resets
│   │   ├── large-data-files.md          # Rule: Prevent committing datasets (*.csv, *.parquet) or large weights
│   │   ├── secrets-and-env-hygiene.md   # Rule: Zero secret exposure, sanitized .env.example templates
│   │   ├── package-management.md        # Rule: Free installation & mandatory cleanup
│   │   ├── database-safety.md           # Rule: Non-destructive database operations
│   │   ├── use-uv-zoomcamp.md           # Rule: Enforce 'uv' package manager for Zoomcamp projects
│   │   └── agent-storage-and-git-tracking.md # Rule: 3-way storage policy
│   └── skills/
│       └── project-health-check/        # Skill: Project structure and environment audit
│           └── SKILL.md
│
├── ml-zoomcamp/                         # ML Zoomcamp specific workflows (Mentor Persona)
│   ├── rules/
│   │   ├── mentor-persona.md            # Rule: Learning-first teaching & production assembler
│   │   ├── end-to-end-workflow.md       # Rule: Master 6-stage ML Zoomcamp workflow pipeline
│   │   ├── preserve-user-code.md        # Rule: Non-destructive editing in training notebooks
│   │   ├── dual-notebook-workflow.md    # Rule: Interactive tutorial vs clean production notebook
│   │   ├── tutorial-layout.md           # Rule: 4-part exercise cell with doc shortcuts & stubs
│   │   ├── production-code-comments.md  # Rule: Clean production code (no inline comments)
│   │   ├── concept-first.md             # Rule: Intuitive concept-first ML explanations
│   │   └── katex-math-formatting.md     # Rule: Safe inline KaTeX rendering in notebooks
│   ├── skills/
│   │   ├── ml-scaffold-project/         # Skill: Scaffold ML Zoomcamp project structure
│   │   ├── ml-generate-tutorial-notebook/# Skill: Pre-populate imports, stubs, & hidden solutions
│   │   ├── ml-review-student-notebook/  # Skill: Review student code & provide suggestions
│   │   ├── ml-extract-pipeline-scripts/ # Skill: Non-destructive extraction to src/*.py & unit tests
│   │   └── ml-scaffold-streamlit-app/   # Skill: Scaffold Streamlit UI for inference
│   └── templates/                       # Boilerplates & code snippets
│       ├── todo-roadmap-template.md     # 11-stage ML Zoomcamp project checklist
│       ├── column-transformer-snippet.py# Sklearn ColumnTransformer preprocessing snippet
│       ├── evaluate-model-snippet.py    # Model evaluation metrics & reporting helper
│       ├── train-py-template.py         # Production model training & serialization script
│       ├── predict-py-template.py       # Inference module template
│       ├── streamlit-app-template.py    # Streamlit UI template
│       └── Dockerfile-template          # Container definition template
│
├── ai-dev-tools/                        # AI & Agent development tools (Driver Persona)
│   ├── rules/
│   │   ├── autonomous-tech-lead.md      # Rule: Proactive, goal-driven execution with minimal steering
│   │   ├── agent-tool-design.md         # Rule: Clean tool schemas, context isolation & prompts
│   │   ├── mcp-security.md              # Rule: Zero hardcoded secrets, safe tool execution
│   │   ├── homework-todo-workflow.md    # Rule: Generate interactive todo.md checklist for homeworks
│   │   └── ai-workflow-documentation.md # Rule: Documenting prompts, context, and review for peer review
│   ├── skills/
│   │   ├── scaffold-ai-devtools-project/# Skill: Scaffold full-stack app + Module 5 Extension Pack
│   │   ├── scaffold-homework-todo/      # Skill: Parse homework URL/md into interactive todo.md
│   │   ├── scaffold-mcp-server/         # Skill: Build Model Context Protocol (MCP) server
│   │   └── scaffold-agent-plugin/       # Skill: Scaffold new agent plugin or skill set
│   └── templates/                       # AI Dev Tools Final Project Templates
│       ├── product-spec-template.md     # Product specification & user stories
│       ├── openapi-template.yaml        # Contract-first OpenAPI definition
│       ├── docker-compose-template.yml  # Multi-service container orchestration
│       ├── agent-extension-pack-template.md # Extension pack documentation
│       └── permissions-template.md      # Permissions & security boundary spec
│
└── personal-projects/                   # Personal projects & external codebases (Guardian Persona)
    ├── rules/
    │   ├── local-agent-workspace.md     # Rule: Self-contained local .agents/ (context/, scripts/, logs/, changes/)
    │   ├── external-codebase-guardrails.md # Rule: Non-owner protection (no wider edits/files without permission)
    │   ├── production-code-quality.md   # Rule: Strict typing (mypy), ruff linting, clean architecture
    │   ├── security-and-secrets.md      # Rule: Env variable isolation, secret scanning, .env.example
    │   └── test-driven-verification.md  # Rule: Automated test coverage before declaring completion
    ├── skills/
    │   ├── analyze-codebase-context/    # Skill: Read-only codebase audit & adaptation extraction
    │   └── scaffold-prod-repo/          # Skill: Scaffold production-grade Python repo with local .agents/
    └── templates/
        ├── codebase-map-template.md     # Template for .agents/context/codebase-map.md
        ├── conventions-template.md      # Template for .agents/context/conventions.md
        └── change-entry-template.md     # Template for AI change log entries in .agents/changes/
```
