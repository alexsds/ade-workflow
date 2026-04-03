# ADE — Agent-Driven Engineering

A Claude Code plugin implementing Anthropic's recommended 3-agent harness for long-running application development.

Based on: [Harness Design for Long-Running Apps](https://www.anthropic.com/engineering/harness-design-long-running-apps)

## How It Works

```
/ade:plan "Build a task management app"
    → Planner creates product-level plan
    → You review and approve

/ade:execute
    → Generator implements features one by one
    → Evaluator tests and scores each feature
    → They iterate until all rubric criteria pass

/ade:done
    → Archives the completed plan
```

## Three Agents

| Agent | Role | Key Behavior |
|-------|------|-------------|
| **Planner** | Product-level planning | Features + user stories, NOT technical details |
| **Generator** | Implementation | Builds feature-by-feature, commits to git |
| **Evaluator** | Adversarial QA | Scores against rubrics with hard thresholds |

## Pluggable Rubrics

Default rubrics in `rubrics/`:
- `frontend-design.md` — UI quality, originality, craft, functionality
- `code-architecture.md` — separation of concerns, clarity, error handling, testability
- `api-quality.md` — API design, responses, validation, security
- `ux-flows.md` — flow coherence, edge cases, information architecture, feedback

Add custom rubrics by dropping `.md` files in `.ade/rubrics/` in your project.

## Pluggable Testing Tools

Default tools in `testing-tools/`:
- `playwright.md` — browser testing via Playwright MCP
- `api-tester.md` — HTTP endpoint testing via curl
- `unit-test-runner.md` — test suite execution

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
| `/ade:plan [idea]` | Generate product-level plan |
| `/ade:execute` | Launch Generator + Evaluator team |
| `/ade:done` | Archive completed plan |
| `/ade:status` | Show build progress |

## Install

```
/plugin install ade
```

## Why This Architecture

Anthropic's research found:
- **High-level planning only** — micro-detail errors cascade through implementation
- **Separate evaluator** — self-evaluation bias makes agents praise mediocre work
- **Graded scoring** — pass/fail is not rigorous enough
- **No sprint contracts** — unnecessary with Opus 4.6
- **No context isolation** — Opus 4.6 handles compaction without context anxiety

## License

MIT
