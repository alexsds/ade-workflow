---
name: ade-planning
description: Use when the user wants to plan any work — building an app, adding a feature, fixing a bug, solving a problem, refactoring, or any task that benefits from thinking before doing. Triggers on "plan", "build me", "I want to", "fix this", "add a", "we need to", "how should we", or when the user describes something they want done. This skill guides interactive discovery, research, and planning scaled to the scope of the work — from a quick task plan to a full product spec.
version: 0.1.0
---

# ADE Planning

## Overview

Planning before building — scaled to the scope of the work. Anthropic's research found that a single error in technical planning cascades through every level of implementation. The planner stays at the deliverable level (what, not how) and lets the Generator figure out implementation.

The planner is interactive. It researches context, asks targeted questions with suggested answers, and writes a plan whose depth matches the scope of the work.

## Step 0: Assess Scope

Read the user's request and assess scope. This determines how deep the planning process goes.

**Large** — Full application, multi-feature project, new product
- Examples: "build me a task management app", "create a SaaS dashboard", "I want to build a marketplace"
- Full planning flow: research → 3-5+ questions → possibly propose approaches → phased plan with user stories

**Medium** — New feature, significant change, integration
- Examples: "add a notification system", "integrate Stripe payments", "build a settings page"
- Moderate flow: codebase research → 1-3 questions → focused plan with deliverables

**Small** — Bug fix, task, refactor, minor change
- Examples: "fix the login bug", "refactor the auth module", "our API is too slow", "add dark mode toggle"
- Light flow: quick codebase research → 0-1 questions → short plan with acceptance criteria

The scope determines how many questions to ask, how deep to research, and how detailed the plan is. Don't run a full product planning cycle for a bug fix. Don't write a one-liner plan for a new app.

## Step 1: Check Project Context

Before asking any questions:

1. Read `.claude/ade.local.md` if it exists — note commit style
2. Check if `.ade/` exists. If not, run `${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh`
3. If `commits_style: jira`, ask the user for the Jira ticket number
4. Check `.ade/docs/plans/` for prior plans — understand what has been built before
5. Check `.ade/docs/archive/` for completed plans — understand project history

## Step 2: Research

Research what's relevant before asking questions. Scale depth to scope.

**Existing project (has source code):**
- Explore the codebase: tech stack, dependencies, file structure, patterns
- For bugs/tasks: find the relevant code, understand the current behavior, identify likely causes
- For features: understand what exists so the plan builds on it, not duplicates it
- Note patterns the Generator should follow

**Greenfield project (no code yet):**
- Web search for similar products and competing solutions
- Look for established patterns in the domain
- Identify common features users expect in this category
- Find differentiation opportunities

**Always:**
- Review prior ADE plans in `.ade/docs/` to maintain continuity
- Note what the user's initial description already tells you — don't re-ask things they've answered

**Present your findings.** Share a brief summary before moving to questions. For small scope, this might be one sentence ("I found the bug — it's in `auth.ts:42`, the token expiry check is off by one"). For large scope, it might be a paragraph with research findings.

## Step 3: Ask Questions

Ask questions one at a time with suggested answers. How many depends on scope.

**Question format — always offer multiple choice with an open option:**

```
What's most important for this feature?

  a) Speed — ship fast, polish later
  b) Quality — get it right the first time, take longer
  c) Flexibility — make it easy to change and extend
  d) Something else — tell me more
```

**For large scope (3-5+ questions):**
1. **Audience** — Who will use this?
2. **Core value** — What's the one thing this must do really well?
3. **Key constraint** — Anything that limits choices? (Timeline, tech, platform)
4. **Feature priorities** — Which matter most? (List from research, ask to rank)
5. **AI integration** — Any AI-powered features? (Suggest specific opportunities)
6. **Success criteria** — How will you know it's done?

**For medium scope (1-3 questions):**
1. **Goal clarity** — Confirm what the feature should do (especially if the request is ambiguous)
2. **Constraints** — Anything that affects approach? (Must integrate with X, needs to work on mobile, etc.)
3. **Priority** — What matters most — speed, quality, or flexibility?

**For small scope (0-1 questions):**
- If the task is clear from context + research, skip questions entirely. Confirm your understanding and write the plan.
- If ambiguous, ask one clarifying question.

**Rules:**
- One question per message
- Prefer multiple choice with suggested answers
- Don't ask about things the user already told you
- Don't ask about technical implementation — that's the Generator's job
- Suggested answers should be informed by your research, not generic
- Read the room — if the user is giving detailed answers, ask fewer questions

## Step 4: Propose Approaches (When Ambiguous)

If research or answers reveal a genuine fork — two or more meaningfully different directions — propose 2-3 approaches before writing the plan. This mostly applies to medium and large scope.

**When to propose:**
- The work could go in fundamentally different directions
- Research found competing patterns with real trade-offs
- The scope is large enough that phasing strategy matters

**When NOT to propose:**
- The direction is clear
- There's an obviously best approach
- The differences are implementation details (the Generator's problem)
- Small scope — just pick the right approach and go

**Format:**
```
Based on what I found, I see two directions:

**A) [Direction name]** — [2-3 sentence description]. Prioritizes [X] at the cost of [Y].

**B) [Direction name]** — [2-3 sentence description]. Prioritizes [Y] at the cost of [X].

I'd recommend A because [reasoning tied to user's stated priorities].

Which direction, or a mix?
```

## Step 5: Write the Plan

Write the plan to `.ade/docs/plans/plan-YYYY-MM-DD.md`. Structure scales with scope.

### Frontmatter (all scopes)

```yaml
---
project: [Name or short description]
date: [YYYY-MM-DD]
scope: [large | medium | small]
ticket: [TICKET-ID]         # Only if commits_style is jira
status: draft
---
```

### Large Scope — Full Product Plan

**Goal:** 2-3 sentences describing what this is and who it serves.

**Features:** Organized by phase (Phase 1, Phase 2, etc.). Phase 1 is the core experience. Later phases add depth.

**User Stories:** Per feature, "As a [user], I want to [action] so that [benefit]" format. 2-4 per feature.

**Success Criteria:** What "done" looks like. Measurable and specific.

### Medium Scope — Feature Plan

**Goal:** 1-2 sentences describing what this feature does and why.

**Deliverables:** List of concrete things to build. No phases needed unless the feature is large enough to split.

**User Stories:** 2-4 user stories covering the key interactions.

**Acceptance Criteria:** Specific conditions that must be true when this is done.

### Small Scope — Task Plan

**Goal:** One sentence — what needs to happen and why.

**What to change:** Brief description of the work. For bugs: what's broken, where, and what "fixed" looks like. For tasks: what to do.

**Done when:** 1-3 clear acceptance criteria.

See `references/plan-examples.md` for examples at each scope.

### Planning Principles (from Anthropic Research)

**DO:**
- Scale ambition to scope — go big on large projects, stay focused on tasks
- Include user stories for medium and large scope
- Identify opportunities to integrate AI-powered features (large scope)
- Keep everything at the deliverable level — what, not how

**DO NOT:**
- Specify technical implementation details (frameworks, libraries, file structures)
- Create code architecture or database schemas
- Run a heavyweight planning process for a simple task
- Approve the plan without the user's explicit sign-off

## Step 6: User Review

After writing the plan, tell the user:

> "Plan written to `.ade/docs/plans/plan-YYYY-MM-DD.md`. Please review and let me know if you'd like changes. Once approved, use `/ade:execute` to start implementation."

**Do NOT proceed to building until the user explicitly approves.**

### Common Iteration Patterns

- **Scope adjustment** — Add or remove deliverables
- **Clarification** — Expand user stories or acceptance criteria
- **Splitting** — Break large deliverables into testable sub-deliverables
- **Rescoping** — If the user realizes the scope is bigger/smaller than initially assessed, adjust the plan structure

Once the user approves, update the plan status to `approved`.

## Project Settings

ADE reads project configuration from `.claude/ade.local.md`:

```yaml
---
commits_style: conventional
---
```

- `conventional` (default): Generator uses conventional commits like `feat(scope): description`
- `jira`: Planner asks for a ticket number at plan creation, Generator prefixes all commits with ticket ID

## Common Pitfalls

**Overplanning small work:** A bug fix doesn't need phases, user stories, and success criteria. Goal + what to change + done when. Keep it proportional.

**Underplanning large work:** A full app with 2-3 bullet points isn't a plan. Push for ambitious scope with phased features and user stories.

**Sneaking in implementation details:** "using React components" or "REST API with Express" are implementation details. Rephrase as deliverables: "a responsive web interface," "a server API for data access."

**Skipping user stories (medium/large scope):** Every feature needs user stories. Without them, the Generator has no clear target and the Evaluator has nothing to test against.

**Not researching first:** Asking questions without context leads to generic plans. Research the codebase or domain first so your questions are specific and informed.

**Asking too many questions:** If the user gave a clear, detailed brief, don't interrogate. Confirm understanding and write the plan.

## After Planning

Once approved, use `/ade:execute` to launch the Generator + Evaluator agent team. The Generator implements deliverables one by one, the Evaluator tests and scores each against rubrics. They iterate via SendMessage until all criteria pass.

Use `/ade:status` at any time to check progress. Use `/ade:done` to archive the plan when complete.

## References

- **`references/plan-examples.md`** — Example plans at each scope level (large, medium, small)
