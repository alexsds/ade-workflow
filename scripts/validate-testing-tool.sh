#!/usr/bin/env bash
set -euo pipefail

# Validate a testing tool file has the required sections

if [ $# -eq 0 ]; then
  echo "Usage: validate-testing-tool.sh <testing-tool-file>"
  exit 1
fi

FILE="$1"
ERRORS=0

if [ ! -f "$FILE" ]; then
  echo "ERROR: File not found: $FILE"
  exit 1
fi

# Check required sections
for section in "Applies To" "How To Use" "What To Check"; do
  if ! grep -q "## $section" "$FILE"; then
    echo "ERROR: Missing required section: ## $section"
    ERRORS=$((ERRORS + 1))
  fi
done

# Check optional but recommended sections
if ! grep -q "## Setup" "$FILE"; then
  echo "NOTE: Optional section missing: ## Setup"
fi

if [ $ERRORS -eq 0 ]; then
  echo "OK: $FILE is a valid testing tool"
  exit 0
else
  echo "FAILED: $FILE has $ERRORS error(s)"
  exit 1
fi
