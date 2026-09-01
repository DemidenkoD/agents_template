# Rule: Dual-Notebook Workflow Strategy

- **Trigger:** ML Zoomcamp notebook creation and refactoring
- **Scope:** ML Zoomcamp projects

## Policy

1. **Interactive Training Notebooks (`01_eda.ipynb`, `02_model_experiments.ipynb`, etc.):**
   - Focused on student hands-on learning. The user writes code while the agent provides documentation shortcuts, tricks & tips, edge cases, and 4-part tutorial exercise cells with expandable solutions.
   - Purpose: Fast learning, documentation discovery, experimentation, and hypothesis testing.

2. **Clean Production Notebook (`notebook_main.ipynb`):**
   - Clean, verified, end-to-end executable pipeline code only.
   - Starts with a concise Table of Contents and clean Markdown headers.
   - **No Inline Code Clutter:** Code cells contain zero redundant inline comments; explanations are provided exclusively in short Markdown headers above code cells.
   - Logic is copied into `notebook_main.ipynb` incrementally only after verification in training notebooks.
