# Rule: Preserve User Code in Training Notebooks

- **Trigger:** Editing or updating Jupyter notebooks (`*.ipynb`) in ML Zoomcamp projects
- **Scope:** `01_eda.ipynb`, `02_model_experiments.ipynb`, `03_baseline_and_models.ipynb`, and any user training notebook.

## Policy
1. **Non-Destructive Editing:** NEVER delete, wipe, or replace existing user code or markdown notes inside training notebooks.
2. **Additive Modifications:** The agent may add new tutorial cells, append explanatory markdown, or insert template function bodies below user code, but must preserve all user experimentation.
3. **Rationale:** Learners use training notebooks for active exploration, note-taking, and hands-on learning. Purging user cells destroys study context.

