# Rule: The 4-Part Tutorial Cell Standard for Learning

- **Trigger:** Generating or editing exercises in ML Zoomcamp training notebooks
- **Scope:** Interactive training notebooks (`01_eda.ipynb`, `02_...`)

## Core Learning Philosophy
Training notebooks are designed for **hands-on student learning**. The user writes the code themselves. The agent's role is to optimize learning speed by providing documentation shortcuts, tricks & tips, edge cases, and rich conceptual explanations so the user doesn't waste time searching external docs.

## The 4-Part Tutorial Cell Structure
Every tutorial exercise cell MUST strictly follow this exact 4-part structure:

### 1. 🎯 Objectives & Fast-Track Documentation
- 1–3 concise bullet points defining the task goal.
- Quick doc shortcuts & key API parameter references (e.g. `pd.read_csv(..., usecols=...)`, `fillna(method=...)`).

### 2. 💡 Conceptual Intuition, Tricks & Tips
- **Intuition:** Explain what the concept is and why it's needed in plain English.
- **Tricks & Tips:** Highlight common pitfalls (e.g. inplace mutation vs returned copies, memory optimizations, edge cases on missing values).
- **Alternative Use Cases:** Briefly mention alternative functions or scikit-learn/pandas parameters.

### 3. ✍️ Workspace (`# YOUR CODE HERE`)
- Predefine all variable names, column lists, mapping dicts, and constants so the user focuses purely on ML logic rather than manual typing.
- Provide clean function signatures with `# TODO` bodies and ready-to-run test invocations.

### 4. 🔍 Collapsible Solution (`<details><summary>Solution</summary> ... </details>`)
- Complete, verified solution hidden inside an expandable HTML details block with a brief takeaway on why this implementation matters.
