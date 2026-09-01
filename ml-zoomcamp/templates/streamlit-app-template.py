"""
Streamlit Web UI Template for Model Inference
"""
import streamlit as st
import pandas as pd
import joblib

st.set_page_config(page_title="ML Inference Portal", page_icon="🤖", layout="wide")

@st.cache_resource
def load_model(model_path: str = "models/model.joblib"):
    return joblib.load(model_path)

def main():
    st.title("🤖 ML Zoomcamp Inference Dashboard")
    st.markdown("Enter feature attributes to receive real-time model predictions.")

    model = load_model()

    st.sidebar.header("Input Features")
    feature1 = st.sidebar.number_input("Feature 1", value=10.0, step=0.5)
    category1 = st.sidebar.selectbox("Category 1", ["Category A", "Category B", "Category C"])

    input_payload = {
        "feature1": feature1,
        "category1": category1
    }

    if st.sidebar.button("Run Inference", type="primary"):
        df_input = pd.DataFrame([input_payload])
        prediction = model.predict(df_input)[0]

        st.subheader("Results")
        col1, col2 = st.columns(2)

        with col1:
            st.metric("Predicted Class", value=str(prediction))

        if hasattr(model, "predict_proba"):
            with col2:
                probs = model.predict_proba(df_input)[0]
                st.write("Class Probabilities:")
                for cls, prob in zip(model.classes_, probs):
                    st.progress(float(prob), text=f"Class {cls}: {prob:.2%}")

if __name__ == "__main__":
    main()

