---
name: ade-generation
description: Use when asking about the ADE build process, how the generator works, iteration strategy, "why is the generator doing X", "how does building work", "commit conventions", "pivot vs refine", or understanding the implementation phase of the ADE workflow. This skill covers the Generator's methodology for implementing features from approved plans, including the 4-phase build cycle and strategic iteration.
version: 0.1.0
---

# ADE Generation

## Overview

The Generator is the builder in the ADE workflow. It implements features from an approved product plan one at a time, committing each to git, and hands off to the Evaluator for scoring.

Anthropic's research found two things about generators:
1. They tend to "go off the rails" and stub features when working alone — the Evaluator catches this
2. Even with Opus 4.6, the Generator still needs the Evaluator for "last mile" completeness

Self-evaluation before handoff is important but insufficient. The Generator checks that things work, but does not judge quality — that separation is the core of the harness design.

## Build Workflow (4 Subphases from Anthropic Research)

### 1. Understand

Read the active plan from `.ade/docs/plans/`. Identify the current feature to implement. Understand:
- What this feature delivers to the user (from user stories)
- How it relates to features already built
- What the Evaluator will test against (user stories are the contract)

### 2. Implement

Build the feature. Figure out the technical approach yourself — the plan gives deliverables, not implementation details. This is by design: Anthropic found that micro-specified technical plans create more problems than they solve because incorrect assumptions cascade through every level.

- Implement what the plan describes, not more, not less
- Do NOT stub or skip features — if something is hard, build it fully or message the Evaluator explaining what blocks you
- Do NOT add features not in the plan — scope creep wastes evaluator cycles
- Build complete, working functionality — the Evaluator will test it as a real user would

### 3. Self-Verify

Quick sanity check before handoff:
- Does the app run without errors?
- Does the feature work at a basic level?
- Can you interact with it as a user would?

This is NOT a quality evaluation — that's the Evaluator's job. Self-verify catches obvious breakage so the Evaluator's time isn't wasted on features that don't even load.

### 4. Handoff

Message the Evaluator via SendMessage:

```
Feature: [feature name]
Status: Ready for review
Files changed: [list of key files]
How to test: [specific steps — URL, navigation, test data to use]
What I built: [summary of implementation approach]
```

Be specific in "How to test" — the Evaluator needs to know exactly how to interact with the feature (URL, click path, form data, expected behavior).

## Iteration Strategy (from Anthropic Research)

After receiving Evaluator feedback, make a strategic decision:

### Refine

Choose this when scores are trending upward (improving each iteration):
- Fix the specific issues the Evaluator flagged
- Keep the current approach, polish the details
- This is the right call when the foundation is solid and the problems are surface-level

### Pivot

Choose this when scores are stagnant or the same issues keep recurring after 2-3 iterations:
- Scrap the current approach and try something fundamentally different
- Don't keep polishing something that isn't working
- Example: If the Evaluator keeps failing originality on a UI, don't tweak colors on the same layout — try a completely different aesthetic direction, layout structure, or visual concept

The pivot decision is critical. The natural instinct is to keep refining, but Anthropic's research shows that pivoting to a new approach often produces breakthrough improvements that incremental refinement cannot. The Evaluator's feedback contains signals about whether refinement or pivot is needed — stagnant scores across iterations are the clearest signal to pivot.

## Commit Convention

Read commit style from `.claude/ade.local.md`:

**`conventional`** (default):
```
feat(auth): add login flow
fix(dashboard): correct chart rendering
refactor(api): simplify error handling
```

**`jira`**:
```
DEV-123 Add login flow
DEV-123 Fix chart rendering on dashboard
```

When using `jira` style, read the ticket ID from the plan frontmatter.

Commit after each feature with a descriptive message. Each commit should represent one complete, working feature.

## Critical Rules

- Implement what the plan describes, not more, not less
- Do NOT stub or skip features — build them fully
- Self-verify before every handoff
- After completing each feature, message the Evaluator with what you built and how to test it
- When you receive Evaluator feedback, iterate until ALL rubric scores pass threshold
- Do NOT argue with scores — the Evaluator's job is to find failures, yours is to fix them
- Do NOT evaluate your own work quality — that's the Evaluator's job
- Do NOT approve your own work — only the Evaluator can approve a feature
