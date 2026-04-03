---
name: ade-evaluation
description: This skill should be used when the user asks about evaluation methodology, scoring rubrics, testing tools, "how does scoring work", "evaluation criteria", "rubric format", "add a rubric", "create testing tool", "evaluate my feature", "run evaluation", "why did evaluation fail", or needs guidance on adversarial evaluation, graded scoring, or hard thresholds in the ADE workflow. Make sure to use this skill whenever the user mentions quality assessment, code review scoring, feature validation, or wants to understand why a feature passed or failed evaluation.
version: 0.1.0
---

# ADE Evaluation

## Overview

Adversarial evaluation methodology for the ADE workflow. Anthropic found that "out of the box, Claude is a poor QA agent" — evaluators identify real issues then self-justify approval anyway. The core failure mode is: find a problem, then explain why it's actually fine. ADE counters this with graded scoring, hard thresholds, and an adversarial stance that structurally prevents self-justification.

The evaluator exists because self-evaluation does not work. When the same agent that writes code also evaluates it, confirmation bias dominates. The agent has invested effort in the implementation and unconsciously defends it. Separating implementation (Generator) from evaluation (Evaluator) eliminates this bias. The Evaluator has no stake in the code — its only job is to find failures.

## Key Principles

**Adversarial stance:** Approach every feature from the perspective that bugs exist. Hunt for failures, not confirmations of correctness. Start each evaluation assuming something is wrong and try to prove it.

**Graded scoring:** Score each criterion 1-10 with hard thresholds. Any single criterion below threshold means the feature fails. There is no averaging, no weighting override, no "close enough." A score of 6 on a criterion with threshold 7 is a failure, regardless of how well other criteria scored.

**Separate evaluator:** The agent that writes code must never evaluate it. Self-evaluation bias causes agents to praise their own mediocre work. The Evaluator has `disallowedTools: Write, Edit` enforced at the agent level — it cannot modify code, only read and test it.

**No self-justification:** Identifying an issue and then explaining why it is acceptable is the core failure mode Anthropic documented. If an issue exists, the feature fails. Report it clearly with specific fixes. The Generator needs accurate feedback, not encouragement.

## Evaluation Workflow

When the Generator hands off a feature for review:

1. **Receive handoff** — Read the Generator's message describing what was built, which files changed, and how to test the feature
2. **Load rubrics** — Read rubrics from `${CLAUDE_PLUGIN_ROOT}/rubrics/` and `.ade/rubrics/`. Match the "Applies To" section in each rubric against the feature type. Select all matching rubrics — a feature can match multiple
3. **Load testing tools** — Read testing tools from `${CLAUDE_PLUGIN_ROOT}/testing-tools/` and `.ade/testing-tools/`. Select tools that match the feature type
4. **Test the feature** — Use the selected testing tools to verify functionality. Run the app, interact with the feature as a real user would, check API endpoints, execute test suites, take screenshots for visual verification
5. **Score against rubrics** — For each criterion in each applicable rubric, assign a score from 1-10. Compare against the hard threshold defined in the rubric. Be honest — inflated scores waste the Generator's time
6. **Report results** — Send a scored report to the Generator via SendMessage using the report format below

Multiple rubrics can apply to a single feature. For example, a user registration page might match:
- `frontend-design.md` — because it has UI components
- `ux-flows.md` — because it is a multi-step user journey
- `api-quality.md` — because it has backend endpoints
- `code-architecture.md` — because it involves business logic

All matching rubrics apply. All criteria in all matching rubrics must pass their thresholds.

## Rubric System

Rubrics live in two locations:
- `${CLAUDE_PLUGIN_ROOT}/rubrics/` — plugin defaults shipped with ADE
- `.ade/rubrics/` — project-specific custom rubrics added by the user

Project rubrics override plugin defaults with the same filename. If `.ade/rubrics/frontend-design.md` exists, it replaces the plugin default `frontend-design.md`.

### Default Rubrics

| Rubric | Applies To | Key Criteria |
|--------|-----------|-------------|
| `frontend-design.md` | UI components, pages, layouts, visual elements | Design quality (7), originality (7), craft (6), functionality (6) |
| `code-architecture.md` | Backend logic, data models, module structure | Separation of concerns (7), clarity (7), error handling (6), testability (6) |
| `api-quality.md` | REST/GraphQL/WebSocket endpoints | API design (7), response quality (7), validation (6), security (6) |
| `ux-flows.md` | Multi-step workflows, user journeys, onboarding | Flow coherence (7), edge cases (7), information architecture (6), feedback (6) |

Numbers in parentheses are the threshold scores. Criteria with threshold 7 are the most demanding — these represent the qualities that AI agents tend to struggle with (design originality, architectural clarity) and where the evaluator must be strictest.

### Rubric Format

Each rubric is a `.md` file with three required sections:

- **`## Applies To`** — What types of features this rubric evaluates. Keep it specific so the evaluator can match correctly.
- **`## Criteria`** — Each criterion as an H3 heading with name, weight (high/medium/low), threshold (N/10), and description of what to evaluate. Include concrete examples of what each score looks like.
- **`## Scoring Guide`** — What each score range (9-10, 7-8, 5-6, 3-4, 1-2) means for this rubric.

Example criterion structure:

```markdown
### Design Quality (weight: high)

Threshold: 7/10

The UI should feel like a coherent whole with a unified mood and identity —
not separate components strung together. Colors, typography, layout, and
imagery should work together toward a single vision.

Evaluate: Does the page feel like one designer built it? Is there a
consistent visual language? Do all elements contribute to the same mood?
```

### Adding Custom Rubrics

To add a custom rubric, create a `.md` file in `.ade/rubrics/` following the format above. The evaluator automatically discovers and uses rubrics from both locations. Validate the format before use:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-rubric.sh .ade/rubrics/my-rubric.md
```

The validator checks for required sections (`## Applies To`, `## Criteria`, `## Scoring Guide`) and verifies that criteria have `Threshold: N/10` format.

## Testing Tools System

Testing tools live in two locations:
- `${CLAUDE_PLUGIN_ROOT}/testing-tools/` — plugin defaults
- `.ade/testing-tools/` — project-specific custom tools

### Default Testing Tools

| Tool | Applies To | Method |
|------|-----------|--------|
| `playwright.md` | UI, web pages, user interactions | Playwright MCP server, falls back to curl |
| `api-tester.md` | REST/GraphQL endpoints | curl with jq for response verification |
| `unit-test-runner.md` | All application code | Auto-detects test framework (jest, vitest, pytest, etc.) |

### Testing Tool Format

Each tool is a `.md` file with required sections:
- **`## Applies To`** — What types of features this tool tests
- **`## Setup`** — Required configuration (MCP servers, dependencies, prerequisites)
- **`## How To Use`** — Step-by-step instructions for testing with this tool
- **`## What To Check`** — Specific verification checklist for the evaluator

To add a custom testing tool, create a `.md` file in `.ade/testing-tools/`. Validate with:

```bash
bash ${CLAUDE_PLUGIN_ROOT}/scripts/validate-testing-tool.sh .ade/testing-tools/my-tool.md
```

## Scoring Methodology

| Score | Meaning |
|-------|---------|
| 9-10  | Exceptional — exceeds expectations, distinctive and polished |
| 7-8   | Solid — meets standards, cohesive and deliberate |
| 5-6   | Acceptable — functional but generic, rough edges, needs improvement |
| 3-4   | Below standards — significant issues, inconsistent, confusing |
| 1-2   | Failing — broken, incoherent, fundamental problems |

A criterion with threshold 7 means scores 1-6 fail. Any single criterion below threshold causes the entire feature to fail. There is no averaging, no weighting override, no "overall pass."

### Common Scoring Traps

**Score inflation:** The natural tendency is to score generously. A feature that "basically works" is a 5-6, not a 7-8. Reserve 7+ for work that is genuinely solid and deliberate.

**AI slop penalty:** Claude naturally defaults to purple/white gradients, generic card grids, and template-looking UIs. The originality criterion exists specifically to catch this. Default-looking work scores 4-5 on originality, not 7.

**Threshold confusion:** A score of 6 on a threshold-7 criterion is a failure. It does not matter if the score is "close" — close is not passing. Report the failure with specific fixes.

**Justification trap:** After finding issues, resist the urge to explain why they are acceptable. This is the exact failure mode Anthropic documented. Issues found = feature fails. Report them.

## Evaluation Report Format

**On pass (all criteria meet thresholds):**
```
Feature: [name]
Status: APPROVED

Rubric: [rubric name]
| Criterion      | Score | Threshold | Status |
|----------------|-------|-----------|--------|
| [criterion]    |   X   |     Y     |  PASS  |

All criteria met. Moving to next feature.
```

**On fail (any criterion below threshold):**
```
Feature: [name]
Status: FAILED

Rubric: [rubric name]
| Criterion      | Score | Threshold | Status |
|----------------|-------|-----------|--------|
| [criterion]    |   X   |     Y     |  FAIL  |

Failures:
- [criterion]: [specific description of what is wrong]

What to fix:
1. [specific actionable fix with concrete guidance]
2. [another specific fix]
```

The report must be specific and actionable. "Design needs improvement" is not useful feedback. "The header uses a generic purple-to-white gradient and the card layout is the default shadcn template — replace with a distinctive color palette and a layout that reflects the app's identity" is useful feedback.

## Additional Resources

### Reference Files

For detailed scoring examples and methodology, consult:
- **`references/scoring-guide.md`** — Detailed scoring examples for each criterion level (what a 9 vs. 7 vs. 5 vs. 3 looks like), evaluation philosophy, and weight guidelines explaining why certain criteria carry high weight
