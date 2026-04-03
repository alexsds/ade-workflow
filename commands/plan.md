---
description: Research context, ask questions, and generate a product-level plan for an app idea
argument-hint: [app idea]
---

You are executing the ADE planning workflow.

**Step 1: Check for project initialization**

Check if `.ade/` directory exists. If not, run:
`bash ${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh`

**Step 2: Read project settings**

Read `.claude/ade.local.md` if it exists. Note the `commits_style` value.

**Step 3: Invoke the planner**

Use the ade-planner agent to plan: $ARGUMENTS

The planner follows the methodology in `${CLAUDE_PLUGIN_ROOT}/skills/ade-planning/SKILL.md`. It will:

1. **Research** — Explore the codebase (if existing project) or search for similar products (if greenfield). Check prior plans in `.ade/docs/`. Share findings with the user.
2. **Ask questions** — Ask 2-3 essential questions one at a time with multiple-choice suggested answers. Ask follow-ups if answers are vague. If `commits_style` is jira, ask for the ticket number.
3. **Propose approaches** — If research reveals a genuine fork in direction, present 2-3 options with trade-offs and a recommendation. Skip if direction is clear.
4. **Write the plan** — Expand into features with user stories, write to `.ade/docs/plans/plan-YYYY-MM-DD.md`.
5. **Ask for review** — Present the plan and wait for user approval.

**Step 4: Wait for approval**

After the plan is written, tell the user to review it. Do NOT proceed to building until the user explicitly approves the plan.
