# Changelog

All notable changes to the ADE plugin will be documented in this file.

## [0.1.0] - 2026-04-03

### Added

- Planner agent for product-level planning with user stories
- Generator agent for feature-by-feature implementation
- Evaluator agent with adversarial scoring against rubrics
- `/ade:plan` command to generate product-level plans
- `/ade:execute` command to launch Generator + Evaluator agent team
- `/ade:done` command to archive completed plans
- `/ade:status` command for progress reporting
- Planning skill with auto-triggering on app idea descriptions
- Evaluation skill with rubric and testing tool guidance
- Frontend design rubric (design quality, originality, craft, functionality)
- Code architecture rubric (separation of concerns, clarity, error handling, testability)
- API quality rubric (API design, responses, validation, security)
- UX flows rubric (flow coherence, edge cases, information architecture, feedback)
- Playwright browser testing tool config
- API endpoint testing tool config
- Unit test runner testing tool config
- Session start hook for ADE status reporting
- Project initialization script
- Rubric and testing tool validation scripts
