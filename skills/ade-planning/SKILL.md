---
name: ade-planning
description: This skill should be used when the user describes an app idea, wants to plan a new application, asks about product planning, mentions "plan an app", "create a plan", "product spec", "feature breakdown", or needs guidance on high-level product planning without implementation details.
version: 0.1.0
---

# ADE Planning

## Overview

Product-level planning for application development. Based on Anthropic's research finding that high-level plans outperform micro-detailed technical specs — a single error in technical planning cascades through every level of implementation.

## When to Use

- User describes an app idea (1-4 sentences)
- User wants to plan a new feature or application
- User asks about product-level planning

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

## How It Works

1. Invoke the ade-planner agent or `/ade:plan` command
2. Planner reads project settings from `.claude/ade.local.md`
3. If jira commit style, planner asks for ticket number
4. Planner expands idea into product-level plan
5. Plan written to `.ade/docs/plans/plan-YYYY-MM-DD.md`
6. User reviews and approves before building begins

## Plan Structure

Plans include:
- **Vision:** What the product is and who it serves
- **Features:** Organized by phase
- **User Stories:** Per feature, in "As a [user]..." format
- **Success Criteria:** What "done" looks like

See `references/plan-examples.md` for example plans.

## After Planning

Once the user approves the plan, use `/ade:execute` to launch the Generator + Evaluator agent team.
