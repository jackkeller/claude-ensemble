# User Personas

User personas help create user-centered features by providing context about user needs, behaviors, pain points, and technical requirements.

## What Are Personas?

Personas are fictional but realistic representations of your key user types. They help teams:
- Make user-centered design decisions
- Prioritize features based on user needs
- Understand accessibility requirements
- Define appropriate technical complexity
- Set relevant success metrics

## Global Personas

These universal user types are shared across all projects:

- **`admin.md`** - System administrators with elevated permissions
- **`end-user.md`** - General application users
- **`developer.md`** - API consumers and integration developers

## Using Personas

### With the `/user-story` Command

```bash
/user-story admin "wants to bulk delete inactive users"
/user-story end-user "needs password reset functionality"
/user-story developer "requires webhook configuration"
```

The `/user-story` command:
1. Loads the persona context (project-specific first, then global)
2. Enriches the feature request with persona details
3. Creates a comprehensive user story with acceptance criteria
4. Suggests technical considerations based on persona needs
5. Defines success metrics aligned with persona goals

### Manual Reference

Personas can also be referenced manually when:
- Planning features with `/product-analyst`
- Designing UIs with `/ui-architect`
- Ensuring accessibility with `/a11y-expert`
- Planning APIs with `/api-specialist`

## Persona Structure

Each persona file includes:

**Profile Information:**
- Role and technical level
- Primary devices
- Brief description

**Key Sections:**
- **Goals**: What they want to achieve
- **Pain Points**: Frustrations and challenges
- **Technical Needs**: Specific technical requirements
- **Accessibility Needs**: Accessibility considerations
- **User Behaviors**: How they interact with systems
- **Success Metrics**: How to measure success

## Project-Specific Personas

Projects can define domain-specific personas in `.claude/projects/{project}/personas/`.

These personas:
- Override global personas with the same name
- Focus on domain-specific needs and behaviors
- Reference project-specific workflows and features

See project directories for examples (e.g., `.claude/projects/example-project/personas/`).

## Creating New Personas

When creating personas:

1. **Research real users**: Base personas on actual user research, interviews, or analytics
2. **Keep focused**: Each persona should represent a distinct user type with unique needs
3. **Be specific**: Include concrete details about goals, behaviors, and pain points
4. **Include context**: Technical level, devices, and accessibility needs inform implementation
5. **Define success**: Clear metrics help validate if the persona's needs are met

## Benefits

Using personas leads to:
- More user-centered feature design
- Better accessibility from the start
- Appropriate technical complexity for audience
- Clear success criteria for features
- Reduced rework from misaligned features
- Improved user satisfaction
