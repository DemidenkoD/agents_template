"""
Model Evaluation Helper Snippet
"""
import pandas as pd
import numpy as np
from sklearn.metrics import (
    accuracy_score,
    precision_score,
    recall_score,
    f1_score,
    roc_auc_score,
    confusion_matrix
)

def evaluate_model(y_true: np.ndarray, y_pred: np.ndarray, y_proba: np.ndarray | None = None, model_name: str = "Model") -> dict:
    """
    Evaluates model predictions and prints key performance metrics.
    """
    metrics = {
        "Model": model_name,
        "Accuracy": accuracy_score(y_true, y_pred),
        "Precision": precision_score(y_true, y_pred, zero_division=0),
        "Recall": recall_score(y_true, y_pred, zero_division=0),
        "F1 Score": f1_score(y_true, y_pred, zero_division=0),
    }
    
    if y_proba is not None:
        try:
            metrics["ROC-AUC"] = roc_auc_score(y_true, y_proba)
        except ValueError:
            metrics["ROC-AUC"] = None
            
    print(f"=== {model_name} Evaluation ===")
    for k, v in metrics.items():
        if isinstance(v, float):
            print(f"{k}: {v:.4f}")
        else:
            print(f"{k}: {v}")
    print("\nConfusion Matrix:")
    print(confusion_matrix(y_true, y_pred))
    print("=" * 30)
    
    return metrics

