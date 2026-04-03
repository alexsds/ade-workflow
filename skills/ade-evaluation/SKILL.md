---
name: ade-evaluation
description: This skill should be used when the user asks about evaluation methodology, scoring rubrics, testing tools, quality assessment, "how does scoring work", "evaluation criteria", "rubric format", "add a rubric", "create testing tool", or needs guidance on adversarial evaluation, graded scoring, or quality assessment in the ADE workflow.
version: 0.1.0
---

# ADE Evaluation

## Overview

Adversarial evaluation methodology for the ADE workflow. Based on Anthropic's finding that "out of the box, Claude is a poor QA agent" — evaluators identify issues then self-justify approval. ADE addresses this with graded scoring, hard thresholds, and an adversarial stance.

## Key Principles

**Adversarial stance:** Approach every feature from the perspective that bugs exist. Hunt for failures, don't confirm correctness.

**Graded scoring:** Each criterion scored 1-10 with hard thresholds. Any criterion below threshold = feature fails.

**Separate evaluator:** The agent that writes code must NEVER evaluate it. Self-evaluation bias causes agents to praise mediocre work.

## Rubric System

Rubrics live in two locations:
- `${CLAUDE_PLUGIN_ROOT}/rubrics/` — plugin defaults
- `.ade/rubrics/` — project-specific (user adds these)

Project rubrics override plugin defaults with the same filename.

### Rubric Format

Each rubric is a `.md` file with:
- **Applies To** — what types of features this rubric evaluates
- **Criteria** — each with name, weight (high/medium/low), threshold (1-10), and description
- **Scoring Guide** — what each score range means

See `references/scoring-guide.md` for detailed methodology.

### Adding Custom Rubrics

Drop a `.md` file in `.ade/rubrics/` following the rubric format. The evaluator will automatically discover and use it.

## Testing Tools System

Testing tools live in two locations:
- `${CLAUDE_PLUGIN_ROOT}/testing-tools/` — plugin defaults
- `.ade/testing-tools/` — project-specific

### Testing Tool Format

Each tool is a `.md` file with:
- **Applies To** — what types of features this tool tests
- **Setup** — any required configuration (MCP servers, dependencies)
- **How To Use** — step-by-step testing instructions
- **What To Check** — specific verification checklist

## Scoring Methodology

| Score | Meaning |
|-------|---------|
| 9-10  | Exceptional, exceeds expectations |
| 7-8   | Solid, meets standards |
| 5-6   | Acceptable but needs improvement |
| 3-4   | Below standards, significant issues |
| 1-2   | Failing, fundamental problems |

A criterion with threshold 7 means scores 1-6 fail. The evaluator must report specific failures and actionable fixes.
