---
name: ml-extract-pipeline-scripts
description: Parses verified training notebooks into clean production notebooks (notebook_main.ipynb) or src/ scripts, and generates pytest unit tests.
---

# Skill: ML Extract Pipeline Scripts

## Purpose
Parses verified student implementations from training notebooks and refactors them into clean production artifacts (`notebook_main.ipynb` or modular `src/` Python classes) along with unit tests.

## Procedural Steps
1. **Parse Training Notebooks Non-Destructively:**
   - Read verified code cells from training notebooks (`01_eda.ipynb`, `02_...`).
   - Do NOT overwrite or alter user cells in training notebooks.
2. **Generate Production Artifacts:**
   - Option A: Clean production notebook `notebook_main.ipynb` (clean code cells with Markdown section headers above, zero inline comment clutter).
   - Option B: Modular Python classes/scripts (`src/preprocess.py`, `src/train.py`, `src/predict.py`).
3. **Generate Unit Tests:**
   - Write pytest test suite in `tests/test_predict.py` and `tests/test_train.py` verifying data transformation shapes, model serialization, and inference payload execution.
4. **Execute & Verify Tests:**
   - Run `uv run pytest` to confirm all unit tests pass cleanly.
