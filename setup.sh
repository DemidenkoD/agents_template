#!/usr/bin/env bash
# ==============================================================================
# Master Agent Template Bootstrapper
# Usage: ./setup.sh <mode> <target_directory>
# Modes:
#   - fullstack-production : Enterprise full-stack service (decoupled CI/CD, DB release safety, diary, gates)
#   - personal-project     : Safe guardian mode (local-only .agents/ with diary, context, scripts, logs)
#   - ai-dev-tools         : Autonomous lead mode (committed .agents/ & extension pack stubs)
#   - ml-zoomcamp          : Interactive learning mode (local-only .agents/ & tutorial tools)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-}"
TARGET_DIR="${2:-}"

if [[ -z "$MODE" || -z "$TARGET_DIR" ]]; then
  echo "Usage: $0 <fullstack-production | personal-project | ai-dev-tools | ml-zoomcamp> <target_directory>"
  exit 1
fi

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

case "$MODE" in
  fullstack-production)
    echo "⚙️ Initializing Full-Stack Production workspace in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills .agents/context .agents/scripts .agents/logs .agents/changes .github/workflows

    # Copy rules & skills
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/personal-projects/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/fullstack-production/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/personal-projects/skills/* .agents/skills/

    # Copy verification & quality scripts
    cp "$SCRIPT_DIR"/general/scripts/session-end-check.sh .agents/scripts/session-end-check.sh
    cp "$SCRIPT_DIR"/general/scripts/verify-template.sh .agents/scripts/verify.sh
    cp "$SCRIPT_DIR"/fullstack-production/scripts/check-locale-parity.sh .agents/scripts/check-locale-parity.sh
    chmod +x .agents/scripts/*.sh

    # Initialize onboarding, diary, reservations & roadmap
    [[ -f .agents/DEV_DIARY.md ]] || cp "$SCRIPT_DIR"/general/templates/dev-diary-template.md .agents/DEV_DIARY.md
    [[ -f .agents/START_HERE.md ]] || cp "$SCRIPT_DIR"/general/templates/start-here-template.md .agents/START_HERE.md
    [[ -f .agents/reservations.json ]] || cp "$SCRIPT_DIR"/personal-projects/templates/reservations-template.json .agents/reservations.json
    [[ -f .agents/todo.md ]] || touch .agents/todo.md
    [[ -f AGENTS.md ]] || cp "$SCRIPT_DIR"/AGENTS.md ./AGENTS.md

    # Copy decoupled 3-workflow release templates
    [[ -f .github/workflows/build-containers.yml ]] || cp "$SCRIPT_DIR"/fullstack-production/templates/github-workflows/build-containers-template.yml .github/workflows/build-containers.yml
    [[ -f .github/workflows/release-app.yml ]] || cp "$SCRIPT_DIR"/fullstack-production/templates/github-workflows/release-app-template.yml .github/workflows/release-app.yml
    [[ -f .github/workflows/reset-data.yml ]] || cp "$SCRIPT_DIR"/fullstack-production/templates/github-workflows/reset-data-template.yml .github/workflows/reset-data.yml

    echo "✅ Full-Stack Production workspace ready (Committed repo mode with decoupled CI/CD)."
    ;;

  personal-project)
    echo "⚙️ Initializing Personal Project / External Codebase in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills .agents/context .agents/scripts .agents/logs .agents/changes

    # Copy rules & skills
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/personal-projects/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/personal-projects/skills/* .agents/skills/

    # Copy verification & session end scripts
    cp "$SCRIPT_DIR"/general/scripts/session-end-check.sh .agents/scripts/session-end-check.sh
    cp "$SCRIPT_DIR"/general/scripts/verify-template.sh .agents/scripts/verify.sh
    chmod +x .agents/scripts/*.sh

    # Initialize onboarding, diary, reservations & roadmap
    [[ -f .agents/DEV_DIARY.md ]] || cp "$SCRIPT_DIR"/general/templates/dev-diary-template.md .agents/DEV_DIARY.md
    [[ -f .agents/START_HERE.md ]] || cp "$SCRIPT_DIR"/general/templates/start-here-template.md .agents/START_HERE.md
    [[ -f .agents/reservations.json ]] || cp "$SCRIPT_DIR"/personal-projects/templates/reservations-template.json .agents/reservations.json
    [[ -f .agents/todo.md ]] || touch .agents/todo.md

    # Isolate via .git/info/exclude if git repo exists, otherwise .gitignore
    if [[ -d .git ]]; then
      mkdir -p .git/info
      grep -qxF ".agents/" .git/info/exclude 2>/dev/null || echo -e "\n# Local agent workspace\n.agents/" >> .git/info/exclude
    else
      echo -e "\n# Local agent workspace\n.agents/" >> .gitignore
    fi
    echo "✅ Personal Project / External Codebase environment ready (Safe Guardian mode)."
    ;;

  ai-dev-tools)
    echo "⚙️ Initializing AI Dev Tools project in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills .agents/scripts agent-capabilities agent-hooks mcp-server docs evals prompts scripts

    # Universal standards + AI Dev Tools specific rules
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ai-dev-tools/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ai-dev-tools/skills/* .agents/skills/
    cp "$SCRIPT_DIR"/general/scripts/session-end-check.sh .agents/scripts/session-end-check.sh
    cp "$SCRIPT_DIR"/ai-dev-tools/scripts/test-mcp-tools.py scripts/test-mcp-tools.py
    chmod +x .agents/scripts/*.sh scripts/*.py

    # Shared asynchronous state & concurrent multi-agent coordination
    [[ -f .agents/DEV_DIARY.md ]] || cp "$SCRIPT_DIR"/general/templates/dev-diary-template.md .agents/DEV_DIARY.md
    [[ -f .agents/START_HERE.md ]] || cp "$SCRIPT_DIR"/general/templates/start-here-template.md .agents/START_HERE.md
    [[ -f .agents/reservations.json ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/reservations-template.json .agents/reservations.json
    [[ -f .agents/todo.md ]] || touch .agents/todo.md
    [[ -f AGENTS.md ]] || cp "$SCRIPT_DIR"/AGENTS.md ./AGENTS.md

    # FastMCP boilerplate, LLM evaluation suite & prompt catalog
    [[ -f mcp-server/server.py ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/fastmcp-starter.py mcp-server/server.py
    [[ -f evals/run_evals.py ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/evals-template.py evals/run_evals.py
    [[ -f evals/eval_cases.json ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/eval-cases-template.json evals/eval_cases.json
    [[ -f prompts/system_prompt.md ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/system-prompt-template.md prompts/system_prompt.md
    [[ -f docs/zoomcamp-review-checklist.md ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/zoomcamp-review-checklist.md docs/zoomcamp-review-checklist.md

    # Lightweight single-file Docker Compose template
    [[ -f docker-compose.yml ]] || cp "$SCRIPT_DIR"/ai-dev-tools/templates/docker-compose-template.yml ./docker-compose.yml
    echo "✅ AI Dev Tools environment ready (Committed repo mode with FastMCP, Evals, Prompts & Multi-Agent Coordination)."
    ;;

  ml-zoomcamp)
    echo "⚙️ Initializing ML Zoomcamp agent workspace in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills .agents/templates .agents/scripts
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ml-zoomcamp/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ml-zoomcamp/skills/* .agents/skills/
    cp -r "$SCRIPT_DIR"/ml-zoomcamp/templates/* .agents/templates/

    cp "$SCRIPT_DIR"/general/scripts/session-end-check.sh .agents/scripts/session-end-check.sh
    chmod +x .agents/scripts/*.sh

    [[ -f .agents/DEV_DIARY.md ]] || cp "$SCRIPT_DIR"/general/templates/dev-diary-template.md .agents/DEV_DIARY.md
    [[ -f .agents/START_HERE.md ]] || cp "$SCRIPT_DIR"/general/templates/start-here-template.md .agents/START_HERE.md

    # Ensure local-only isolation
    if [[ -f .gitignore ]]; then
      grep -qxF ".agents/" .gitignore || echo -e "\n# Local agent configuration\n.agents/\nAGENTS.md\ntodo.md" >> .gitignore
    else
      echo -e "# Local agent configuration\n.agents/\nAGENTS.md\ntodo.md" > .gitignore
    fi
    echo "✅ ML Zoomcamp environment ready (Local-only mode)."
    ;;

  *)
    echo "❌ Unknown mode: $MODE. Choose from: fullstack-production, personal-project, ai-dev-tools, ml-zoomcamp"
    exit 1
    ;;
esac
