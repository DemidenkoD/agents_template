# Rule: Clean Production Code & Minimal Commenting Policy

- **Trigger:** Generating or refactoring clean production notebooks (`notebook_main.ipynb`) or production Python scripts (`src/train.py`, `src/predict.py`)
- **Scope:** Production notebooks and standalone Python scripts

## Policy
1. **No Code Clutter / No Inline Comment Overuse:**
   - Do NOT clutter Python code blocks with line-by-line inline code comments.
   - Code should be clean, idiomatic, self-documenting, and free of redundant inline explanations.
2. **Markdown Header Explanations Only:**
   - In production notebooks (`notebook_main.ipynb`), place short, concise explanations in Markdown cells *above* code cells (e.g. `### 1. Data Preprocessing Pipeline`).
3. **Docstring Discipline:**
   - Use concise standard docstrings for public functions and classes, but avoid inline trivia inside function bodies.

