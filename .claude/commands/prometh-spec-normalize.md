---
description: Normalize single file or text input into standardized SPEC format for implementation tasks
allowed-tools: Read, Write, LS, Glob, MultiEdit
---

# SPEC Normalization Command

You are tasked with normalizing a single document or text input into a standardized Specification (SPEC) document for implementation tasks, using Claude Code output styles.

## Available Output Styles:
- **prometh-spec-feature**: For new feature implementation (user stories)
- **prometh-spec-bugfix**: For bug fixes and defects  
- **prometh-spec-enhancement**: For improvements to existing features
- **prometh-spec-task**: For technical/maintenance tasks

## Supported Input Types:
- **Direct file path**: Single file (PDF, markdown, text, etc.)
- **Text input**: Pasted text or description in the prompt
- **User stories**: Existing user story formats
- **Bug reports**: Issue descriptions and reproduction steps
- **Task descriptions**: Technical requirements or maintenance tasks

## Process:

1. **Analyze Input**: Read and classify the input type:
   - **New Feature Request** → Use `prometh-spec-feature` style
   - **Bug/Issue Report** → Use `prometh-spec-bugfix` style
   - **Enhancement/Improvement** → Use `prometh-spec-enhancement` style
   - **Technical/Maintenance Task** → Use `prometh-spec-task` style

2. **Apply Output Style**: Transform the content using the appropriate style:
   ```
   Please transform this content using the '[style-name]' output style
   ```

3. **Extract Key Information**:
   - User story and acceptance criteria
   - Technical implementation requirements
   - UI/UX requirements (if applicable)
   - Test cases and validation
   - Dependencies and assumptions

4. **Generate SPEC**: Create structured SPEC following the selected output style format

5. **Save Output**: Save to `docs/specs/` with descriptive filenames:
   - Features: `feature-[name]-spec.md`
   - Bug fixes: `fix-[issue-name]-spec.md`
   - Enhancements: `enhance-[name]-spec.md`
   - Tasks: `task-[name]-spec.md`

## Special Handling by Document Type:

### Feature Requests (→ prometh-spec-feature):
- Focus on user story format with clear acceptance criteria
- Define specific implementation steps and UI requirements
- Include test cases for user-facing functionality
- Specify integration points with existing features

### Bug Reports (→ prometh-spec-bugfix):
- Convert issue description to clear problem statement
- Define specific steps to reproduce and fix
- Include regression testing requirements
- Specify impact assessment and rollback plan

### Enhancements (→ prometh-spec-enhancement):
- Focus on incremental improvements to existing features
- Define current state vs. desired state
- Include backward compatibility considerations
- Specify migration or update procedures

### Technical Tasks (→ prometh-spec-task):
- Define clear technical objectives and deliverables
- Include configuration and setup requirements
- Specify validation and testing procedures
- Document any system impact or dependencies

## Instructions:

- Always specify which output style is being used
- Generate meaningful, descriptive filenames
- Add current date for document creation
- Ensure `docs/specs/` directory exists before writing
- Focus on implementation-level detail, not strategic planning
- Keep specifications concise but complete for development work
- Report successful SPEC creation with file location

## Arguments:
- If `$ARGUMENTS` contains a file path, read and process that file
- If no file path, process the text content provided in the prompt
- If no content provided, prompt user for input

## Example Usage:
```
/prometh-spec-normalize user-story.md
/prometh-spec-normalize bug-report.pdf
/prometh-spec-normalize [followed by pasted text description]
```

Start by checking if a file path is provided in arguments, otherwise process the prompt text content. Classify the content type, apply the appropriate output style, and generate the SPEC document.