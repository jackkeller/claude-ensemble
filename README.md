# Claude Ensemble 🎵

A curated collection of specialist agents, commands, and user personas for [Claude Code](https://claude.com/claude-code) that enables orchestrated, user-centered development.

## What's Included

### 🎭 Agents (Deep Specialists)
- **review** - Expert code reviewer for pull request analysis and feedback
- **a11y-expert** - Accessibility specialist for inclusive web applications
- **fullstack-architect** - End-to-end application architecture and design

### ⚡ Commands (Quick Utilities)

**Orchestrators & Planning:**
- `/engineer` - Analyze tasks and route to specialist agents
- `/new-task` - Break down complex features into actionable steps
- `/user-story` - Create user stories with persona context
- `/misc:feature-plan` - Plan features with technical specifications

**React Generators:**
- `/react:component-new` - Create React components with TypeScript
- `/react:page-new` - Create Next.js pages with App Router

### 👥 Personas (User-Centered Development)
Pre-built user personas for understanding your audience:
- **End User** - Non-technical users focused on task completion
- **Admin** - Power users managing systems and workflows
- **Developer** - Technical users building and integrating

### 🗂️ Project Templates
Example project configurations showing how to set up:
- **Project Context** - Document tech stack, conventions, and common tasks
- **MCP Servers** - Configure Model Context Protocol servers per-project

## Installation

### 1. Clone the Repository
```bash
git clone https://github.com/yourusername/claude-ensemble.git ~/dev/claude-ensemble
```

### 2. Link to Your Project

**Option A: Link Everything**
```bash
cd your-project
ln -sf ~/dev/claude-ensemble/.claude .claude
```

**Option B: Link Selectively**
```bash
cd your-project
mkdir -p .claude
ln -sf ~/dev/claude-ensemble/.claude/agents .claude/agents
ln -sf ~/dev/claude-ensemble/.claude/commands .claude/commands
ln -sf ~/dev/claude-ensemble/.claude/contexts .claude/contexts
```

### 3. Restart Claude Code
Restart Claude Code to pick up the new configuration.

## Usage

### Using the Orchestrator
The `/engineer` command analyzes your request and recommends specialist agents:

```
/engineer I need to build a user profile page with accessibility features
```

Claude will analyze the task, identify required specialists (ui-architect, a11y-expert), and coordinate the work.

### Using Personas
Create user stories that understand your audience:

```
/user-story As an end user, I want to filter search results
```

### Creating Components
Generate React components following best practices:

```
/react:component-new UserProfile
```

### Project-Specific Configurations
For project-specific settings like MCP servers or context, see the [example project](.claude/projects/example-project/) showing:
- `context.md` - Document your project's tech stack, conventions, and tasks
- `mcp.json` - Configure MCP servers specific to your project

See [.claude/projects/README.md](.claude/projects/README.md) for full details on creating and syncing project configs.

## File Structure

```
claude-ensemble/
├── .claude/
│   ├── agents/              # Deep specialist agents
│   │   ├── review.md
│   │   ├── a11y-expert.md
│   │   └── fullstack-architect.md
│   ├── commands/            # Quick utilities
│   │   ├── engineer.md      # Orchestrator
│   │   ├── user-story.md
│   │   ├── new-task.md
│   │   ├── misc/
│   │   │   └── feature-plan.md
│   │   └── react/
│   │       ├── component-new.md
│   │       └── page-new.md
│   ├── contexts/
│   │   └── personas/        # User personas
│   │       ├── end-user.md
│   │       ├── admin.md
│   │       └── developer.md
│   └── projects/            # Project-specific configs
│       ├── README.md
│       └── example-project/
│           ├── context.md
│           └── mcp.json
└── README.md
```

## Philosophy

**Orchestrated Development**: Use the `/engineer` command to coordinate multiple specialists rather than doing everything yourself.

**User-Centered**: Start with personas and user stories to ensure you're building the right thing.

**Best Practices**: All generators follow modern framework patterns and accessibility standards.

**Composable**: Mix and match agents, commands, and personas for your workflow.

## Contributing

Contributions welcome! To add a new agent or command:

1. Fork the repository
2. Add your `.md` file following the existing format (with frontmatter)
3. Test in a linked project
4. Submit a PR with documentation updates

## License

MIT License - see LICENSE file for details

## Related

- [Claude Code Documentation](https://docs.claude.com/claude-code)
- [Claude Code on GitHub](https://github.com/anthropics/claude-code)
