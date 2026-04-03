# Code Architecture Rubric

## Applies To

Features involving backend logic, data models, business logic, module structure, or any code organization decisions.

## Criteria

### Separation of Concerns (weight: high)

Threshold: 7/10

Code should be organized into modules with clear responsibilities. Each file, function, and class should do one thing well. Business logic should not be tangled with UI rendering, data access, or API handling.

Evaluate: Are concerns properly separated? Can you change one layer without affecting others? Are dependencies flowing in one direction?

### Code Clarity (weight: high)

Threshold: 7/10

Code should be readable without comments explaining what it does. Names should be descriptive and accurate. Functions should be short and focused. Complex logic should be broken into well-named steps.

Evaluate: Can a developer understand each function's purpose from its name? Are variable names descriptive? Is control flow straightforward? Is nesting depth reasonable (max 3 levels)?

### Error Handling (weight: medium)

Threshold: 6/10

Errors should be handled at system boundaries (user input, external APIs, database operations). Internal code should use types and assertions, not defensive programming everywhere.

Evaluate: Are external inputs validated? Do API calls handle failure cases? Are error messages informative? Is there appropriate logging?

### Testability (weight: medium)

Threshold: 6/10

Code should be structured so that individual units can be tested in isolation. Dependencies should be injectable. Side effects should be contained.

Evaluate: Can functions be tested without mocking everything? Are side effects isolated? Is state management predictable?

## Scoring Guide

- 9-10: Exceptional — clean architecture, excellent naming, easy to extend
- 7-8: Solid — well-organized, readable, follows established patterns
- 5-6: Acceptable — works but has some structural issues or unclear naming
- 3-4: Below standards — tangled concerns, hard to follow, poor naming
- 1-2: Failing — no discernible structure, everything in one file/function
