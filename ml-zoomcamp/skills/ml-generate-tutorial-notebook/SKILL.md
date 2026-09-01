---
name: ml-generate-tutorial-notebook
description: Pre-populates imports, static strings, column lists, and function stubs with hidden solution blocks for student self-coding.
---

# Skill: ML Generate Tutorial Notebook

## Purpose
Generates interactive training notebooks (`01_eda.ipynb`, `02_model_experiments.ipynb`) designed to maximize student learning by eliminating copy-paste boilerplate while keeping core implementation work for the student.

## Key Features
1. **Predefined Constants & Boilerplate:**
   - Pre-populate all package imports (`pandas`, `numpy`, `sklearn`, `matplotlib`).
   - Pre-define all column names, feature lists, array constants, target column strings, mapping dictionaries, and file paths at the top of exercise cells.
   - Provide function/class stubs with docstrings, signatures, `# TODO` bodies, and ready-to-run test calls.
2. **Hidden Expandable Solutions:**
   - Embed complete working solutions in hidden HTML blocks (`<details><summary>Solution</summary>`) so the student can check their work or recover if stuck.
3. **Documentation Shortcuts & Tips:**
   - Include inline doc references, API signatures, parameter hints, and tips/tricks in the 🎯 Objectives and 💡 Intuition sections.
