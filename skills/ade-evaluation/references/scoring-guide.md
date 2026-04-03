# Scoring Guide

## Evaluation Philosophy

Anthropic's research shows that AI evaluators tend to:
1. Identify real issues
2. Then self-justify approval anyway

This is the core failure mode. ADE prevents it with hard thresholds — there is no "close enough."

## How Scoring Works

### Step 1: Select Rubrics

The evaluator reads the "Applies To" section in each rubric. A feature can match multiple rubrics. For example, a user registration page might match:
- `frontend-design.md` (it has UI)
- `ux-flows.md` (it's a user journey)
- `api-quality.md` (it has backend endpoints)

### Step 2: Score Each Criterion

For each criterion in each applicable rubric:
- Evaluate the feature against the criterion description
- Assign a score from 1-10
- Compare against the threshold

### Step 3: Apply Hard Threshold

If ANY criterion in ANY applicable rubric scores below its threshold, the entire feature fails. There is no averaging, no weighting override, no "overall pass."

### Step 4: Report Results

**On pass:** Brief confirmation with scores table.
**On fail:** Detailed report with:
- Which criteria failed and by how much
- Specific description of what is wrong
- Actionable steps to fix each failure

## Scoring Examples

### Design Quality (threshold: 7)

**Score 9:** Distinctive visual identity. Every element contributes to a cohesive whole. Memorable and professional.

**Score 7:** Coherent design with consistent styling. Works well as a unit. No jarring elements.

**Score 5:** Functional but generic. Components work individually but don't feel unified. Default-looking.

**Score 3:** Inconsistent styling. Mixed visual languages. Feels assembled from unrelated parts.

### Originality (threshold: 7)

**Score 9:** Distinctive choices that feel intentional. Would not be mistaken for a template or AI default.

**Score 7:** Some deliberate design choices. Avoids the most common AI patterns. Has personality.

**Score 5:** Mostly default patterns. Purple/white gradients, generic cards, stock hero sections.

**Score 3:** Entirely template-driven. No evidence of deliberate design choices.

## Weight Guidelines

- **high:** This criterion is critical. Design quality and originality carry high weight because Claude naturally excels at craft and functionality but struggles with these.
- **medium:** Important but not a primary differentiator. Craft and functionality are already strong defaults.
- **low:** Nice to have. Rarely the deciding factor in pass/fail.
