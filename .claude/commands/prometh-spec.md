---
description: Create new SPEC documents from scratch for implementation tasks with user-provided descriptions
allowed-tools: Write, LS, Glob, MultiEdit
---

# SPEC Creation Command

You are tasked with creating new Specification (SPEC) documents from scratch in the `docs/specs/` directory based on detailed user descriptions of implementation tasks.

## Available Output Styles:
- **prometh-spec-feature**: For new feature implementation (user stories)
- **prometh-spec-bugfix**: For bug fixes and defects
- **prometh-spec-enhancement**: For improvements to existing features  
- **prometh-spec-task**: For technical/maintenance tasks

## Processing Logic:

1. **Analyze User Description**: Classify the request type based on keywords and context:
   - **Feature keywords**: "new feature", "add", "create", "implement", "build"
   - **Bug keywords**: "fix", "bug", "issue", "error", "broken", "not working"
   - **Enhancement keywords**: "improve", "enhance", "upgrade", "optimize", "better"
   - **Task keywords**: "setup", "configure", "migrate", "refactor", "maintenance"

2. **Determine Template**: Apply appropriate output style:
   - Feature request → Use `prometh-spec-feature` style
   - Bug/issue description → Use `prometh-spec-bugfix` style
   - Enhancement/improvement → Use `prometh-spec-enhancement` style
   - Technical/maintenance → Use `prometh-spec-task` style
   - Default: Use `prometh-spec-feature` style

3. **Create Directory**: Ensure `docs/specs/` directory exists

4. **Generate SPEC**: Create new SPEC using appropriate template with user description:
   ```
   Please create a new SPEC using the '[style-name]' output style based on this user description:
   [user description content]
   ```

5. **Generate Filename**: Create descriptive filename from user description:
   - Feature SPECs: `feature-[extracted-name]-spec.md`
   - Bug fix SPECs: `fix-[extracted-issue]-spec.md`
   - Enhancement SPECs: `enhance-[extracted-name]-spec.md`
   - Task SPECs: `task-[extracted-name]-spec.md`

6. **Save SPEC**: Write to `docs/specs/` with current date and comprehensive content

## Filename Generation Logic:

Extract meaningful names from user descriptions:
- Convert to lowercase and use hyphens
- Remove common words (the, a, an, for, to, with, etc.)
- Keep 2-4 key descriptive words
- Examples:
  - "Add user profile photo upload" → `feature-user-profile-photo-upload-spec.md`
  - "Fix login button not working on mobile" → `fix-login-button-mobile-spec.md`
  - "Improve search performance" → `enhance-search-performance-spec.md`
  - "Setup Redis caching" → `task-setup-redis-caching-spec.md`

## Template Selection Examples:

### Feature Implementation:
```bash
/prometh-spec
User: "I need to implement a user profile editing feature where users can update their name, email, and profile picture. The form should have validation and real-time preview."
```
- Uses: `prometh-spec-feature` style
- Filename: `feature-user-profile-editing-spec.md`
- Focus: User story, acceptance criteria, UI requirements, validation rules

### Bug Fix:
```bash
/prometh-spec
User: "The search functionality is returning incorrect results when users type special characters. It should handle all Unicode characters properly and return relevant matches."
```
- Uses: `prometh-spec-bugfix` style
- Filename: `fix-search-special-characters-spec.md`
- Focus: Problem statement, reproduction steps, fix implementation, testing

### Enhancement:
```bash
/prometh-spec
User: "Enhance the existing dashboard to load faster by implementing lazy loading for widgets and adding skeleton screens during loading states."
```
- Uses: `prometh-spec-enhancement` style
- Filename: `enhance-dashboard-performance-spec.md`
- Focus: Current state, improvement goals, implementation approach, performance metrics

### Technical Task:
```bash
/prometh-spec
User: "Set up automated database backups that run daily at 2 AM, store backups in S3, and send notifications on success/failure."
```
- Uses: `prometh-spec-task` style
- Filename: `task-automated-database-backups-spec.md`
- Focus: Technical requirements, configuration, monitoring, validation

## Special Handling by SPEC Type:

### Feature SPECs:
- Convert user description to formal user story format
- Define comprehensive acceptance criteria
- Include UI/UX requirements and wireframes if applicable
- Specify integration points with existing features
- Define test cases for user-facing functionality

### Bug Fix SPECs:
- Analyze problem description and define root cause analysis
- Create reproduction steps and expected vs. actual behavior
- Define specific fix approach and implementation steps
- Include regression testing and edge case validation
- Specify rollback procedures if needed

### Enhancement SPECs:
- Document current state vs. desired future state
- Define measurable improvement goals and success criteria
- Include backward compatibility and migration considerations
- Specify performance or usability improvements
- Plan incremental implementation if needed

### Task SPECs:
- Define clear technical objectives and deliverables
- Include detailed configuration and setup procedures
- Specify validation steps and success criteria
- Document system dependencies and requirements
- Include monitoring and maintenance procedures

## Instructions:

- Always prompt user for detailed description if not provided
- Automatically classify request type based on content analysis
- Generate meaningful filenames from user descriptions
- Add current date to document metadata
- Ensure `docs/specs/` directory exists before writing
- Focus on implementation-ready specifications
- Include all necessary technical details for development
- Report successful SPEC creation with file location and selected template

## Error Handling:

- If user description is too vague, ask for more specific details
- If unable to classify request type, default to feature SPEC
- If `docs/specs/` cannot be created, report error and exit
- If filename generation fails, use timestamp-based fallback

## Example Usage:
```bash
/prometh-spec
```
Then provide detailed description when prompted, such as:
- "Create a password reset flow with email verification and secure token generation"
- "Fix the shopping cart total calculation when discount codes are applied"
- "Improve the image upload process to support drag-and-drop and progress indicators"
- "Setup CI/CD pipeline with automated testing and deployment to staging environment"

Start by prompting the user for a detailed description of what they want to implement, then classify the request type, select appropriate template, and generate the SPEC document.