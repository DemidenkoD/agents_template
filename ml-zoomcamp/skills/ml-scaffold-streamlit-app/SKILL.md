---
name: ml-scaffold-streamlit-app
description: Generates an interactive Streamlit web UI in app/app.py for feature input, inference execution, probability visualization, and qualitative badges.
---

# Skill: ML Scaffold Streamlit App

## Purpose
Scaffolds an end-to-end Streamlit web interface (`app/app.py`) for tabular ML model inference.

## Procedural Steps
1. Load model artifact using `joblib` inside Streamlit `@st.cache_resource`.
2. Create input sidebar / form controls matching feature column definitions (sliders for numerical features, dropdowns for categoricals).
3. Connect inputs to inference logic from `src/predict.py`.
4. Render output badges (e.g. Risk Level, Class Prediction) and probability progress bars or charts.
5. Provide command to run app: `uv run streamlit run app/app.py`.

