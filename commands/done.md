---
description: Archive the current plan after completion
---

You are executing the ADE archive workflow.

**Step 1: Find the current plan**

Look in `.ade/docs/plans/` for the current plan. Read it.

**Step 2: Verify completion**

Check that the plan status is `in-progress` or `completed`. If it's still `draft`, warn the user that the plan hasn't been built yet.

**Step 3: Add completion metadata**

Append the following to the end of the plan file:

```markdown
---

## Completion Summary

- **Date completed:** [today's date]
- **Git commit range:** [first commit..last commit for this plan]
- **Features implemented:** [count from the plan]
```

**Step 4: Update status and archive**

Update the plan frontmatter status to `archived`.

Move the plan file from `.ade/docs/plans/` to `.ade/docs/archive/`.

**Step 5: Confirm**

Tell the user: "Plan archived to `.ade/docs/archive/`. Ready for the next project — use `/ade:plan` to start a new one."
