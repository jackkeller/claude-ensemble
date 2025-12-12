#!/bin/bash

# Inject persona context hook - Adds active persona to prompts
# Hook Type: UserPromptSubmit
# Triggers: Every user prompt submission

# Read hook input from stdin
input=$(cat)

# Check if there's an active persona file in the project
# Look for .claude/.active-persona or .claude/projects/{project}/.active-persona
persona_file=""

# Check current directory and walk up to find .claude directory
current_dir="$PWD"
while [[ "$current_dir" != "/" ]]; do
  if [[ -f "$current_dir/.claude/.active-persona" ]]; then
    persona_file="$current_dir/.claude/.active-persona"
    break
  fi
  current_dir=$(dirname "$current_dir")
done

# If no active persona found, exit without adding context
if [[ -z "$persona_file" ]] || [[ ! -f "$persona_file" ]]; then
  exit 0
fi

# Read the persona name from the file
persona_name=$(cat "$persona_file" | tr -d '[:space:]')

# Find the persona file
persona_content=""
persona_path=""

# Check project-specific personas first
if [[ -f "$current_dir/.claude/personas/$persona_name.md" ]]; then
  persona_path="$current_dir/.claude/personas/$persona_name.md"
elif [[ -f "$current_dir/.claude/contexts/personas/$persona_name.md" ]]; then
  persona_path="$current_dir/.claude/contexts/personas/$persona_name.md"
fi

# If persona file found, read it
if [[ -n "$persona_path" ]] && [[ -f "$persona_path" ]]; then
  persona_content=$(cat "$persona_path")

  # Create JSON response with additional context
  # Escape newlines and quotes for JSON
  escaped_content=$(echo "$persona_content" | jq -Rs .)

  cat <<EOF
{
  "additionalContext": "ACTIVE PERSONA: $persona_name\n\nYou are building features for this user persona. Keep their needs, technical level, and accessibility requirements in mind:\n\n$escaped_content"
}
EOF
fi

exit 0
