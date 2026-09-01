# Rule: Large Data Files & Model Weights Guardrail

- **Trigger:** Downloading datasets, serializing models, staging files with Git
- **Scope:** Universal across all projects (ML Zoomcamp, Data Engineering, AI Dev Tools, Personal Projects)

## Policy

1. **Automatic `.gitignore` for Datasets & Models:**
   - Raw datasets (`data/raw/`, `data/processed/`, `*.csv`, `*.parquet`, `*.jsonl`, `*.tsv`) must be added to `.gitignore`.
   - Heavy serialized weights and checkpoints (`*.pt`, `*.pth`, `*.bin`, `*.onnx`, large `*.joblib` > 50MB) must be excluded from Git tracking.

2. **Pre-Commit File Size Checks:**
   - Never stage (`git add`) files exceeding 10MB without explicit user confirmation.
   - Prevent repository bloat and GitHub push rejections (GitHub 100MB hard limit).

3. **Reproducible Data Ingestion:**
   - Code should download or generate datasets reproducibly (e.g. via download scripts, `wget`, or Kaggle CLI) rather than checking large binary files into version control.

