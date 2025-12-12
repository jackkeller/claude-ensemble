---
description: Build a new skill with guided questions
model: claude-sonnet-4-5
---

You are helping the user create a new Claude Code skill. Skills are packages of institutional knowledge that Claude automatically loads and uses across projects.

# Skill Builder Process

Ask the user these questions ONE AT A TIME, waiting for their response after each:

## 1. Skill Name
"What would you like to name this skill? (Use kebab-case, e.g., 'api-patterns', 'design-system')"

Store as: `skill_name`

## 2. Skill Description
"Provide a brief description (one sentence) of what this skill covers:"

Store as: `skill_description`

## 3. Skill Domain
"What domain does this skill cover? Examples:
- Coding standards (language-specific best practices)
- API patterns (REST, GraphQL conventions)
- Design system (component library, design tokens)
- Security guidelines (auth, encryption, compliance)
- Data patterns (schema design, migrations)
- Testing strategies (unit, integration, e2e)
- Deployment processes (CI/CD, infrastructure)
- Other (describe)"

Store as: `skill_domain`

## 4. Target Audience
"Who will use this skill? (e.g., 'all developers', 'frontend team', 'data engineers', 'product managers')"

Store as: `skill_audience`

## 5. Core Principles
"What are 3-5 core principles or guidelines for this domain? (Provide as bullet points)"

Store as: `core_principles` (array)

## 6. Reference Topics
"What specific topics should have detailed reference documents? Examples:
- Language-specific guidelines (typescript-guidelines.md)
- Tool configurations (prettier-config.md)
- Workflow guides (git-workflow.md)
- Best practices (error-handling.md)

List the topics you want reference docs for:"

Store as: `reference_topics` (array)

## 7. Quick Reference Items
"What are the most important quick-reference items someone should know? (e.g., 'Functions: max 50 lines', 'Always use TypeScript strict mode')"

Store as: `quick_reference` (array)

## 8. When to Consult
"When should someone consult this skill? (e.g., 'Starting a new feature', 'During code review', 'Setting up a new project')"

Store as: `when_to_consult` (array)

---

# After Gathering All Answers

Once you have all the information, create the skill:

1. Create directory: `.claude/skills/{skill_name}/references/`

2. Generate `SKILL.md`:
```markdown
---
name: {skill_description}
description: {skill_description}
---

# {Skill Name} Skill

This skill contains {skill_description} for {skill_audience}.

## Core Principles

{List core_principles as numbered list}

## Workflow

When working in this domain:

{Generate workflow steps based on reference_topics}

## Quick Reference

{List quick_reference items as bullet points}

## When to Consult This Skill

{List when_to_consult items as bullet points}

See `references/` directory for detailed specifications.
```

3. For each topic in `reference_topics`, create a template file:
```markdown
# {Topic Name}

## Overview

{Brief introduction - ask user to fill in later}

## Guidelines

### Guideline 1

{Template with example code blocks}

### Guideline 2

{Template with example code blocks}

## Examples

### Good Example
\`\`\`
// Example code
\`\`\`

### Avoid
\`\`\`
// Anti-pattern
\`\`\`

## Additional Resources

- Link to official docs
- Link to internal wiki
```

4. Create `.claude/skills/{skill_name}/README.md` if needed for skill-specific documentation

5. Tell the user:
   - Skill created at `.claude/skills/{skill_name}/`
   - Next steps: Fill in reference document templates
   - How to test: Ask Claude Code questions about the domain
   - Remind them to symlink to projects: `ln -sf ~/dev/claude-shared-config/.claude/skills .claude/skills`

---

# Important Notes

- Be conversational and encouraging
- If the user is unsure, provide examples from similar domains
- Suggest reference topics based on the skill domain
- Keep the initial skill focused - they can expand later
- Validate skill_name is kebab-case before creating files
- Create all directories and files with proper structure
- Make sure SKILL.md has proper frontmatter

# User Input

$ARGUMENTS
