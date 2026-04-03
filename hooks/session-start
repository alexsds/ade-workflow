#!/usr/bin/env bash
set -euo pipefail

# ADE Session Start Hook
# Checks if the current project has ADE initialized and reports status

ADE_DIR="${CLAUDE_PROJECT_DIR:-.}/.ade"

if [ -d "$ADE_DIR" ]; then
  # Check for active plans
  PLAN_COUNT=$(find "$ADE_DIR/docs/plans" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')
  ARCHIVE_COUNT=$(find "$ADE_DIR/docs/archive" -name "*.md" 2>/dev/null | wc -l | tr -d ' ')

  echo ""
  echo "ADE initialized. Active plans: $PLAN_COUNT | Archived: $ARCHIVE_COUNT"

  if [ "$PLAN_COUNT" -gt 0 ]; then
    LATEST_PLAN=$(ls -t "$ADE_DIR/docs/plans/"*.md 2>/dev/null | head -1)
    if [ -n "$LATEST_PLAN" ]; then
      PLAN_NAME=$(basename "$LATEST_PLAN")
      echo "Latest plan: $PLAN_NAME"
    fi
  fi
fi
