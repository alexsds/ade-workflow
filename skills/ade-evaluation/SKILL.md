---
name: ade-evaluation
description: This skill should be used when the user asks about evaluation methodology, scoring rubrics, testing tools, "how does scoring work", "evaluation criteria", "rubric format", "add a rubric", "create testing tool", "evaluate my feature", "run evaluation", "why did evaluation fail", or needs guidance on adversarial evaluation, graded scoring, or hard thresholds in the ADE workflow.
version: 0.1.0
---

# ADE Evaluation

## Overview

Adversarial evaluation methodology for the ADE workflow. Anthropic found that "out of the box, Claude is a poor QA agent" — evaluators identify real issues then self-justify approval anyway. To counter this, ADE uses graded scoring, hard thresholds, and an adversarial stance that prevents self-justification.

## Key Principles

**Adversarial stance:** Approach every feature from the perspective that bugs exist. Hunt for failures, not confirmations of correctness.

**Graded scoring:** Score each criterion 1-10 with hard thresholds. Any single criterion below threshold means the feature fails.

**Separate evaluator:** The agent that writes code **must never** evaluate it. Self-evaluation bias causes agents to praise their own mediocre work.

**No self-justification:** Identifying an issue and then explaining why it's acceptable is the core failure mode. If an issue exists, the feature fails. Period.

## Evaluation Workflow

When the Generator hands off a feature for review:

1. **Receive handoff** — Read the Generator's message describing what was built, files changed, and how to test
2. **Load rubrics** — Read rubrics from `${CLAUDE_PLUGIN_ROOT}/rubrics/` and `.ade/rubrics/`. Match the "Applies To" section against the feature type
3. **Load testing tools** — Read testing tools from `${CLAUDE_PLUGIN_ROOT}/testing-tools/` and `.ade/testing-tools/`. Select applicable tools
4. **Test the feature** — Use testing tools to verify functionality. Run the app, test interactions, check endpoints, execute test suites
5. **Score against rubrics** — Score each criterion 1-10. Compare against hard thresholds
6. **Report results** — Send scored report to Generator via SendMessage

Multiple rubrics can apply to a single feature. A user registration page might match `frontend-design.md` (UI), `ux-flows.md` (user journey), and `api-quality.md` (backend endpoints).

## Rubric System

Rubrics live in two locations:
- `${CLAUDE_PLUGIN_ROOT}/rubrics/` — plugin defaults (shipped with ADE)
- `.ade/rubrics/` — project-specific (user adds custom rubrics here)

Project rubrics override plugin defaults with the same filename.

### Default Rubrics

| Rubric | Applies To | Key Criteria |
|--------|-----------|-------------|
| `frontend-design.md` | UI components, pages, layouts | Design quality, originality, craft, functionality |
| `code-architecture.md` | Backend logic, data models | Separation of concerns, clarity, error handling, testability |
| `api-quality.md` | REST/GraphQL/WebSocket endpoints | API design, response quality, validation, security |
| `ux-flows.md` | Multi-step workflows, user journeys | Flow coherence, edge cases, information architecture, feedback |

### Rubric Format

Each rubric is a `.md` file with three required sections:

- **`## Applies To`** — What types of features this rubric evaluates
- **`## Criteria`** — Each criterion has a name, weight (high/medium/low), threshold (N/10), and description of what to evaluate
- **`## Scoring Guide`** — What each score range (1-2, 3-4, 5-6, 7-8, 9-10) means for this rubric

Example criterion:

```markdown
### Design Quality (weight: high)

Threshold: 7/10

The UI should feel like a coherent whole with a unified mood and identity.
Evaluate: Does the page feel like one designer built it?
```

### Adding Custom Rubrics

To add a custom rubric, create a `.md` file in `.ade/rubrics/` following the format above. The evaluator automatically discovers and uses rubrics from both locations. Validate the format with `${CLAUDE_PLUGIN_ROOT}/scripts/validate-rubric.sh`.

## Testing Tools System

Testing tools live in two locations:
- `${CLAUDE_PLUGIN_ROOT}/testing-tools/` — plugin defaults
- `.ade/testing-tools/` — project-specific

### Default Testing Tools

| Tool | Applies To | Method |
|------|-----------|--------|
| `playwright.md` | UI, web pages, interactions | Playwright MCP or curl fallback |
| `api-tester.md` | REST/GraphQL endpoints | curl with jq |
| `unit-test-runner.md` | All application code | Auto-detects test framework |

### Testing Tool Format

Each tool is a `.md` file with:
- **`## Applies To`** — What types of features this tool tests
- **`## Setup`** — Required configuration (MCP servers, dependencies)
- **`## How To Use`** — Step-by-step testing instructions
- **`## What To Check`** — Specific verification checklist

To add a custom testing tool, create a `.md` file in `.ade/testing-tools/`. Validate with `${CLAUDE_PLUGIN_ROOT}/scripts/validate-testing-tool.sh`.

## Scoring Methodology

| Score | Meaning |
|-------|---------|
| 9-10  | Exceptional, exceeds expectations |
| 7-8   | Solid, meets standards |
| 5-6   | Acceptable but needs improvement |
| 3-4   | Below standards, significant issues |
| 1-2   | Failing, fundamental problems |

A criterion with threshold 7 means scores 1-6 fail. Any single criterion below threshold causes the entire feature to fail. There is no averaging, no weighting override, no "overall pass."

## Evaluation Report Format

**On pass (all criteria meet thresholds):**
```
Feature: [name]
Status: APPROVED

Rubric: [rubric name]
| Criterion   | Score | Threshold | Status |
|-------------|-------|-----------|--------|
| [criterion] |   X   |     Y     |  PASS  |
```

**On fail (any criterion below threshold):**
```
Feature: [name]
Status: FAILED

Rubric: [rubric name]
| Criterion   | Score | Threshold | Status |
|-------------|-------|-----------|--------|
| [criterion] |   X   |     Y     |  FAIL  |

Failures:
- [criterion]: [specific description of what's wrong]

What to fix:
1. [specific actionable fix]
```

## Additional Resources

### Reference Files

For detailed scoring examples and methodology, consult:
- **`references/scoring-guide.md`** — Detailed scoring examples for each criterion level, evaluation philosophy, and weight guidelines
