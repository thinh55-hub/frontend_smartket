#!/usr/bin/env bash
set -euo pipefail

# Validate that each mapping.commentMarker in tools/figma_mappings/home_page_1_mapping.json
# exists somewhere in the frontend code. Exit 0 if all found, 1 otherwise.

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
MAPPING_FILE="$ROOT_DIR/tools/figma_mappings/home_page_1_mapping.json"
CODE_DIR="$ROOT_DIR"

if ! command -v jq >/dev/null 2>&1; then
  echo "ERROR: jq is required but not installed. Install jq and re-run."
  exit 2
fi

if [ ! -f "$MAPPING_FILE" ]; then
  echo "ERROR: Mapping file not found: $MAPPING_FILE"
  exit 2
fi

missing=0
markers=$(jq -r '.mappings[]?.commentMarker // empty' "$MAPPING_FILE")

if [ -z "$markers" ]; then
  echo "No commentMarker entries found in $MAPPING_FILE"
  exit 0
fi

while IFS= read -r marker; do
  # skip empty lines
  if [ -z "$marker" ]; then
    continue
  fi

  # Use fixed-string search to avoid regex pitfalls
  if grep -R --line-number --fixed-strings "$marker" "$CODE_DIR" >/dev/null 2>&1; then
    echo "FOUND: $marker"
  else
    echo "MISSING: $marker"
    missing=$((missing+1))
  fi

done <<< "$markers"

if [ "$missing" -gt 0 ]; then
  echo "\nValidation failed: $missing marker(s) missing."
  exit 1
fi

echo "\nValidation passed: all markers found."
exit 0
