---
description: Show current ADE build progress and evaluator scores
---

You are reporting ADE workflow status.

**Step 1: Find active plan**

Look in `.ade/docs/plans/` for any plan files. If none exist, tell the user no active plan exists.

**Step 2: Read plan details**

Read the plan file. Report:
- Project name and date
- Plan status (draft/approved/in-progress/completed/archived)
- Ticket number (if jira style)

**Step 3: Report feature progress**

List each feature/phase from the plan. For each, check git log for related commits to determine what has been implemented.

**Step 4: Report recent evaluator scores**

If the build is in progress, check for any evaluator feedback in recent conversation or committed files. Report last known scores.

**Step 5: Identify blockers**

Note any features that appear incomplete or where the evaluator reported failures that haven't been addressed.
