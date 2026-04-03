---
description: Research context, ask questions, and create a plan scaled to the scope of the work
argument-hint: [anything]
---

You are executing the ADE planning workflow. Follow these steps yourself — do NOT spawn a subagent or agent for planning. The planner needs to ask the user questions interactively, which requires staying in the main conversation.

**Step 1: Check for project initialization**

Check if `.ade/` directory exists. If not, run:
`bash ${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh`

**Step 2: Read project settings**

Read `.claude/ade.local.md` if it exists. Note the `commits_style` value.

**Step 3: Read the planning methodology**

Read `${CLAUDE_PLUGIN_ROOT}/skills/ade-planning/SKILL.md` and follow it step by step for: $ARGUMENTS

**Step 4: Research**

Explore the codebase (existing project) or search for similar products (greenfield). Share a summary of your findings with the user.

**Step 5: Ask questions interactively**

This is critical — ask questions ONE AT A TIME. After each question, STOP and wait for the user's response before asking the next one. Do NOT ask multiple questions at once. Do NOT skip questions. Do NOT write the plan until you've finished asking.

Format every question like this:

```
What platform should this run on?

  a) Web app — works in any browser, easiest to build
  b) Mobile-first web app — responsive, installable as PWA
  c) Native mobile app — iOS/Android
  d) Something else — tell me more
```

How many questions depends on scope:
- Large (full app): 3-5 questions
- Medium (feature): 1-3 questions
- Small (task/bug): 0-1 questions

After sharing research findings, ask your first question and STOP. Wait for the answer. Then ask the next question and STOP. Repeat until done.

**Step 6: Write the plan**

Only after all questions are answered, write the plan to `.ade/docs/plans/plan-YYYY-MM-DD.md`. Structure matches scope per the methodology in the skill.

**Step 7: Wait for approval**

Tell the user: "Plan written to `.ade/docs/plans/plan-YYYY-MM-DD.md`. Please review and let me know if you'd like changes. Once approved, use `/ade:execute` to start implementation."

Do NOT proceed to building until the user explicitly approves.
