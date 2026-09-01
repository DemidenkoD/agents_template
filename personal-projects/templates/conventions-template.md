# Discovered Project Conventions: [Project Name]

## 1. Code Formatting & Style
- **Indentation & Formatting:** [e.g. 4 spaces, Black/Ruff formatting]
- **Naming Standards:**
  - Files/Modules: `snake_case.py`
  - Classes: `PascalCase`
  - Functions & Variables: `snake_case`
  - Constants: `UPPER_SNAKE_CASE`

## 2. Type Annotations & Static Typing
- **Typing Strictness:** [e.g. Full type hints on all function parameters and return types]
- **Data Modeling:** [e.g. Pydantic v2 `BaseModel`, dataclasses, TypedDict]

## 3. Error Handling & Logging
- **Exception Patterns:** [Custom exception classes inheriting from `AppException`]
- **Logging Library & Style:** [e.g. `structlog` with JSON output, standard `logging.getLogger(__name__)`]

## 4. Testing Conventions & Patterns
- **Framework:** `pytest`
- **Fixtures:** Defined in `tests/conftest.py`
- **Mocking Library:** `unittest.mock` or `pytest-mock`
- **Assertion Style:** Plain pytest assertions (`assert result == expected`)

