# Changelog

All notable changes to the ADE plugin will be documented in this file.

## [0.1.0] - 2026-04-03

### Added

- Three-agent harness: Planner, Generator, Evaluator
- Interactive planner with research phase and adaptive questions with suggested answers
- Scope-adaptive planning — scales from full apps to bug fixes (large/medium/small)
- Generation skill covering 4-phase build workflow and pivot-vs-refine iteration strategy
- Evaluation skill with adversarial stance, graded scoring, and hard thresholds
- Skills-as-source-of-truth architecture — agents reference skills for methodology
- `/ade:plan [idea / feature / task / problem]` — research, ask questions, create plan
- `/ade:execute` — launch Generator + Evaluator agent team with explicit TeamCreate
- `/ade:done` — archive completed plan with completion metadata
- `/ade:status` — report progress, scores, and blockers
- Frontend design rubric with few-shot calibration examples
- Code architecture rubric
- API quality rubric
- UX flows rubric
- Playwright browser testing tool (auto-configured via .mcp.json, falls back to curl)
- API endpoint testing tool
- Unit test runner (auto-detects framework)
- Session start hook for ADE status reporting
- Project initialization script (`scripts/init-project.sh`)
- Rubric and testing tool validation scripts
- Pluggable override system — project `.ade/rubrics/` and `.ade/testing-tools/` override plugin defaults
- Configurable commit styles — conventional (default) and jira
- Plan examples at all three scope levels
