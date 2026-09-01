"""
Production Pipeline Training & Serialization Script
"""
import os
import joblib
import pandas as pd
from sklearn.pipeline import Pipeline
from sklearn.ensemble import RandomForestClassifier
from column_transformer_snippet import create_preprocessing_pipeline

def train_model(data_path: str, output_model_path: str):
    """
    Loads dataset, trains pipeline, and serializes final model artifact.
    """
    df = pd.read_csv(data_path)
    target = 'target'
    
    X = df.drop(columns=[target])
    y = df[target]
    
    num_cols = X.select_dtypes(include=['int64', 'float64']).columns.tolist()
    cat_cols = X.select_dtypes(include=['object', 'category']).columns.tolist()
    
    preprocessor = create_preprocessing_pipeline(num_cols, cat_cols)
    model = RandomForestClassifier(n_estimators=100, random_state=42)
    
    pipeline = Pipeline(steps=[
        ('preprocessor', preprocessor),
        ('model', model)
    ])
    
    print("Fitting model pipeline...")
    pipeline.fit(X, y)
    
    os.makedirs(os.path.dirname(output_model_path), exist_ok=True)
    joblib.dump(pipeline, output_model_path)
    print(f"Model saved successfully to {output_model_path}")

if __name__ == "__main__":
    train_model("data/raw/dataset.csv", "models/model.joblib")

