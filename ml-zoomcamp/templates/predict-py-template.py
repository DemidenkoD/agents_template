"""
Production Inference Script
"""
import joblib
import pandas as pd

class ModelPredictor:
    def __init__(self, model_path: str = "models/model.joblib"):
        self.model = joblib.load(model_path)

    def predict_single(self, input_dict: dict) -> dict:
        """
        Runs inference on a single dictionary input record.
        """
        df = pd.DataFrame([input_dict])
        prediction = self.model.predict(df)[0]
        
        probabilities = None
        if hasattr(self.model, "predict_proba"):
            probs = self.model.predict_proba(df)[0]
            probabilities = {int(cls): float(prob) for cls, prob in zip(self.model.classes_, probs)}
            
        return {
            "prediction": int(prediction),
            "probabilities": probabilities
        }

if __name__ == "__main__":
    predictor = ModelPredictor()
    sample_payload = {"feature1": 10.5, "category_col": "A"}
    result = predictor.predict_single(sample_payload)
    print("Inference Result:", result)

