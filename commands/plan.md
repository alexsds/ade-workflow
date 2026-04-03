---
description: Generate a product-level plan for an app idea
argument-hint: [app idea]
---

You are executing the ADE planning workflow.

**Step 1: Check for project initialization**

Check if `.ade/` directory exists. If not, run:
`bash ${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh`

**Step 2: Read project settings**

Read `.claude/ade.local.md` if it exists. Note the `commits_style` value.

**Step 3: Invoke the planner**

Use the ade-planner agent to create a product-level plan for: $ARGUMENTS

The planner will:
- If commits_style is jira, ask the user for a ticket number
- Expand the idea into features with user stories
- Write the plan to `.ade/docs/plans/plan-YYYY-MM-DD.md`
- Ask the user to review and approve

**Step 4: Wait for approval**

After the plan is written, tell the user to review it. Do NOT proceed to building until the user explicitly approves the plan.
