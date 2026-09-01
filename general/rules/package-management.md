# Rule: Flexible Package Management & Hygiene

- **Trigger:** Package installation or dependency modifications
- **Scope:** Universal across all projects and workspaces

## Policy
1. **Freedom to Install:** The agent is free to install packages required to solve tasks, run tests, analyze datasets, or build features (e.g. using `uv add`, `pip install`, `npm install`).
2. **Package Cleanup:** When temporary debugging tools, test dependencies, or exploratory packages are no longer required, the agent must clean them up (`uv remove`, `pip uninstall`, `npm uninstall`).
3. **Lockfile Discipline:** Always ensure dependency files (`pyproject.toml`, `uv.lock`, `package.json`, `requirements.txt`) stay synchronized and clean.

