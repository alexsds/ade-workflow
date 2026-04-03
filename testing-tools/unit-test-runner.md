# Unit Test Runner

## Applies To

All features that include application code. Unit tests verify individual functions, modules, and components work correctly in isolation.

## Setup

Detect the project's test framework by checking for:
- `package.json` scripts (jest, vitest, mocha, pytest, etc.)
- Test configuration files (jest.config.*, vitest.config.*, pytest.ini, etc.)
- Existing test directories (tests/, __tests__/, spec/, test/)

## How To Use

1. Identify the test framework:
   ```bash
   # Check package.json for test script
   cat package.json | jq '.scripts.test'

   # Check for test config files
   ls *test* *spec* vitest* jest* pytest* 2>/dev/null
   ```

2. Run the full test suite:
   ```bash
   # Node.js projects
   npm test
   # or
   npx vitest run
   # or
   npx jest

   # Python projects
   pytest

   # Go projects
   go test ./...
   ```

3. Run tests for specific files related to the feature:
   ```bash
   # Run tests matching a pattern
   npx vitest run --reporter=verbose auth
   npx jest --verbose auth
   pytest -v tests/test_auth.py
   ```

4. Check test coverage if configured:
   ```bash
   npx vitest run --coverage
   npx jest --coverage
   pytest --cov
   ```

## What To Check

- All existing tests still pass (no regressions)
- New feature has corresponding tests
- Tests cover happy path and key error cases
- Test names clearly describe what they verify
- No skipped or pending tests without explanation
- Coverage does not decrease from baseline
