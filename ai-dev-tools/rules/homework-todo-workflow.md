# Rule: Interactive Homework TODO Workflow

- **Trigger:** Processing or starting Zoomcamp homework assignments (AI Dev Tools, ML Zoomcamp, etc.)
- **Scope:** Homework projects and assignments

## Policy
1. **Interactive TODO List Generation:** When given a homework document (URL or markdown file), the agent MUST parse the assignment and generate a structured `todo.md` file at the root of the project.
2. **Step-by-Step Task Decomposition:**
   - Group tasks clearly by Question (e.g. `Question 1: Initial Implementation`, `Question 2: Integration Tests`).
   - Break down each question into actionable, step-by-step checkboxes.
   - Include specific terminal commands, invocation prompts, or documentation references for each step.
3. **Progress Tracking:** Update `todo.md` checkboxes as tasks are executed and verified.

