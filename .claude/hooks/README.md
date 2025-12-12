# Hooks

Hooks are shell scripts that run automatically at specific events during Claude Code sessions. They enable automation, rule enforcement, and dynamic context injection.

## Hook Types

| Hook | When It Fires | Common Uses |
|------|---------------|-------------|
| **SessionStart** | Session begins | Load project context, check dependencies |
| **UserPromptSubmit** | User submits prompt | Inject persona, validate intent |
| **PreToolUse** | Before tool runs | Block unsafe operations, validate params |
| **PostToolUse** | After tool completes | Format code, run linters, update docs |
| **PermissionRequest** | Permission dialog | Auto-approve safe operations |
| **Stop** | Claude finishes response | Clean up, save state |
| **SubagentStop** | Subagent completes | Chain workflows, aggregate results |
| **PreCompact** | Before context compression | Save important context |

## Configuration

Hooks are configured in project-level or user-level settings:

### Project-Level (`.claude/projects/{project}/hooks.json`)
```json
{
  "hooks": {
    "postToolUse": {
      "command": "~/.claude/hooks/auto-format.sh",
      "description": "Auto-format files after edits",
      "matchers": [{
        "toolName": "Edit",
        "paramMatchers": {
          "file_path": ".*\\.(ts|tsx|js|jsx)$"
        }
      }]
    }
  }
}
```

### User-Level (`~/.config/claude-code/settings.json`)
```json
{
  "hooks": {
    "sessionStart": {
      "command": "~/.claude/hooks/session-start.sh",
      "description": "Initialize session context"
    }
  }
}
```

## Available Hook Scripts

### auto-format.sh
Automatically formats code after file edits using project formatter (Prettier, Biome, etc.).

**Hook Type**: `PostToolUse`
**Triggers On**: Edit, Write tools
**Purpose**: Maintain consistent code style

### inject-persona.sh
Injects active persona context into user prompts for user-centered development.

**Hook Type**: `UserPromptSubmit`
**Triggers On**: Every prompt submission
**Purpose**: Maintain persona awareness

### lint-check.sh
Runs linters before commits to catch issues early.

**Hook Type**: `PreToolUse`
**Triggers On**: Bash (git commit)
**Purpose**: Prevent broken commits

## Using Hook Scripts

1. **Make executable**: `chmod +x .claude/hooks/{script}.sh`
2. **Configure in project**: Add to `.claude/projects/{project}/hooks.json`
3. **Test**: Trigger the event and check hook output

## Writing Custom Hooks

### Basic Structure
```bash
#!/bin/bash

# Hook receives stdin with JSON context
input=$(cat)

# Parse input (use jq for JSON parsing)
tool_name=$(echo "$input" | jq -r '.toolName // empty')

# Perform your logic
if [[ "$tool_name" == "Edit" ]]; then
  file_path=$(echo "$input" | jq -r '.parameters.file_path')
  # Do something with the file
fi

# Exit codes control behavior
exit 0  # Continue normally
exit 1  # Block/fail the operation
```

### Response with JSON
```bash
#!/bin/bash

# Generate dynamic context
persona_context="User is a senior developer focused on accessibility"

# Return JSON response
cat <<EOF
{
  "additionalContext": "$persona_context"
}
EOF

exit 0
```

## Security Considerations

- Hooks run with **your user permissions** - be cautious
- **Validate all inputs** from Claude Code
- **Don't expose secrets** in hook output
- **Test thoroughly** before deploying
- **Use matchers** to limit hook scope

## Best Practices

1. **Start Small**: Begin with one simple hook for a specific pain point
2. **Log Extensively**: Debug hooks by logging to temp files
3. **Fail Gracefully**: Handle errors without breaking workflows
4. **Document Intent**: Add clear descriptions in hook configs
5. **Version Control**: Commit hooks to share across team

## Integration with Orchestrators

Hooks enhance orchestrator workflows:

```json
{
  "hooks": {
    "userPromptSubmit": {
      "command": "~/.claude/hooks/inject-persona.sh",
      "description": "Auto-inject persona before /engineer routing"
    },
    "subagentStop": {
      "command": "~/.claude/hooks/chain-agents.sh",
      "description": "Auto-route to next specialist after agent completes"
    }
  }
}
```

This creates fully automated multi-agent workflows triggered by user prompts.

## Troubleshooting

### Hook Not Firing
- Check hook is executable (`chmod +x`)
- Verify JSON syntax in config
- Check matchers are correct
- Look for errors in Claude Code logs

### Hook Blocking Operations
- Check exit codes (0 = success, 1 = block)
- Review hook logic for unintended conditions
- Test hook script independently

### Performance Issues
- Minimize hook execution time
- Use async operations where possible
- Cache expensive computations
- Profile with `time` command
