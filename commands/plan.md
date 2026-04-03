---
description: Research context, ask questions, and create a plan scaled to the scope of the work
argument-hint: [anything]
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

1. **Assess scope** — Determine if this is large (full app), medium (feature), or small (task/bug). This controls the depth of everything that follows.
2. **Research** — Explore the codebase, find relevant code, or search for similar products. Share findings with the user.
3. **Ask questions** — Scaled to scope: 3-5 for large, 1-3 for medium, 0-1 for small. Multiple-choice with suggested answers. If `commits_style` is jira, ask for the ticket number.
4. **Propose approaches** — If research reveals a genuine fork in direction, present 2-3 options. Skip if direction is clear or scope is small.
5. **Write the plan** — Structure matches scope: phased features with user stories (large), deliverables with acceptance criteria (medium), or goal + done-when (small). Write to `.ade/docs/plans/plan-YYYY-MM-DD.md`.
6. **Ask for review** — Present the plan and wait for user approval.

**Step 4: Wait for approval**

After the plan is written, tell the user to review it. Do NOT proceed to building until the user explicitly approves the plan.
