# Project-Specific Configurations

This directory stores project-specific Claude configurations that need to sync across your machines but shouldn't be shared across all projects.

## Structure

Each project gets its own subdirectory:

```
projects/
├── my-web-app/
│   ├── mcp.json           # MCP server configuration
│   └── context.md         # Project-specific context
└── my-api/
    └── mcp.json
```

## Usage

### Create Project Configuration

```bash
# In shared config repo
mkdir -p ~/dev/claude-shared-config/.claude/projects/my-project
```

### Add MCP Servers

```bash
# Create MCP configuration
cat > ~/dev/claude-shared-config/.claude/projects/my-project/mcp.json << 'EOF'
{
  "mcpServers": {
    "example-server": {
      "command": "npx",
      "args": ["-y", "@example/mcp-server"]
    }
  }
}
EOF
```

### Link to Project

```bash
# In your project directory
ln -sf ~/dev/claude-shared-config/.claude/projects/my-project/mcp.json .claude/mcp.json
```

### Sync Across Machines

```bash
cd ~/dev/claude-shared-config
git add .
git commit -m "Add project-specific config"
git push
```

On your other machine:
```bash
cd ~/dev/claude-shared-config
git pull
```

The symlinks in your project will automatically point to the updated configs.

## Benefits

- ✅ Project-specific configs sync across your work/home computers
- ✅ No config leakage between unrelated projects
- ✅ Version controlled and backed up
- ✅ Works with both public and private projects
