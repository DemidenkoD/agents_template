# 🚀 ML Zoomcamp Project Checklist & Roadmap

- [ ] **Stage 1: Environment & Project Scaffolding**
  - [ ] Initialize repository with `uv init`
  - [ ] Create folder structure (`data/`, `notebooks/`, `src/`, `app/`, `tests/`)
  - [ ] Add `.gitignore` and `pyproject.toml` dependencies

- [ ] **Stage 2: Problem Formulation & Data Loading**
  - [ ] Define business problem, target variable, and evaluation metric
  - [ ] Download raw dataset into `data/raw/`
  - [ ] Verify data types and check target distribution

- [ ] **Stage 3: Exploratory Data Analysis (EDA)**
  - [ ] Missing value analysis and imputation strategy
  - [ ] Feature correlation analysis
  - [ ] Target leakage audit
  - [ ] Feature distribution inspection (skewness, outliers)

- [ ] **Stage 4: Validation Strategy**
  - [ ] Split dataset (Train / Validation / Test 60/20/20 or Stratified K-Fold)
  - [ ] Verify target distribution consistency across splits

- [ ] **Stage 5: Preprocessing & Feature Engineering**
  - [ ] Set up `ColumnTransformer` for numerical and categorical features
  - [ ] Handle missing values (`SimpleImputer`)
  - [ ] Encode categorical variables (`OneHotEncoder` / `OrdinalEncoder`)
  - [ ] Scale numerical features (`StandardScaler` / `MinMaxScaler`)

- [ ] **Stage 6: Model Training & Experimentation**
  - [ ] Train baseline model (e.g. LogisticRegression / Ridge)
  - [ ] Train Tree-based models (DecisionTree, RandomForest)
  - [ ] Train Gradient Boosting models (XGBoost / LightGBM)
  - [ ] Compare baseline performance table (Accuracy, Precision, Recall, F1, ROC-AUC)

- [ ] **Stage 7: Hyperparameter Tuning**
  - [ ] GridSearch / RandomSearch / Optuna tuning on best candidate model
  - [ ] Evaluate tuned model on validation set

- [ ] **Stage 8: Final Model Evaluation**
  - [ ] Evaluate final tuned model on holdout Test set
  - [ ] Plot Confusion Matrix & ROC Curve

- [ ] **Stage 9: Production Script Extraction (`src/`)**
  - [ ] Refactor preprocessing & model training into `src/train.py`
  - [ ] Serialize model artifact (`models/model.joblib`)
  - [ ] Create inference pipeline in `src/predict.py`

- [ ] **Stage 10: Web Application Scaffolding (`app/`)**
  - [ ] Scaffold Streamlit web app in `app/app.py`
  - [ ] Connect input fields to `predict.py` logic
  - [ ] Verify local inference execution

- [ ] **Stage 11: Containerization & Deployment**
  - [ ] Create `Dockerfile`
  - [ ] Build and test Docker container locally

