---
name: ade-planning
description: Use when the user describes an app idea, wants to plan a new application or feature, mentions "plan an app", "I have an app idea", "build me an app", "scope out", or describes something they want to build. This skill guides interactive discovery, research, and product-level planning before implementation. Always use this before building anything — the planning step prevents cascading errors from premature implementation.
version: 0.2.0
---

# ADE Planning

## Overview

Product-level planning for application development. Anthropic's research found that high-level plans outperform micro-detailed technical specs — a single error in technical planning cascades through every level of implementation. The planner stays at the product level (features, user stories, success criteria) and lets the Generator figure out how to build it.

The planner is interactive. Rather than taking a brief prompt and running with assumptions, it researches context and asks targeted questions with suggested answers to understand what the user actually wants before writing the plan.

## Planning Flow

```
User describes what they want to build
  → Check project context
  → Research phase (codebase and/or external)
  → Share research findings
  → Ask essential questions with suggested answers
  → If answers are vague, ask follow-up questions
  → If ambiguous fork detected, propose 2-3 approaches
  → Write the full plan
  → User reviews and approves
```

## Step 1: Check Project Context

Before asking any questions:

1. Read `.claude/ade.local.md` if it exists — note commit style
2. Check if `.ade/` exists. If not, run `${CLAUDE_PLUGIN_ROOT}/scripts/init-project.sh`
3. If `commits_style: jira`, ask the user for the Jira ticket number
4. Check `.ade/docs/plans/` for prior plans — understand what has been built before
5. Check `.ade/docs/archive/` for completed plans — understand project history

## Step 2: Research

Research what's relevant before asking questions. This is not optional — informed questions produce better plans than generic ones.

**Existing project (has source code):**
- Explore the codebase: tech stack, dependencies, file structure, patterns
- Read existing README, docs, or config files
- Understand what already exists so the plan builds on it, not duplicates it
- Note patterns the Generator should follow (e.g., existing component structure, API conventions)

**Greenfield project (no code yet):**
- Web search for similar products and competing solutions
- Look for established patterns in the domain (e.g., "task management" → boards, lists, calendars)
- Identify common features users expect in this category
- Find design inspiration and differentiation opportunities

**Always:**
- Review prior ADE plans in `.ade/docs/` to maintain continuity with previous work
- Note what the user's initial description already tells you — don't re-ask things they've already answered

**Present your findings.** Before moving to questions, share a brief summary of what you learned from research. This shows the user you've done homework and gives them a chance to correct wrong assumptions early.

Example:
> "I looked at your current codebase — you're running Next.js with Prisma and PostgreSQL, and you already have auth set up via NextAuth. I also looked at a few competing apps in this space. Here's what I found that's relevant: [findings]. A couple questions before I write the plan..."

## Step 3: Ask Questions

Ask questions one at a time with suggested answers. Start with 2-3 essential questions, then decide if more are needed based on how specific the user's responses are.

**Question format — always offer multiple choice with an open option:**

```
Who is the primary audience for this app?

  a) Internal team tool — employees, known users, no public signups
  b) Consumer-facing — public signups, growth matters, scale concerns
  c) B2B SaaS — organizations as customers, multi-tenancy
  d) Something else — tell me more
```

**Essential questions (always ask):**

1. **Audience** — Who will use this? (Determines scope, auth, scale requirements)
2. **Core value** — What's the one thing this must do really well? (Anchors Phase 1)
3. **Key constraint** — Anything that limits choices? (Timeline, existing tech, budget, platform)

**Follow-up questions (ask if answers are vague or scope is large):**

4. **Feature priorities** — Which of these matter most? (List features from research, ask to rank)
5. **AI integration** — Any AI-powered features? (Suggest specific opportunities based on the domain)
6. **Success criteria** — How will you know it's done? (Helps define the finish line)

**Adaptive depth:**
- If the user gives detailed, specific answers → fewer questions, move to plan
- If answers are vague ("just make it good") → ask more follow-ups to clarify
- If the user provided a detailed brief upfront → skip to confirming your understanding, then plan

**Rules:**
- One question per message
- Prefer multiple choice with suggested answers — easier than open-ended
- Don't ask about things the user already told you
- Don't ask about technical implementation — that's the Generator's job
- Suggested answers should be informed by your research, not generic

## Step 4: Propose Approaches (When Ambiguous)

If research or answers reveal a genuine fork — two or more meaningfully different product directions — propose 2-3 approaches before writing the plan.

**When to propose:**
- The user's idea could go in fundamentally different directions (e.g., "collaboration tool" → real-time like Figma vs. async like Notion)
- Research found competing patterns with real trade-offs
- The scope is large enough that phasing strategy matters

**When NOT to propose:**
- The direction is clear from the user's answers
- There's an obviously best approach
- The differences are implementation details (the Generator's problem, not the plan's)

**Format:**
```
Based on your answers and what I found researching [domain], I see two directions:

**A) [Direction name]** — [2-3 sentence description]. Prioritizes [X] at the cost of [Y].

**B) [Direction name]** — [2-3 sentence description]. Prioritizes [Y] at the cost of [X].

I'd recommend A because [reasoning tied to user's stated priorities].

Which direction, or a mix?
```

## Step 5: Write the Plan

Write the plan to `.ade/docs/plans/plan-YYYY-MM-DD.md`.

### Frontmatter

```yaml
---
project: [Project Name]
date: [YYYY-MM-DD]
ticket: [TICKET-ID]         # Only if commits_style is jira
status: draft
---
```

### Required Sections

**Vision:** 2-3 sentences describing what this product is and who it serves. The vision anchors all feature decisions — if a feature doesn't serve the vision, it doesn't belong in the plan.

**Features:** Organized by phase (Phase 1, Phase 2, etc.). Phase 1 is the core experience — the minimum set of features that make the product useful. Later phases add depth, collaboration, and advanced capabilities.

**User Stories:** Per feature, in "As a [user], I want to [action] so that [benefit]" format. 2-4 user stories per feature covering the primary interactions. User stories define what the Generator builds and what the Evaluator tests against.

**Success Criteria:** What "done" looks like. Measurable and specific — "users can create and manage tasks" rather than "the app works well."

See `references/plan-examples.md` for a complete example plan.

### Planning Principles (from Anthropic Research)

**DO:**
- Go big on scope — push boundaries of the app idea
- Include user stories showing the user's perspective for every feature
- Identify opportunities to integrate AI-powered features
- Organize features into phases with clear progression
- Keep everything at the product level — deliverables, not implementation

**DO NOT:**
- Specify technical implementation details (frameworks, libraries, file structures)
- Create code architecture or database schemas
- Write sprint contracts or task breakdowns with time estimates
- Approve the plan without the user's explicit sign-off

## Step 6: User Review

After writing the plan, tell the user:

> "Plan written to `.ade/docs/plans/plan-YYYY-MM-DD.md`. Please review and let me know if you'd like changes. Once approved, use `/ade:execute` to start implementation."

**Do NOT proceed to building until the user explicitly approves.**

### Common Iteration Patterns

- **Scope adjustment** — Add or remove features. Phase 1 should always contain the minimum viable experience
- **Phase reordering** — Move features between phases based on priority
- **Clarification** — Expand user stories for a specific feature
- **AI integration** — Identify AI-powered feature opportunities the user hasn't considered
- **Splitting features** — Break large features into sub-features the Evaluator can test independently

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

**Planning too small:** Anthropic research emphasizes "go big on scope." A plan with only 2-3 features underutilizes the harness. Push for ambitious scope — the Generator and Evaluator handle the complexity.

**Sneaking in implementation details:** "using React components" or "REST API with Express" are implementation details. Rephrase as features: "a responsive web interface," "a server API for data access."

**Skipping user stories:** Every feature needs user stories. Without them, the Generator has no clear target and the Evaluator has nothing to test against.

**Vague success criteria:** "The app should work well" is not measurable. Prefer: "All user flows complete in under 3 clicks."

**Not researching first:** Asking questions without context leads to generic plans. Research the codebase or domain first so your questions are specific and informed.

**Asking too many questions:** If the user gave a detailed brief, don't interrogate them. Confirm your understanding and write the plan. Read the room.

## After Planning

Once approved, use `/ade:execute` to launch the Generator + Evaluator agent team. The Generator implements features one by one, the Evaluator tests and scores each against rubrics. They iterate via SendMessage until all criteria pass.

Use `/ade:status` at any time to check progress. Use `/ade:done` to archive the plan when complete.

## References

- **`references/plan-examples.md`** — Complete example plan with proper structure, vision, phased features, user stories, and success criteria
