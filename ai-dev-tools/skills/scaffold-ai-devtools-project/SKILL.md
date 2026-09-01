---
name: scaffold-ai-devtools-project
description: Scaffolds the complete AI Dev Tools project structure including full-stack app layout and Module 5 Agent Extension Pack.
---

# Skill: Scaffold AI Dev Tools Project

## Purpose
Initializes the official project repository layout required for the AI Dev Tools Zoomcamp final project, including full-stack app folders, API specifications, and the Agent Extension Pack.

## Target Repository Structure
```text
project_root/
├── README.md                            # Problem description, tech stack, AI workflow & run guide
├── product-spec.md                      # Functional specs, user stories, requirements
├── AGENTS.md                            # Version-controlled agent rules & guidelines
├── openapi.yaml                         # Contract-first API specification
├── docker-compose.yml                   # Container orchestration (frontend, backend, DB)
├── frontend/                            # React / Vite / UI application
├── backend/                             # Express / FastAPI backend service
├── .agents/                             # Committed workspace rules & skills
│   ├── rules/
│   └── skills/
├── agent-capabilities/                  # Agent tools & custom capabilities
├── agent-hooks/                         # Agent lifecycle hooks
├── mcp-server/                          # Dedicated FastMCP / MCP server implementation
├── docs/
│   ├── agent-extension-pack.md          # Guide explaining agent extensions
│   ├── permissions.md                   # Security permissions & boundaries
│   └── ai-workflow.md                   # Prompts, context, manual reviews, & verification
├── security/                            # Security audit scripts, SAST configs
├── ops/                                 # CI/CD, deployment scripts
└── .github/workflows/ci.yml             # Automated testing & linting
```

## Procedural Steps
1. Create core documentation files from templates: `product-spec.md`, `openapi.yaml`, `docker-compose.yml`.
2. Initialize `AGENTS.md` and `.agents/` directory (version-controlled in Git).
3. Scaffold full-stack subdirectories: `frontend/` and `backend/`.
4. Scaffold Module 5 Agent Extension Pack:
   - `agent-capabilities/`
   - `agent-hooks/`
   - `mcp-server/`
   - `docs/agent-extension-pack.md`
   - `docs/permissions.md`
5. Set up `security/` and `ops/` auditing directories.

