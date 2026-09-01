# Rule: ML Zoomcamp End-to-End Workflow Pipeline

- **Trigger:** ML Zoomcamp homeworks, midterm, and capstone projects
- **Scope:** ML Zoomcamp projects

## The 6-Stage Workflow Pipeline

1. **Stage 1: Project Scaffolding (`ml-scaffold-project`)**
   - Initialize project environment with `uv`, directory layout (`data/`, `notebooks/`, `src/`, `app/`, `tests/`), `.gitignore`, and `pyproject.toml`.

2. **Stage 2: Interactive TODO Generation (`scaffold-homework-todo`)**
   - Parse assignment specification / homework document and create an interactive `todo.md` checklist with actionable steps.

3. **Stage 3: Training Notebook Scaffolding (`ml-generate-tutorial-notebook`)**
   - Pre-populate all standard imports, static string constants, column lists, mapping dicts, and function/class signatures (`# TODO` stubs).
   - Eliminate tedious copy-pasting for the student while leaving core ML logic for student self-coding.
   - Include doc shortcuts, tips & tricks, and hidden expandable solution blocks (`<details><summary>Solution</summary>`).

4. **Stage 4: Student Self-Coding & Agent Code Review (`ml-review-student-notebook`)**
   - Student writes the implementation code in training notebooks.
   - Agent reviews student code, checks outputs against expectations, and provides feedback/hints without overwriting user cells.

5. **Stage 5: Non-Destructive Production Extraction (`ml-extract-pipeline-scripts`)**
   - Extract verified logic from training notebooks into clean production notebooks (`notebook_main.ipynb`) or modular Python scripts/classes (`src/train.py`, `src/predict.py`).
   - Preserve all user training notebooks intact.

6. **Stage 6: Testing & App Scaffolding (`ml-scaffold-streamlit-app`)**
   - Generate unit tests (`tests/test_predict.py`) verifying pipeline logic.
   - Scaffold Streamlit web application (`app/app.py`) and Docker container.

