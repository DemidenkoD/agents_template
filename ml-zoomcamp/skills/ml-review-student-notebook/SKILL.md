---
name: ml-review-student-notebook
description: Inspects student-completed training notebooks, checks logic, verifies outputs, and provides feedback without modifying user code cells.
---

# Skill: ML Review Student Notebook

## Purpose
Reviews code written by the student in interactive training notebooks (`01_eda.ipynb`, `02_model_experiments.ipynb`). Validates execution outputs, detects bugs or target leakage, and offers constructive suggestions without wiping or overwriting student code.

## Procedural Steps
1. **Read Student Notebook:**
   - View student code cells and markdown notes in training notebook files.
2. **Logic & Execution Audit:**
   - Verify correctness of feature transformations, missing value handling, and split strategy.
   - Audit for common ML bugs (e.g. data leakage, fitting scaler on validation/test set, wrong evaluation metric).
3. **Provide Feedback:**
   - Summarize code review findings in markdown responses or non-destructive feedback cells appended at the bottom.
   - Point out edge cases or performance improvements.
4. **Approve for Production Transfer:**
   - Once verified, signal readiness for Stage 5 (`ml-extract-pipeline-scripts`).

