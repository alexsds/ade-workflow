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

**Step 4: Create the team**

Use the TeamCreate tool:
```json
{
  "team_name": "ade-build",
  "description": "Generator + Evaluator building from approved plan"
}
```

**Step 5: Create tasks from the plan**

Read the plan and create a task (using TaskCreate) for each feature/deliverable. These tasks form the shared task list the team works from.

**Step 6: Spawn teammates**

Spawn both teammates using the Agent tool with `team_name: "ade-build"`:

**Generator** — spawn with:
- `name`: "generator"
- `team_name`: "ade-build"
- `subagent_type`: use the ade-generator agent
- `prompt`: Tell it to read the plan, read `${CLAUDE_PLUGIN_ROOT}/skills/ade-generation/SKILL.md` for methodology, check the task list, claim the first feature task, implement it, self-verify, commit to git, then message the evaluator via SendMessage (to: "evaluator") with: feature name, files changed, how to test. After evaluator responds, iterate if needed. When approved, mark task complete, claim next task.

**Evaluator** — spawn with:
- `name`: "evaluator"
- `team_name`: "ade-build"
- `subagent_type`: use the ade-evaluator agent
- `prompt`: Tell it to read `${CLAUDE_PLUGIN_ROOT}/skills/ade-evaluation/SKILL.md` for methodology, then wait for messages from the generator. When a feature is submitted, load rubrics from `${CLAUDE_PLUGIN_ROOT}/rubrics/` and `.ade/rubrics/`, load testing tools from `${CLAUDE_PLUGIN_ROOT}/testing-tools/` and `.ade/testing-tools/`, test the feature, score against rubric criteria, then message the generator via SendMessage (to: "generator") with the scored report. If all criteria pass, say APPROVED. If any fail, say FAILED with specific fixes.

**Step 7: Monitor progress**

The team communicates via SendMessage. The workflow per feature:
1. Generator implements feature, commits, messages evaluator
2. Evaluator tests, scores, messages generator with pass/fail
3. If failed: Generator iterates, re-submits
4. If passed: Generator marks task complete, moves to next feature

When all tasks are complete, send teammates a shutdown message:
```json
SendMessage({ to: "generator", message: { type: "shutdown_request" } })
SendMessage({ to: "evaluator", message: { type: "shutdown_request" } })
```

Then notify the user that the build is complete and suggest running `/ade:done` to archive the plan.
