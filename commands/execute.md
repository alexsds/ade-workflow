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

Use TeamCreate to create the build team:

```
TeamCreate:
  name: "ade-build"
  members:
    - name: "generator"
      agent: "ade-generator"
    - name: "evaluator"
      agent: "ade-evaluator"
```

Tell the Generator to start with the first feature in the plan.

**How the team communicates:**

1. Generator reads the plan, implements a feature, self-verifies, commits to git
2. Generator sends to evaluator via SendMessage: feature name, files changed, how to test
3. Evaluator loads rubrics from `${CLAUDE_PLUGIN_ROOT}/rubrics/` and `.ade/rubrics/`, loads testing tools from `${CLAUDE_PLUGIN_ROOT}/testing-tools/` and `.ade/testing-tools/`
4. Evaluator tests the feature, scores against rubric criteria, sends pass/fail + feedback to generator
5. If any criterion fails: Generator iterates and re-submits
6. If all pass: Generator moves to next feature in the plan
7. Loop until all features are complete

**Step 5: Monitor progress**

As features are completed, track progress. When all features in the plan are implemented and approved by the Evaluator, notify the user that the build is complete and suggest running `/ade:done` to archive the plan.
