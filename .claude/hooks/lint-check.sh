#!/bin/bash

# Lint check hook - Runs linter before git commits
# Hook Type: PreToolUse
# Triggers: Bash tool with git commit commands

# Read hook input from stdin
input=$(cat)

# Extract the bash command
command=$(echo "$input" | jq -r '.parameters.command // empty')

# Only run if this is a git commit
if [[ ! "$command" =~ "git commit" ]]; then
  exit 0
fi

# Find project root (look for package.json)
project_root="$PWD"
while [[ "$project_root" != "/" ]]; do
  if [[ -f "$project_root/package.json" ]]; then
    break
  fi
  project_root=$(dirname "$project_root")
done

# If no package.json found, skip linting
if [[ ! -f "$project_root/package.json" ]]; then
  exit 0
fi

# Change to project root
cd "$project_root" || exit 0

# Check for lint script in package.json
has_lint_script=$(jq -r '.scripts.lint // empty' package.json)

if [[ -z "$has_lint_script" ]]; then
  # No lint script, exit successfully
  exit 0
fi

# Run the linter
echo "Running linter before commit..." >&2

if npm run lint &> /tmp/lint-output.log; then
  echo "Lint check passed ✓" >&2
  exit 0
else
  echo "Lint check failed ✗" >&2
  echo "Output:" >&2
  cat /tmp/lint-output.log >&2

  # Block the commit
  cat <<EOF
{
  "error": "Lint check failed. Please fix linting errors before committing."
}
EOF
  exit 1
fi
