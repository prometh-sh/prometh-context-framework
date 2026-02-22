---
description: Create or normalize implementation SPECs with tracking file updates. Supports interactive mode, file normalization, PRD-to-SPEC workflow, and 3-phase implementation structure. Use this skill when asked to create a SPEC, write a technical specification, convert an implementation description into structured SPEC format, or derive a SPEC from an existing PRD.
allowed-tools: ["Read", "Write", "LS", "Glob", "MultiEdit"]
---

# SPEC Creation and Normalization Skill

You are tasked with creating new Specification (SPEC) documents or normalizing existing documents into standardized SPEC format for implementation tasks.

## Directory and Tracking File Resolution

**MANDATORY FIRST STEP**: Resolve the documentation directory and tracking file:

**Directory Resolution:**
```bash
# Check for documentation directories (local takes precedence)
if [ -d "prometh-docs.local" ]; then
  DOCS_DIR="prometh-docs.local"
elif [ -d "prometh-docs" ]; then
  DOCS_DIR="prometh-docs"
else
  echo "❌ Error: Neither prometh-docs/ nor prometh-docs.local/ found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Tracking File Resolution:**
```bash
# Check for tracking files (local takes precedence)
if [ -f "PROMETH.local.md" ]; then
  TRACKING_FILE="PROMETH.local.md"
elif [ -f "PROMETH.md" ]; then
  TRACKING_FILE="PROMETH.md"
else
  echo "❌ Error: Neither PROMETH.md nor PROMETH.local.md found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Priority Rules:**
- `prometh-docs.local/` takes precedence over `prometh-docs/`
- `PROMETH.local.md` takes precedence over `PROMETH.md`
- Use resolved variables (`$DOCS_DIR` and `$TRACKING_FILE`) for all file operations

## Processing Logic

### Input Handling

1. **PRD-to-SPEC Mode**: If the conversation references `--from-prd [prd-file.md]`, create SPEC(s) from that existing PRD
2. **File Path Argument**: If a file path is mentioned, read and normalize that file
3. **Text Input**: If no file path, process the text content provided in the conversation
4. **Interactive Mode**: If no content provided, prompt user for implementation description

### Document Processing
1. Content analysis and implementation type classification
2. Apply unified `prometh-spec` output style with 3-phase workflow
3. Ensure `${DOCS_DIR}/specs/` directory exists
4. Generate comprehensive SPEC with implementation workflow
5. Create descriptive filename from content analysis
6. Update tracking file with SPEC information and traceability

## Supported Input Types
- **File paths**: PDF, markdown, text, Word documents, existing specs
- **Text input**: Pasted implementation requirements or descriptions in the conversation
- **User stories**: Existing user story formats and acceptance criteria
- **Bug reports**: Issue descriptions with reproduction steps
- **Task descriptions**: Technical requirements and maintenance tasks
- **Enhancement requests**: Improvement descriptions for existing features

## Implementation Type Classification

The skill automatically classifies content into implementation types:

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

## Template Application

Apply the `prometh-spec` output style with this prompt format:
```
Please create a comprehensive SPEC using the 'prometh-spec' output style based on this implementation task:

[extracted content or user description]
```

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

## PRD-to-SPEC Workflow

When `--from-prd [prd-file]` is referenced:

1. **PRD File Validation**: Verify PRD file exists and is readable
2. **PRD Content Analysis**: Extract strategic requirements and business objectives
3. **Determine SPEC Scope**: Decide if single comprehensive SPEC or multiple focused SPECs are needed
4. **SPEC Generation**: Create SPEC(s) that translate strategic requirements into actionable development tasks
5. **Traceability Establishment**: Link SPEC to originating PRD in tracking file

**Single SPEC Approach** — Suitable for smaller PRDs or tightly coupled features.

**Multiple SPEC Approach** — Break down large PRDs into focused implementation SPECs, each covering specific feature areas.

## Tracking File Management

After successfully creating or normalizing a SPEC:

### SPEC Entry Format
Add new entry to the SPEC inventory table:
```
| [filename].md | [Current Date] | [Type] | [Linked PRD or -] | Draft | [Brief Description] | [Current Date] |
```

**Type Options:** Feature, Bug Fix, Enhancement, Technical Task

**Status Options:** Draft, Under Review, Approved, In Progress, Testing, Completed

### Recent Activity Update
```
- **[Current Date]**: Created SPEC - [filename].md ([Type] - [Brief Description])
```

**If PRD-linked:**
```
- **[Current Date]**: Created SPEC - [filename].md ([Type]) from PRD: [prd-filename].md
```

### Traceability Matrix Update (PRD-linked only)
Add or update entry in traceability matrix:
```
| [prd-filename].md | [spec-filename].md | Draft |
```

Update the "Last Updated" timestamp at the top of the tracking file.

**Privacy Note**: Use relative paths (`${DOCS_DIR}/specs/filename.md`), never absolute paths or user directories.

## Strategic vs. Tactical Validation

If input content appears to be strategic rather than implementation-focused:
- **Strategic indicators**: Market analysis, business objectives, cross-functional alignment
- **Response**: Suggest using the `prometh-prd` skill instead
- **Message**: "This content appears to be strategic in nature. Consider using the `prometh-prd` skill for Product Requirements Documents."

## Error Handling

- **No tracking file found**: Display error message and suggest `/prometh-init`
- **Content too strategic**: Suggest using the `prometh-prd` skill instead
- **Insufficient implementation detail**: Ask for technical requirements and acceptance criteria
- **File read errors**: Report file access issues and suggest alternatives
- **Directory creation failures**: Report permission or path issues
- **Classification uncertainty**: Default to feature SPEC with user notification
- **Tracking write failure**: Warn but never block SPEC creation

## Output Format

After successful SPEC creation:
```
✅ SPEC Created Successfully

File: ${DOCS_DIR}/specs/[filename]-spec.md
Template: prometh-spec (unified with 3-phase workflow)
Type: [Feature/Bug Fix/Enhancement/Technical Task]
Date: [Current Date]

The SPEC includes a structured 3-phase implementation workflow and is ready for development.

💡 Next Steps:
- Execute implementation: /prometh-build ${DOCS_DIR}/specs/[filename]-spec.md
- View project status: /prometh-status
```

Start by resolving the documentation directory and tracking file, then process the input according to type (file path, text content, or interactive prompt), classify the implementation type, and generate the comprehensive SPEC document using the `prometh-spec` output style with 3-phase workflow.
