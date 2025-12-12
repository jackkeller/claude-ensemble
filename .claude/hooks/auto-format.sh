#!/bin/bash

# Auto-format hook - Runs after Edit/Write operations on code files
# Hook Type: PostToolUse
# Triggers: Edit, Write tools on .ts, .tsx, .js, .jsx files

# Read hook input from stdin
input=$(cat)

# Extract file path from the tool parameters
file_path=$(echo "$input" | jq -r '.parameters.file_path // empty')

# Exit if no file path (shouldn't happen, but be safe)
if [[ -z "$file_path" ]]; then
  exit 0
fi

# Exit if file doesn't exist
if [[ ! -f "$file_path" ]]; then
  exit 0
fi

# Determine project root (look for package.json)
project_root=$(dirname "$file_path")
while [[ "$project_root" != "/" ]]; do
  if [[ -f "$project_root/package.json" ]]; then
    break
  fi
  project_root=$(dirname "$project_root")
done

# Check for Biome (preferred)
if [[ -f "$project_root/biome.json" ]] && command -v biome &> /dev/null; then
  biome format --write "$file_path" &> /dev/null
  exit 0
fi

# Check for Prettier
if [[ -f "$project_root/.prettierrc" ]] || [[ -f "$project_root/.prettierrc.json" ]] || [[ -f "$project_root/.prettierrc.js" ]]; then
  if command -v prettier &> /dev/null; then
    prettier --write "$file_path" &> /dev/null
    exit 0
  fi

  # Try npx if prettier not in PATH
  if command -v npx &> /dev/null; then
    cd "$project_root" && npx prettier --write "$file_path" &> /dev/null
    exit 0
  fi
fi

# No formatter found or configured - exit successfully
exit 0
