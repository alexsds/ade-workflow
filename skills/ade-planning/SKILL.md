---
name: ade-planning
description: This skill should be used when the user describes an app idea, wants to plan a new application or feature, asks about product planning, mentions "plan an app", "create a plan", "I have an app idea", "product spec", "feature breakdown", "scope out", "build me an app", or needs guidance on high-level product planning without implementation details. Make sure to use this skill whenever the user describes something they want to build, even if they don't explicitly say "plan" — the planning step ensures better outcomes before implementation begins.
version: 0.1.0
---

# ADE Planning

## Overview

Product-level planning for application development. Anthropic's research found that high-level plans outperform micro-detailed technical specs. A single error in technical planning cascades through every level of implementation. The planner stays at the product level — features, user stories, and success criteria — and lets the Generator figure out how to build it.

This matters because the traditional instinct is to specify exactly which files to create, which frameworks to use, and which patterns to follow. With Opus 4.6, that level of micro-planning creates more problems than it solves: incorrect technical assumptions propagate through the entire build, and the Generator ends up fighting the plan instead of building the product.

## Planning Principles

**DO:**
- Plan at the product level — deliverables and user stories
- Go big on scope and push boundaries of the app idea
- Include user stories showing the user's perspective for every feature
- Identify opportunities to integrate AI-powered features
- Let the Generator figure out technical implementation details
- Organize features into phases with clear progression

**DO NOT:**
- Specify technical implementation details (frameworks, libraries, file structures)
- Create code architecture or database schemas
- Write sprint contracts or task breakdowns with time estimates
- Plan at the implementation level — a single wrong technical choice cascades errors
- Approve the plan without the user's explicit sign-off

## Planning Workflow

1. Invoke the ade-planner agent or run `/ade:plan [app idea]`
2. Read project settings from `.claude/ade.local.md` to determine commit style
3. If `commits_style: jira` is configured, ask the user for the Jira ticket number
4. If `.ade/` does not exist, run `${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh` to initialize it
5. Take the user's app idea (1-4 sentences) and expand it into a full product specification
6. Write the plan to `.ade/docs/plans/plan-YYYY-MM-DD.md` with proper frontmatter
7. Present the plan to the user for review and approval
8. Wait for explicit approval — execution must not begin until the user approves

## What Makes a Good Plan Input

The user's app idea should be 1-4 sentences describing what they want to build and who it serves. The planner expands this into a comprehensive product specification with features, phases, and user stories.

**Good inputs:**
- "I want to build a task management app with collaboration features and AI-powered prioritization"
- "Plan a recipe sharing platform where users can create meal plans and get AI suggestions"
- "Build a developer dashboard that monitors CI/CD pipelines across multiple repos"

**Too vague:** "Build me something cool" — ask the user to describe the purpose, target audience, and at least one key feature. Even a single sentence like "a tool for tracking daily habits" gives enough to start.

**Too technical:** "Build a Next.js app with Prisma ORM and tRPC API layer" — redirect toward features and user outcomes. Technical choices are the Generator's responsibility. Ask: "What should this app do for the user? Who is it for?"

**Edge case — existing project:** If the user wants to add features to an existing app, read the current codebase first to understand what exists, then plan the new features at product level. Reference existing functionality in user stories where relevant (e.g., "As a user who already has an account, I want to...").

## Plan Structure

Plans include YAML frontmatter followed by product-level content:

```yaml
---
project: [Project Name]
date: [YYYY-MM-DD]
ticket: [TICKET-ID]    # Only present when commits_style is jira
status: draft           # draft | approved | in-progress | completed | archived
---
```

**Required sections:**

- **Vision:** 2-3 sentences describing what this product is and who it serves. The vision anchors all feature decisions — if a feature does not serve the vision, it does not belong in the plan.

- **Features:** Organized by phase (Phase 1, Phase 2, etc.). Phase 1 contains the core experience — the minimum set of features that make the product useful. Later phases add depth, collaboration, and advanced capabilities.

- **User Stories:** Per feature, in "As a [user], I want to [action] so that [benefit]" format. Each feature should have 2-4 user stories covering the primary interactions. User stories define what the Generator builds and what the Evaluator tests against.

- **Success Criteria:** What "done" looks like for the whole project. These should be measurable and specific — "users can create and manage tasks" rather than "the app works well."

See `references/plan-examples.md` for a complete example plan with all sections.

## Plan Iteration

After writing the plan, the user may request changes before approving. Common iteration patterns:

- **Scope adjustment:** Add or remove features. Adding a feature means writing new user stories and placing it in the appropriate phase. Removing a feature means deleting it and verifying remaining features still form a coherent product.

- **Phase reordering:** Move features between phases based on priority. Phase 1 should always contain the minimum viable experience. Moving a feature to Phase 1 means it blocks the others — make sure it is truly essential.

- **Clarification:** Expand user stories for a specific feature. Add more detail about user interactions, edge cases, or expected behavior — but stay at product level. "The form should validate in real-time" is fine; "use Zod schemas for validation" is too technical.

- **AI integration:** Identify opportunities for AI-powered features and add them with user stories. AI features work best when they augment user capabilities rather than replace them entirely. Example: "As a user, I want AI to suggest task priorities based on due dates and workload."

- **Splitting features:** If a feature is too large, break it into sub-features with their own user stories. This makes each unit testable by the Evaluator.

Execution must not begin until the user explicitly approves the plan. If the user says "looks good" or "approved," update the plan status to `approved`.

## Project Settings

ADE reads project configuration from `.claude/ade.local.md`. This file is created automatically by `${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh` on first run.

```yaml
---
commits_style: conventional
---
```

**Commit styles:**
- `conventional` (default): Generator uses conventional commits like `feat(scope): description`. This is the standard for most open-source and greenfield projects.
- `jira`: Planner asks for a ticket number at plan creation time and stores it in the plan frontmatter. Generator prefixes all commits with the ticket ID like `DEV-123 Add login flow`. Different plans can have different tickets.

## Common Pitfalls

**Planning too small:** The Anthropic research emphasizes "go big on scope." A plan with only 2-3 features underutilizes the harness. Push for ambitious scope — the Generator and Evaluator handle the complexity. If the user asks for a simple todo app, suggest AI features, collaboration, real-time sync, analytics.

**Sneaking in implementation details:** Phrases like "using React components," "with a PostgreSQL database," or "REST API with Express" are implementation details. Rephrase as features: "a responsive web interface," "persistent data storage," "a server API for data access."

**Skipping user stories:** Every feature needs user stories. Without them, the Generator has no clear target and the Evaluator has nothing to test against. User stories are the contract between planning and execution.

**Vague success criteria:** "The app should be fast and work well" is not measurable. Prefer: "The app handles 50+ concurrent users without performance degradation" or "All user flows complete in under 3 clicks."

## After Planning

Once the user approves the plan, run `/ade:execute` to launch the Generator + Evaluator agent team. The Generator implements features one by one from the plan, committing each to git. The Evaluator tests and scores each feature against rubrics with hard thresholds. They iterate via SendMessage until all criteria pass, then move to the next feature.

When all features are complete, run `/ade:done` to archive the plan with completion metadata (date, git commit range, feature count).

Run `/ade:status` at any time to check progress on the current plan.

## Additional Resources

### Reference Files

For detailed examples and templates, consult:
- **`references/plan-examples.md`** — Complete example plan showing proper structure with vision, phased features, user stories, and success criteria
