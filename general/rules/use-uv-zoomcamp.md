# Rule: Mandatory `uv` Package Manager for Zoomcamps

- **Trigger:** DataTalks.Club course projects (ML Zoomcamp, Data Engineering Zoomcamp, MLOps Zoomcamp)
- **Scope:** Zoomcamp repositories and projects

## Policy
1. **Default Tooling:** `uv` is the mandatory Python project and environment manager for all Zoomcamp projects.
2. **Commands:**
   - Project initialization: `uv init`
   - Adding packages: `uv add <package_name>`
   - Removing packages: `uv remove <package_name>`
   - Virtual environment execution: `uv run <command>`
   - Creating/managing virtualenvs: `uv venv`
3. **Legacy Pip Prohibition:** Do NOT use standard `pip install` or `pipenv` directly in Zoomcamp projects when `uv` is supported.

