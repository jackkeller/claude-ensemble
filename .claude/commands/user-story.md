---
description: Create user story with persona context for feature planning
model: claude-sonnet-4-5
---

You are helping create a user-centered feature specification using persona context.

## Input Format

$ARGUMENTS

Expected format: `<persona-name> <feature-description>`

Example:
- `admin wants to bulk delete inactive users`
- `end-user needs password reset functionality`
- `developer requires webhook configuration`

## Process

### 1. Parse Input
Extract the persona name and feature description from the arguments.

### 2. Load Persona Context

**Loading Priority:**
1. First, check for project-specific persona: `.claude/projects/{project-name}/personas/{persona-name}.md`
2. If not found, fall back to global persona: `.claude/contexts/personas/{persona-name}.md`
3. If neither exists, proceed with generic context but note the missing persona

**Available Global Personas:**
- `admin` - System administrators with elevated permissions
- `end-user` - General application users
- `developer` - API consumers and integration developers

**Available Project Personas:**
Check the current project's `.claude/projects/{project-name}/personas/` directory for project-specific personas.

### 3. Enrich Feature Context

Using the loaded persona information, enrich the feature request with:

**User Context:**
- Role and technical level
- Primary goals related to this feature
- Relevant pain points this addresses
- Accessibility needs to consider
- Typical user behaviors

**Technical Context:**
- Technical needs from persona profile
- Device/platform considerations
- Preferred interaction patterns
- Success metrics to track

### 4. Create User Story

Format as a comprehensive user story:

```markdown
## User Story

**As a** [persona role with context]
**I want** [feature with specific details]
**So that** [benefit/goal achievement]

## Persona Context

**Technical Level:** [level]
**Primary Device:** [devices]
**Key Goals:** [relevant goals from persona]
**Pain Points Addressed:** [specific pain points]

## Acceptance Criteria

- [ ] [Criterion 1 based on persona needs]
- [ ] [Criterion 2 based on persona needs]
- [ ] [Criterion 3 based on accessibility needs]
- [ ] [Criterion 4 based on technical needs]

## Technical Considerations

- **UX Requirements:** [Based on persona behaviors]
- **Accessibility:** [Based on persona accessibility needs]
- **Device Support:** [Based on primary devices]
- **Performance:** [Based on persona expectations]

## Success Metrics

[Relevant metrics from persona profile]

## Implementation Notes

[Consider persona's technical level, pain points, and behaviors]
```

### 5. Follow-Up Analysis

After creating the user story, optionally invoke deeper analysis:

**For complex features:**
- Suggest using `/product-analyst` for full feature breakdown
- Suggest using `/ui-architect` for UI/UX considerations
- Suggest using `/a11y-expert` if accessibility is critical

**For API features:**
- Suggest using `/api-specialist` for API design
- Suggest using `/developer` persona for integration context

## Example Usage

**Input:** `admin wants to bulk delete inactive users`

**Output:**
```markdown
## User Story

**As a** system administrator managing user accounts across multiple projects
**I want** to bulk delete inactive users based on configurable criteria
**So that** I can maintain database hygiene and reduce clutter efficiently

## Persona Context

**Technical Level:** High
**Primary Device:** Desktop (90%)
**Key Goals:**
- Efficiently manage users at scale
- Maintain data integrity
- Save time on repetitive tasks

**Pain Points Addressed:**
- Lack of bulk operations for repetitive tasks
- Complex multi-step processes for common tasks

## Acceptance Criteria

- [ ] Select users by inactivity period (30, 60, 90, 180 days)
- [ ] Preview affected users before deletion with count
- [ ] Confirm action with explicit acknowledgment
- [ ] Support bulk selection (select all, filter-based selection)
- [ ] Provide keyboard shortcut for power users
- [ ] Show deletion progress for large batches
- [ ] Log all deletions in audit trail
- [ ] Allow undo within reasonable time window
- [ ] Export list of deleted users for record-keeping

## Technical Considerations

- **UX Requirements:** Information-dense interface, minimal clicks, confirmation dialog with preview
- **Accessibility:** Keyboard navigation, clear focus indicators, confirmation before destructive actions
- **Device Support:** Desktop-optimized (primary use case)
- **Performance:** Handle large selections (1000+ users) efficiently

## Success Metrics

- Time to delete inactive users (target: <2 minutes for any size batch)
- Reduction in accidental deletions
- Admin satisfaction with bulk operations
- Audit trail completeness

## Implementation Notes

Admins are power users who value efficiency. Provide:
- Advanced filtering options
- Preview before action
- Comprehensive logging
- Keyboard shortcuts
- Ability to export selection for review
```

## Persona Context Loading

When loading persona files:
1. Use the `Read` tool to load persona markdown files
2. Extract relevant sections for the feature context
3. Note if persona file is not found and proceed with best effort
4. Consider both universal patterns and persona-specific needs

## Output Format

Provide the enriched user story with persona context, then suggest next steps based on feature complexity.
