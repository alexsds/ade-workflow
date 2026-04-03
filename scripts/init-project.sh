#!/usr/bin/env bash
set -euo pipefail

# ADE Project Initialization
# Creates .ade/ directory structure and default settings

PROJECT_DIR="${CLAUDE_PROJECT_DIR:-.}"
ADE_DIR="$PROJECT_DIR/.ade"
SETTINGS_DIR="$PROJECT_DIR/.claude"
SETTINGS_FILE="$SETTINGS_DIR/ade.local.md"

# Create .ade directory structure
mkdir -p "$ADE_DIR/rubrics"
mkdir -p "$ADE_DIR/testing-tools"
mkdir -p "$ADE_DIR/docs/plans"
mkdir -p "$ADE_DIR/docs/archive"

# Create default settings if not exists
if [ ! -f "$SETTINGS_FILE" ]; then
  mkdir -p "$SETTINGS_DIR"
  cat > "$SETTINGS_FILE" << 'SETTINGS'
---
commits_style: conventional
---

# ADE Project Settings

Configure commit style above:
- `conventional` — feat(scope): description
- `jira` — TICKET-123 Description (planner will ask for ticket number)
SETTINGS
  echo "Created $SETTINGS_FILE"
fi

echo "ADE initialized at $ADE_DIR"
echo "Settings at $SETTINGS_FILE"
