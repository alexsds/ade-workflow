# ADE — Agent-Driven Engineering

## What This Is

A Claude Code plugin implementing Anthropic's 3-agent harness pattern (Planner, Generator, Evaluator) for long-running app development. Based on research from https://www.anthropic.com/engineering/harness-design-long-running-apps

## Development

This is a Claude Code plugin. Structure follows plugin-dev conventions:
- `.claude-plugin/plugin.json` — manifest
- `agents/` — agent definitions (auto-discovered)
- `commands/` — slash commands (auto-discovered)
- `skills/` — skill directories with SKILL.md (auto-discovered)
- `hooks/` — event hooks
- `scripts/` — utility scripts

## Key Principles

- Commands are instructions FOR Claude, not messages TO users
- Agent descriptions need `<example>` blocks for reliable triggering
- Use `${CLAUDE_PLUGIN_ROOT}` for all internal paths, never hardcode
- Rubrics and testing-tools are pluggable — defaults in plugin, overrides in .ade/
- Planner = subagent (one-shot). Generator + Evaluator = agent team (SendMessage)

## Commit Style

Use conventional commits: `feat:`, `fix:`, `docs:`, `chore:`

## Spec

See `docs/superpowers/specs/2026-04-03-ade-workflow-design.md`
