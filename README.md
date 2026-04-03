# ADE — Agent-Driven Engineering

A Claude Code plugin implementing Anthropic's recommended 3-agent harness for long-running application development.

Based on: [Harness Design for Long-Running Apps](https://www.anthropic.com/engineering/harness-design-long-running-apps)

## How It Works

```
/ade:plan "Build a task management app"
    → Planner researches context, asks questions with suggested answers
    → Creates a plan scaled to scope (app, feature, task, bug)
    → You review and approve

/ade:execute
    → Generator implements deliverables one by one
    → Evaluator tests and scores each against rubrics
    → They iterate until all criteria pass

/ade:done
    → Archives the completed plan
```

## Three Agents

| Agent | Role | Key Behavior |
|-------|------|-------------|
| **Planner** | Interactive planning | Researches → asks questions → writes plan scaled to scope |
| **Generator** | Implementation | Builds deliverable-by-deliverable, commits to git |
| **Evaluator** | Adversarial QA | Scores against rubrics with hard thresholds, can't modify code |

## Planning at Any Scale

The planner adapts to the scope of the work:

| Scope | Examples | Questions | Plan Structure |
|-------|----------|-----------|---------------|
| **Large** | Full app, new product | 3-5+ | Phased features + user stories |
| **Medium** | New feature, integration | 1-3 | Deliverables + acceptance criteria |
| **Small** | Bug fix, task, refactor | 0-1 | Goal + what to change + done when |

The planner always researches before asking questions — exploring the codebase for existing projects or searching for similar products for greenfield work.

## Architecture

Skills are the source of truth for methodology. Agents are thin execution shells that reference skills for guidance.

```
skills/          → methodology, knowledge, the "why" and "how"
agents/          → execution shells that read skills
commands/        → user-facing entry points that invoke agents
rubrics/         → evaluation criteria with scored thresholds
testing-tools/   → testing configurations for the evaluator
```

## Pluggable Rubrics

Default rubrics in `rubrics/`:
- `frontend-design.md` — UI quality, originality, craft, functionality
- `code-architecture.md` — separation of concerns, clarity, error handling, testability
- `api-quality.md` — API design, responses, validation, security
- `ux-flows.md` — flow coherence, edge cases, information architecture, feedback

Add custom rubrics by dropping `.md` files in `.ade/rubrics/` in your project. Project rubrics override plugin defaults with the same filename.

## Pluggable Testing Tools

Default tools in `testing-tools/`:
- `playwright.md` — browser testing via Playwright MCP (auto-configured, falls back to curl)
- `api-tester.md` — HTTP endpoint testing via curl
- `unit-test-runner.md` — test suite execution (auto-detects framework)

Add custom tools by dropping `.md` files in `.ade/testing-tools/` in your project.

## Configuration

Project settings in `.claude/ade.local.md`:

```yaml
---
commits_style: conventional    # conventional | jira
---
```

## Commands

| Command | Description |
|---------|------------|
| `/ade:plan [anything]` | Research, ask questions, create plan scaled to scope |
| `/ade:execute` | Launch Generator + Evaluator team |
| `/ade:done` | Archive completed plan |
| `/ade:status` | Show build progress |

## Install

Inside a Claude Code session, add the marketplace:
```
/plugin marketplace add alexsds/ade-workflow
```

Then install the plugin:
```
/plugin install ade@alexsds-ade-workflow
```

Or run `/plugin` to open the interactive plugin manager.

## Why This Architecture

Anthropic's research found:
- **Planning stays high-level** — micro-detail errors cascade through implementation
- **Separate evaluator** — self-evaluation bias makes agents praise mediocre work
- **Adversarial stance** — evaluators must hunt for failures, not confirm correctness
- **Graded scoring with hard thresholds** — pass/fail is not rigorous enough
- **No sprint contracts** — unnecessary with Opus 4.6
- **No context isolation** — Opus 4.6 handles compaction without context anxiety

## License

MIT
