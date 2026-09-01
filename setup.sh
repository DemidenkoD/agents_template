#!/usr/bin/env bash
# ==============================================================================
# DataTalks.Club Agent Template Bootstrapper
# Usage: ./setup.sh <mode> <target_directory>
# Modes:
#   - ml-zoomcamp       : Interactive learning mode (local-only .agents/)
#   - ai-dev-tools      : Autonomous lead mode (committed .agents/ & extension pack)
#   - personal-project  : Safe guardian mode (local-only .agents/ with context/scripts/logs/changes)
# ==============================================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MODE="${1:-}"
TARGET_DIR="${2:-}"

if [[ -z "$MODE" || -z "$TARGET_DIR" ]]; then
  echo "Usage: $0 <ml-zoomcamp | ai-dev-tools | personal-project> <target_directory>"
  exit 1
fi

mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

case "$MODE" in
  ml-zoomcamp)
    echo "⚙️ Initializing ML Zoomcamp agent workspace in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills .agents/templates
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ml-zoomcamp/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ml-zoomcamp/skills/* .agents/skills/
    cp -r "$SCRIPT_DIR"/ml-zoomcamp/templates/* .agents/templates/

    # Ensure local-only isolation
    if [[ -f .gitignore ]]; then
      grep -qxF ".agents/" .gitignore || echo -e "\n# Local agent configuration\n.agents/\nAGENTS.md\ntodo.md" >> .gitignore
    else
      echo -e "# Local agent configuration\n.agents/\nAGENTS.md\ntodo.md" > .gitignore
    fi
    echo "✅ ML Zoomcamp environment ready (Local-only mode)."
    ;;

  ai-dev-tools)
    echo "⚙️ Initializing AI Dev Tools project in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills agent-capabilities agent-hooks mcp-server docs
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ai-dev-tools/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/ai-dev-tools/skills/* .agents/skills/
    cp "$SCRIPT_DIR"/AGENTS.md ./AGENTS.md
    echo "✅ AI Dev Tools environment ready (Committed repo mode)."
    ;;

  personal-project)
    echo "⚙️ Initializing Personal Project / External Codebase in $TARGET_DIR..."
    mkdir -p .agents/rules .agents/skills .agents/context .agents/scripts .agents/logs .agents/changes
    cp -r "$SCRIPT_DIR"/general/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/personal-projects/rules/* .agents/rules/
    cp -r "$SCRIPT_DIR"/personal-projects/skills/* .agents/skills/
    touch .agents/todo.md

    # Isolate via .git/info/exclude if git repo exists, otherwise .gitignore
    if [[ -d .git ]]; then
      mkdir -p .git/info
      grep -qxF ".agents/" .git/info/exclude 2>/dev/null || echo -e "\n# Local agent workspace\n.agents/" >> .git/info/exclude
    else
      echo -e "\n# Local agent workspace\n.agents/" >> .gitignore
    fi
    echo "✅ Personal Project / External Codebase environment ready (Safe Guardian mode)."
    ;;

  *)
    echo "❌ Unknown mode: $MODE. Choose from: ml-zoomcamp, ai-dev-tools, personal-project"
    exit 1
    ;;
esac

