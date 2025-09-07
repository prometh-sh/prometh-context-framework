---
description: Create or normalize implementation SPECs with PROMETH.md tracking. Supports interactive mode, file normalization, PRD-to-SPEC workflow (--from-prd), and 3-phase implementation structure.
argument-hint: "[description|filename|--from-prd prd-file.md]"
allowed-tools: ["Read", "Write", "LS", "Glob", "MultiEdit"]
---

# SPEC Creation and Normalization Command

You are tasked with creating new Specification (SPEC) documents or normalizing existing documents into standardized SPEC format for implementation tasks.

## PROMETH.md Validation

**MANDATORY FIRST STEP**: Before any processing, check for PROMETH.md in the project root:

```bash
# Check for required framework file
ls PROMETH.md 2>/dev/null
```

If file does not exist, display this error and EXIT:
```
❌ Prometh Context Framework Error

PROMETH.md not found in project root.

Please initialize the Prometh Context Framework first:
• Run '/prometh-init' to set up framework tracking and directory structure

This file is required for Prometh commands to track documents and maintain project state.
```

## Processing Logic

### Input Handling
1. **PRD-to-SPEC Mode**: If `$ARGUMENTS` contains `--from-prd [prd-file.md]`, create SPEC(s) from existing PRD
2. **File Path Argument**: If `$ARGUMENTS` contains a file path, read and normalize that file
3. **Text Input**: If no file path, process the text content provided in the prompt
4. **Interactive Mode**: If no content provided, prompt user for implementation description

### Document Processing
1. **PROMETH.md Validation**: Verify framework file exists (mandatory)
2. **Content Analysis**: Analyze input to classify implementation type
3. **Template Application**: Apply the unified `prometh-spec` output style with 3-phase workflow
4. **Directory Creation**: Ensure `docs/specs/` directory exists
5. **Document Generation**: Create comprehensive SPEC with implementation workflow
6. **Filename Generation**: Create descriptive filename from content analysis
7. **PROMETH.md Tracking**: Update project tracking file with new SPEC information and traceability

## Available Output Style
- **prometh-spec**: Unified SPEC template with 3-phase implementation workflow for all implementation scenarios

## Supported Input Types
- **File paths**: PDF, markdown, text, Word documents, existing specs
- **Text input**: Pasted implementation requirements or descriptions in the prompt
- **User stories**: Existing user story formats and acceptance criteria
- **Bug reports**: Issue descriptions with reproduction steps
- **Task descriptions**: Technical requirements and maintenance tasks
- **Enhancement requests**: Improvement descriptions for existing features

## Implementation Type Classification

The system automatically classifies content into implementation types:

### Feature Development
- **Keywords**: "new feature", "add", "create", "implement", "build", "develop"
- **Focus**: User stories, acceptance criteria, UI requirements, integration

### Bug Fixes  
- **Keywords**: "fix", "bug", "issue", "error", "broken", "not working", "defect"
- **Focus**: Problem analysis, reproduction steps, root cause, testing

### Enhancements
- **Keywords**: "improve", "enhance", "upgrade", "optimize", "better", "performance"
- **Focus**: Current vs. desired state, backward compatibility, incremental improvement

### Technical Tasks
- **Keywords**: "setup", "configure", "migrate", "refactor", "maintenance", "deploy"
- **Focus**: Technical objectives, configuration, validation procedures

## Filename Generation Logic

Extract meaningful names from content analysis:
- Convert to lowercase and use hyphens
- Remove common words (the, a, an, for, to, with, etc.)
- Keep 2-4 key descriptive words that capture implementation intent
- Use type-based prefixes:

### Filename Patterns:
- **Features**: `feature-[extracted-name]-spec.md`
- **Bug Fixes**: `fix-[extracted-issue]-spec.md`
- **Enhancements**: `enhance-[extracted-name]-spec.md`
- **Technical Tasks**: `task-[extracted-name]-spec.md`

### Examples:
- "Add user profile photo upload" → `feature-user-profile-photo-upload-spec.md`
- "Fix login button not working on mobile" → `fix-login-button-mobile-spec.md`
- "Improve search performance" → `enhance-search-performance-spec.md`
- "Setup Redis caching system" → `task-setup-redis-caching-spec.md`

## Template Application Process

Use the `prometh-spec` output style with this prompt format:
```
Please create a comprehensive SPEC using the 'prometh-spec' output style based on this implementation task:

[extracted content or user description]
```

## SPEC Creation Examples

### File-based Normalization:
```bash
/prometh-spec user-story.md
/prometh-spec bug-report.pdf
/prometh-spec enhancement-request.docx
/prometh-spec technical-requirements.txt
```

### Text-based Creation:
```bash
/prometh-spec
User: "I need to implement a user profile editing feature where users can update their name, email, and profile picture. The form should have validation and real-time preview."
```

### Interactive Mode:
```bash
/prometh-spec
# System prompts for implementation description
# User provides detailed task description
# System generates appropriate SPEC with workflow
```

### PRD-to-SPEC Creation:
```bash
/prometh-spec --from-prd docs/prds/mobile-platform-strategy-prd.md
# Analyzes existing PRD and creates implementation SPEC(s)
# Updates PROMETH.md with traceability link
```

## PROMETH.md Tracking

After successfully creating or normalizing a SPEC, update the project tracking file:

### 1. Check PROMETH.md Existence
```bash
# Check if PROMETH.md exists in project root
ls PROMETH.md 2>/dev/null
```

### 2. Update PROMETH.md Content

**If PROMETH.md exists:**
- Read current content
- Update the SPEC inventory section
- Update the recent activity section
- Update traceability matrix if PRD-linked
- Maintain chronological order

**If PROMETH.md doesn't exist:**
- Display suggestion: "Run `/prometh-init` to initialize project tracking"
- Continue with SPEC creation (don't block the process)

### 3. SPEC Entry Format

Add new entry to the SPEC inventory table:
```
| [filename].md | [Current Date] | [Type] | [Linked PRD] | Draft | [Brief Description] | [Current Date] |
```

**Type Options:**
- `Feature` - New feature implementation
- `Bug Fix` - Defect resolution and fixes
- `Enhancement` - Improvements to existing features
- `Technical Task` - Maintenance, configuration, infrastructure

**Status Options:**
- `Draft` - Initial creation
- `Under Review` - Stakeholder/team review phase
- `Approved` - Ready for development
- `In Progress` - Development in progress
- `Testing` - Implementation complete, testing phase
- `Completed` - Fully implemented and deployed

**Linked PRD Column:**
- If created via --from-prd: Link to originating PRD filename
- If standalone SPEC: "-" or "N/A"
- Enables traceability from strategic to tactical documentation

### 4. Recent Activity Update

Add entry to recent activity section:
```
- **[Current Date]**: Created SPEC - [filename].md ([Type] - [Brief Description])
```

**If PRD-linked:**
```
- **[Current Date]**: Created SPEC - [filename].md ([Type] - [Brief Description]) from PRD: [prd-filename].md
```

### 5. Traceability Matrix Update

**If SPEC is linked to a PRD (--from-prd option):**
Update the traceability matrix section:

**New Entry Format:**
```
| [prd-filename].md | [spec-filename].md | Draft |
```

**Update Existing Entry:**
If PRD already exists in matrix, add SPEC to the "Derived SPECs" column:
```
| [prd-filename].md | [existing-specs].md, [new-spec].md | [Status] |
```

### 6. Update Timestamps

Update the "Last Updated" timestamp at the top of PROMETH.md:
```
*Last Updated: [Current Date and Time]*
```

### 7. PROMETH.md Update Process

**Privacy Note**: When updating PROMETH.md, ensure no private information is exposed:
- Use relative paths (docs/specs/filename.md) not absolute paths
- Never include user directories or private file paths
- Keep all content shareable with team members

**Implementation Steps:**
1. Read existing PROMETH.md (if exists)
2. Parse SPEC inventory table
3. Add new SPEC entry with generated filename, type, and description
4. Update recent activity section
5. Update traceability matrix if PRD-linked
6. Update last modified timestamp
7. Write updated content back to PROMETH.md
8. Handle any write errors gracefully

**Error Handling:**
- If PROMETH.md is locked or unwriteable, continue with SPEC creation but warn user
- If parsing fails, suggest running `/prometh-init` to reset tracking file
- Never block SPEC creation due to tracking file issues
- Report traceability link creation success/failure

## PRD-to-SPEC Workflow

### --from-prd Option Processing

When `--from-prd [prd-file]` is specified:

### 1. PRD File Validation
```bash
# Validate PRD file exists and is readable
if [ -f "$prd_file" ]; then
    echo "✓ Found PRD file: $prd_file"
else
    echo "❌ PRD file not found: $prd_file"
    exit 1
fi
```

### 2. PRD Content Analysis
- **Read PRD Content**: Extract strategic requirements and business objectives
- **Identify Implementation Areas**: Parse features, requirements, and technical needs
- **Determine SPEC Scope**: Decide if single comprehensive SPEC or multiple focused SPECs are needed

### 3. Implementation Strategy
**Single SPEC Approach:**
- One comprehensive SPEC covering all PRD implementation aspects
- Suitable for smaller PRDs or tightly coupled features

**Multiple SPEC Approach:**
- Break down large PRDs into focused implementation SPECs
- Each SPEC covers specific feature areas or system components
- Maintain traceability back to originating PRD

### 4. SPEC Generation Process
```
Please create implementation SPEC(s) using the 'prometh-spec' output style based on this PRD:

PRD File: [prd-filename]
PRD Content: [extracted strategic content]

Generate focused implementation specification(s) that translate the strategic requirements into actionable development tasks with 3-phase workflow.
```

### 5. Traceability Establishment
- **Link SPEC to PRD**: Record which PRD generated this SPEC
- **Update PROMETH.md**: Add traceability entry in matrix
- **Cross-reference**: Include PRD reference in SPEC document

## 3-Phase Implementation Workflow

All generated SPECs include a structured 3-phase workflow:

### Phase 1: Planning
- Requirements analysis and clarification
- Technical design and architecture decisions  
- Resource allocation and timeline estimation

### Phase 2: Task Breakdown
- Create detailed development tasks
- Define acceptance criteria for each task
- Identify dependencies and risk factors

### Phase 3: Implementation
- Execute development tasks in priority order
- Perform testing and quality assurance
- Deploy and validate in production environment

## Instructions

1. **Always validate PROMETH.md existence first** - Exit with error if not found
2. **Process both file inputs and text descriptions** - Handle multiple input types seamlessly
3. **Classify implementation type automatically** - Determine feature/bug/enhancement/task category
4. **Generate meaningful filenames** - Extract key implementation concepts from content
5. **Use unified template with workflow** - Apply `prometh-spec` output style consistently
6. **Add metadata** - Include current date and document information
7. **Create directory structure** - Ensure `docs/specs/` exists before writing
8. **Report completion** - Confirm successful SPEC creation with file location and type

## Error Handling

- **No PROMETH.md found**: Display error message and exit immediately
- **Content too strategic**: Suggest using `/prometh-prd` command instead
- **Insufficient implementation detail**: Ask for technical requirements and acceptance criteria
- **File read errors**: Report file access issues and suggest alternatives
- **Directory creation failures**: Report permission or path issues
- **Classification uncertainty**: Default to feature SPEC with user notification

## Output Format

After successful SPEC creation:
```
✅ SPEC Created Successfully

File: docs/specs/[filename]-spec.md
Template: prometh-spec (unified with 3-phase workflow)
Type: [Feature/Bug Fix/Enhancement/Technical Task]
Date: [Current Date]

The SPEC includes a structured 3-phase implementation workflow and is ready for development.
```

## Example Usage Scenarios

### 1. Creating Feature SPEC from Description
```bash
/prometh-spec
# User provides: "Create a password reset flow with email verification and secure token generation"
# Result: feature-password-reset-flow-spec.md in docs/specs/
```

### 2. Normalizing Existing Bug Report
```bash
/prometh-spec bug-report-login-issue.pdf
# Result: fix-login-authentication-spec.md in docs/specs/
```

### 3. Converting Enhancement Request
```bash
/prometh-spec
# User provides: "Improve the image upload process to support drag-and-drop and progress indicators"
# Result: enhance-image-upload-process-spec.md in docs/specs/
```

### 4. Processing Technical Task
```bash
/prometh-spec
# User provides: "Setup CI/CD pipeline with automated testing and deployment to staging environment"
# Result: task-setup-cicd-pipeline-spec.md in docs/specs/
```

## Strategic vs. Tactical Validation

If input content appears to be strategic rather than implementation-focused:
- **Strategic indicators**: Market analysis, business objectives, cross-functional alignment
- **Response**: Suggest using `/prometh-prd` command instead
- **Message**: "This content appears to be strategic in nature. Consider using `/prometh-prd` for Product Requirements Documents."

## Quality Assurance Features

Each generated SPEC includes:
- **Clear acceptance criteria** in Given/When/Then format
- **Comprehensive test strategy** with unit, integration, and user acceptance testing
- **Risk assessment** with mitigation strategies
- **Deployment procedures** with rollback plans
- **3-phase workflow** with actionable tasks and deliverables

Start by validating CLAUDE.md existence, then process the input according to type (file path, text content, or interactive prompt), classify the implementation type, and generate the comprehensive SPEC document using the unified template with 3-phase workflow.