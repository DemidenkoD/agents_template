# Rule: KaTeX & LaTeX Math Formatting in Notebooks

- **Trigger:** Writing LaTeX / KaTeX math in Jupyter Markdown cells
- **Scope:** All Jupyter Notebook markdown cells

## Critical Formatting Rule
In Jupyter Markdown, **never** indent multiline display math `$$ ... $$` inside bullet points or blockquotes. VS Code and Jupyter Markdown parsers treat indented math as code blocks, triggering `ParseError: KaTeX parse error: Can't use function '$' in math mode`.

## Standard Math Rules
1. **Inline Math:** Use single dollar signs `$ ... $` on a single line (e.g., `$\text{Accuracy} = \frac{\text{TP} + \text{TN}}{\text{Total}}$`).
2. **Display Math:** Place `$$ ... $$` display math blocks as standalone paragraphs separated by blank lines above and below, with ZERO leading indentation.

