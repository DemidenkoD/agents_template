---
name: ml-scaffold-project
description: Initializes an ML Zoomcamp project repository structure with uv, pyproject.toml, standard folders (data, notebooks, src, app, tests), .gitignore, and todo.md checklist.
---

# Skill: ML Scaffold Project

## Purpose
Sets up a standardized, modular directory layout for ML Zoomcamp homeworks, midterm, or capstone projects using `uv` for package management.

## Project Structure Produced
```text
project_root/
├── data/
│   ├── raw/
│   └── processed/
├── notebooks/
│   ├── 01_eda.ipynb
│   ├── 02_model_experiments.ipynb
│   └── notebook_main.ipynb
├── src/
│   ├── __init__.py
│   ├── preprocess.py
│   ├── train.py
│   └── predict.py
├── app/
│   └── app.py
├── tests/
│   └── test_predict.py
├── pyproject.toml
├── .gitignore
├── Dockerfile
├── README.md
└── todo.md
```

## Procedural Steps
1. Run `uv init` to create `pyproject.toml` and `.venv`.
2. Add core ML Zoomcamp dependencies:
   `uv add pandas numpy scikit-learn matplotlib seaborn joblib streamlit pytest`
3. Create standard directories: `data/raw`, `data/processed`, `notebooks`, `src`, `app`, `tests`.
4. Copy `templates/todo-roadmap-template.md` to `todo.md`.
5. Create `.gitignore` covering dataset files (`data/raw/*`, `data/processed/*`), `.venv/`, `__pycache__/`, `*.pkl`, `*.joblib`.

