---
description: Launch Generator + Evaluator agent team to execute the approved plan
---

You are executing the ADE build workflow.

**Step 1: Find the approved plan**

Look in `.ade/docs/plans/` for the most recent plan file. Read it and verify its status is `approved` or `draft` (if the user explicitly says to proceed).

If no plan exists, tell the user to run `/ade:plan` first.

**Step 2: Read project settings**

Read `.claude/ade.local.md` for commit style configuration.

**Step 3: Update plan status**

Update the plan's frontmatter status from `draft`/`approved` to `in-progress`.

**Step 4: Launch the agent team**

Create an agent team with two members:

1. **Generator** (ade-generator agent): Implements features from the plan one at a time, commits to git, messages the Evaluator when ready for review.

2. **Evaluator** (ade-evaluator agent): Waits for Generator handoffs, loads rubrics from `${CLAUDE_PLUGIN_ROOT}/rubrics/` and `.ade/rubrics/`, loads testing tools from `${CLAUDE_PLUGIN_ROOT}/testing-tools/` and `.ade/testing-tools/`, scores features against rubric criteria, sends feedback to Generator.

The Generator and Evaluator communicate via SendMessage. The Generator builds a feature, messages the Evaluator. The Evaluator tests and scores it. If any rubric criterion is below threshold, the Evaluator sends failure details back. The Generator iterates until all criteria pass, then moves to the next feature.

**Step 5: Monitor progress**

As features are completed, track progress. When all features in the plan are implemented and approved by the Evaluator, notify the user that the build is complete and suggest running `/ade:done` to archive the plan.
