# ADE — Agent-Driven Engineering

## What This Is

A Claude Code plugin implementing Anthropic's 3-agent harness pattern (Planner, Generator, Evaluator) for long-running app development. Based on research from https://www.anthropic.com/engineering/harness-design-long-running-apps

## Architecture

Skills are the source of truth for methodology. Agents are thin execution shells that reference skills. Commands are orchestration entry points.

- `skills/` — methodology, knowledge, the "why" and "how" (single source of truth)
- `agents/` — execution shells that read skills for guidance
- `commands/` — user-facing entry points that invoke agents

## Development

This is a Claude Code plugin. Structure follows plugin-dev conventions:
- `.claude-plugin/plugin.json` — manifest
- `agents/` — agent definitions (auto-discovered)
- `commands/` — slash commands (auto-discovered)
- `skills/` — skill directories with SKILL.md (auto-discovered)
- `hooks/` — event hooks
- `scripts/` — utility scripts
- `rubrics/` — default evaluation rubrics (referenced by evaluator skill)
- `testing-tools/` — default testing tool configs (referenced by evaluator skill)
- `.mcp.json` — Playwright MCP for browser-based evaluation

## Key Principles

- Commands are instructions FOR Claude, not messages TO users
- Agent descriptions need `<example>` blocks for reliable triggering
- Use `${CLAUDE_PLUGIN_ROOT}` for all internal paths, never hardcode
- Rubrics and testing-tools are pluggable — defaults in plugin, overrides in .ade/
- Planner = subagent (interactive, one-shot). Generator + Evaluator = agent team (SendMessage)
- Skills hold the methodology, agents reference them — one place to update

## Commit Style

Use conventional commits: `feat:`, `fix:`, `docs:`, `chore:`. Single-line messages.

## Commands

```bash
scripts/init-project.sh          # Initialize .ade/ in target project
scripts/validate-rubric.sh <f>   # Validate rubric has required sections
scripts/validate-testing-tool.sh <f>  # Validate testing tool definition
```

## Override Mechanics

Plugin ships default `rubrics/` and `testing-tools/`. Projects override by placing files in `.ade/rubrics/` and `.ade/testing-tools/` (created by `init-project.sh`). Project overrides take precedence.

## Default Rubrics

- `rubrics/frontend-design.md` — Design quality, originality, craft, functionality
- `rubrics/code-architecture.md` — Code structure and patterns
- `rubrics/api-quality.md` — API design standards
- `rubrics/ux-flows.md` — User experience flows

## Default Testing Tools

- `testing-tools/playwright.md` — Browser-based UI testing (Playwright MCP, fallback to curl)
- `testing-tools/api-tester.md` — API endpoint testing
- `testing-tools/unit-test-runner.md` — Unit test execution

## Spec

See `docs/superpowers/specs/2026-04-03-ade-workflow-design.md`
