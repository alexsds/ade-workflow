---
name: ade-planning
description: This skill should be used when the user describes an app idea, wants to plan a new application or feature, asks about product planning, mentions "plan an app", "create a plan", "I have an app idea", "product spec", "feature breakdown", "scope out", "build me an app", or needs guidance on high-level product planning without implementation details.
version: 0.1.0
---

# ADE Planning

## Overview

Product-level planning for application development. Anthropic's research found that high-level plans outperform micro-detailed technical specs. A single error in technical planning cascades through every level of implementation. Keep planning at the product level and let the Generator figure out how to build it.

## Planning Principles

**DO:**
- Plan at the product level — deliverables and user stories
- Go big on scope and push boundaries
- Include user stories showing the user's perspective
- Identify opportunities for AI feature integration
- Let the Generator figure out technical implementation

**DO NOT:**
- Specify technical implementation details
- Create file structures or code architecture
- Write sprint contracts or task breakdowns
- Plan at the implementation level

## Planning Workflow

1. Invoke the ade-planner agent or run `/ade:plan [app idea]`
2. Read project settings from `.claude/ade.local.md`
3. If `commits_style: jira` is set, ask the user for the ticket number
4. If `.ade/` does not exist, run `${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh` to initialize it
5. Expand the idea into a product-level plan
6. Write the plan to `.ade/docs/plans/plan-YYYY-MM-DD.md`
7. Present the plan to the user for review and approval

## What Makes a Good Plan Input

The user's app idea should be 1-4 sentences describing what they want to build. The planner expands this into a full product specification.

**Good inputs:**
- "I want to build a task management app with collaboration features and AI-powered prioritization"
- "Plan a recipe sharing platform where users can create meal plans"
- "Build a developer dashboard that monitors CI/CD pipelines across multiple repos"

**Too vague:** "Build me something cool" — ask the user to describe the purpose and target audience.

**Too technical:** "Build a Next.js app with Prisma ORM and tRPC API layer" — redirect the user to focus on features and user outcomes, not implementation choices. The Generator handles technical decisions.

## Plan Structure

Plans include YAML frontmatter followed by product-level content:

```yaml
---
project: [Project Name]
date: [YYYY-MM-DD]
ticket: [TICKET-ID]    # Only if commits_style is jira
status: draft           # draft | approved | in-progress | completed | archived
---
```

**Required sections:**
- **Vision:** 2-3 sentences describing what this product is and who it serves
- **Features:** Organized by phase (Phase 1, Phase 2, etc.)
- **User Stories:** Per feature, in "As a [user], I want to [action] so that [benefit]" format
- **Success Criteria:** What "done" looks like for the whole project

See `references/plan-examples.md` for a complete example plan.

## Plan Iteration

After writing the plan, the user may request changes. Common iteration patterns:

- **Scope adjustment:** User wants to add or remove features. Update the plan and re-present.
- **Phase reordering:** User wants to prioritize different features first. Reorganize phases.
- **Clarification:** User asks for more detail on a feature. Expand user stories for that feature while staying at product level.
- **AI integration:** User wants to add AI-powered features. Identify opportunities and add them as features with user stories.

Do not proceed to execution until the user explicitly approves the plan.

## Project Settings

ADE reads project configuration from `.claude/ade.local.md`:

```yaml
---
commits_style: conventional
---
```

- `conventional` (default): Generator uses conventional commits like `feat(scope): description`
- `jira`: Planner asks for a ticket number, stored in plan frontmatter. Generator prefixes all commits with the ticket ID like `DEV-123 Description`

## After Planning

Once the user approves the plan, run `/ade:execute` to launch the Generator + Evaluator agent team. The Generator implements features one by one, the Evaluator tests and scores each feature against rubrics with hard thresholds. They iterate until all criteria pass, then move to the next feature.

When all features are complete, run `/ade:done` to archive the plan with completion metadata.

## Additional Resources

### Reference Files

For detailed examples and templates, consult:
- **`references/plan-examples.md`** — Complete example plan showing proper structure, phases, user stories, and success criteria
