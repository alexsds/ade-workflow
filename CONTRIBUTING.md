# Contributing to ADE

Thanks for your interest in contributing to ADE (Agent-Driven Engineering).

## Development Setup

1. Clone the repository
2. The plugin uses Claude Code's plugin system — no build step required
3. Test locally by copying files to `.claude/` in any project

## Project Structure

```
ade-workflow/
  .claude-plugin/plugin.json    # Plugin manifest
  agents/                       # Agent definitions
  commands/                     # Slash commands
  skills/                       # Auto-triggering skills
  rubrics/                      # Default evaluation rubrics
  testing-tools/                # Default testing tool configs
  hooks/                        # Session hooks
  scripts/                      # Utility scripts
```

## Key Conventions

- **Commands are instructions FOR Claude**, not messages to users
- **Agent descriptions** must include `<example>` blocks for reliable triggering
- **Use `${CLAUDE_PLUGIN_ROOT}`** for all internal paths — never hardcode
- **Rubrics and testing tools** follow specific formats — validate with scripts in `scripts/`
- **Commit style**: conventional commits (`feat:`, `fix:`, `docs:`, `chore:`)

## Adding a Rubric

1. Create a `.md` file in `rubrics/` with sections: `## Applies To`, `## Criteria`, `## Scoring Guide`
2. Each criterion needs a name, weight (high/medium/low), and threshold (N/10)
3. Validate: `bash scripts/validate-rubric.sh rubrics/your-rubric.md`

## Adding a Testing Tool

1. Create a `.md` file in `testing-tools/` with sections: `## Applies To`, `## How To Use`, `## What To Check`
2. Validate: `bash scripts/validate-testing-tool.sh testing-tools/your-tool.md`

## Pull Requests

- One logical change per PR
- Include a clear description of what and why
- Validate rubrics and testing tools before submitting
- Test commands and agents locally before submitting
