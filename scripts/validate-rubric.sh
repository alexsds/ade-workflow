#!/usr/bin/env bash
set -euo pipefail

# Validate a rubric file has the required sections

if [ $# -eq 0 ]; then
  echo "Usage: validate-rubric.sh <rubric-file>"
  exit 1
fi

FILE="$1"
ERRORS=0

if [ ! -f "$FILE" ]; then
  echo "ERROR: File not found: $FILE"
  exit 1
fi

# Check required sections
for section in "Applies To" "Criteria" "Scoring Guide"; do
  if ! grep -q "## $section" "$FILE"; then
    echo "ERROR: Missing required section: ## $section"
    ERRORS=$((ERRORS + 1))
  fi
done

# Check for at least one criterion with threshold
if ! grep -q "Threshold:" "$FILE"; then
  echo "ERROR: No criteria with Threshold found"
  ERRORS=$((ERRORS + 1))
fi

# Check threshold values are numbers
while IFS= read -r line; do
  threshold=$(echo "$line" | grep -oE '[0-9]+/10' | head -1)
  if [ -z "$threshold" ]; then
    echo "WARNING: Threshold line without N/10 format: $line"
  fi
done < <(grep "Threshold:" "$FILE")

if [ $ERRORS -eq 0 ]; then
  echo "OK: $FILE is a valid rubric"
  exit 0
else
  echo "FAILED: $FILE has $ERRORS error(s)"
  exit 1
fi
