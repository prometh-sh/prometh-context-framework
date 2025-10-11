---
description: Create or normalize strategic PRDs with PROMETH.md validation and tracking. Supports interactive mode, file normalization (PDF/markdown/text), and text descriptions.
argument-hint: "[description|filename]"
allowed-tools: ["Read", "Write", "LS", "Glob", "MultiEdit"]
---

# PRD Creation and Normalization Command

You are tasked with creating new Product Requirements Documents (PRDs) or normalizing existing documents into standardized PRD format for strategic product planning.

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
1. **File Path Argument**: If `$ARGUMENTS` contains a file path, read and normalize that file
2. **Text Input**: If no file path, process the text content provided in the prompt  
3. **Interactive Mode**: If no content provided, prompt user for strategic description

### Document Processing
1. **PROMETH.md Validation**: Verify framework file exists (mandatory)
2. **Content Analysis**: Analyze input to validate strategic scope
3. **Template Application**: Apply the unified `prometh-prd` output style
4. **Directory Creation**: Ensure `docs/prds/` directory exists
5. **Document Generation**: Create comprehensive PRD with proper formatting
6. **Filename Generation**: Create descriptive filename from content analysis
7. **PROMETH.md Tracking**: Update project tracking file with new PRD information

## Available Output Style
- **prometh-prd**: Unified PRD template for all strategic planning scenarios

## Supported Input Types
- **File paths**: PDF, markdown, text, Word documents, etc.
- **Text input**: Pasted strategic content or descriptions in the prompt
- **Strategic documents**: Business requirements, market research, executive summaries
- **Initiative proposals**: Cross-functional project proposals, quarterly planning documents
- **Complex issue reports**: Critical issues requiring strategic business analysis

## Strategic Scope Validation

### Appropriate for PRDs
- Quarterly planning and roadmap initiatives
- Market positioning and competitive strategy
- Cross-functional initiatives requiring alignment
- Major feature launches with business impact
- Strategic technical decisions affecting multiple teams
- Complex issue resolution requiring business analysis

### Redirect to SPECs (Not Appropriate)
- Simple feature implementations or enhancements
- Bug fixes and routine maintenance tasks
- Tactical development work and technical tasks
- Implementation details without strategic context

If input is determined to be tactical rather than strategic, suggest using `/prometh-spec` instead.

## Filename Generation Logic

Extract meaningful names from content analysis:
- Convert to lowercase and use hyphens
- Remove common words (the, a, an, for, to, with, etc.)
- Keep 2-4 key descriptive words that capture strategic intent
- Format: `[extracted-name]-prd.md`

### Examples:
- "Mobile app platform strategy" → `mobile-app-platform-strategy-prd.md`
- "Customer onboarding experience redesign" → `customer-onboarding-experience-redesign-prd.md`
- "AI-powered personalization implementation" → `ai-personalization-implementation-prd.md`
- "Payment processing scalability issues" → `payment-processing-scalability-prd.md`

## Template Application Process

Use the `prometh-prd` output style with this prompt format:
```
Please create a comprehensive PRD using the 'prometh-prd' output style based on this strategic initiative:

[extracted content or user description]
```

## PRD Creation Examples

### File-based Normalization:
```bash
/prometh-prd strategic-planning-document.pdf
/prometh-prd market-research-findings.md
/prometh-prd business-requirements.docx
```

### Text-based Creation:
```bash
/prometh-prd
User: "We need to develop a comprehensive mobile application that allows customers to manage their accounts, make payments, and access support. This should position us competitively against market leaders and support our Q2 growth targets."
```

### Interactive Mode:
```bash
/prometh-prd
# System prompts for strategic description
# User provides detailed strategic initiative description
# System generates appropriate PRD
```

## PROMETH.md Tracking

After successfully creating or normalizing a PRD, update the project tracking file:

### 1. Check PROMETH.md Existence
```bash
# Check if PROMETH.md exists in project root
ls PROMETH.md 2>/dev/null
```

### 2. Update PROMETH.md Content

**If PROMETH.md exists:**
- Read current content
- Update the PRD inventory section
- Update the recent activity section
- Maintain chronological order

**If PROMETH.md doesn't exist:**
- Display suggestion: "Run `/prometh-init` to initialize project tracking"
- Continue with PRD creation (don't block the process)

### 3. PRD Entry Format

Add new entry to the PRD inventory table:
```
| [filename].md | [Current Date] | Draft | - | [Brief Description] | [Current Date] |
```

**Status Options:**
- `Draft` - Initial creation
- `Under Review` - Stakeholder review phase
- `Approved` - Ready for implementation
- `In Progress` - SPECs being created/implemented
- `Completed` - All related SPECs implemented

### 4. Recent Activity Update

Add entry to recent activity section:
```
- **[Current Date]**: Created PRD - [filename].md ([Brief Description])
```

### 5. Update Timestamps

Update the "Last Updated" timestamp at the top of PROMETH.md:
```
*Last Updated: [Current Date and Time]*
```

### 6. PROMETH.md Update Process

**Privacy Note**: When updating PROMETH.md, ensure no private information is exposed:
- Use relative paths (docs/prds/filename.md) not absolute paths
- Never include user directories or private file paths
- Keep all content shareable with team members

**Implementation Steps:**
1. Read existing PROMETH.md (if exists)
2. Parse PRD inventory table
3. Add new PRD entry with generated filename and description
4. Update recent activity section
5. Update last modified timestamp
6. Write updated content back to PROMETH.md
7. Handle any write errors gracefully

**Error Handling:**
- If PROMETH.md is locked or unwriteable, continue with PRD creation but warn user
- If parsing fails, suggest running `/prometh-init` to reset tracking file
- Never block PRD creation due to tracking file issues

## Instructions

1. **Always validate PROMETH.md existence first** - Exit with error if not found
2. **Process both file inputs and text descriptions** - Handle multiple input types seamlessly
3. **Validate strategic scope** - Ensure content is appropriate for PRD-level documentation
4. **Generate meaningful filenames** - Extract key strategic concepts from content
5. **Use unified template** - Apply `prometh-prd` output style consistently
6. **Add metadata** - Include current date and document information
7. **Create directory structure** - Ensure `docs/prds/` exists before writing
8. **Update PROMETH.md tracking** - Add PRD to project inventory and activity log
9. **Report completion** - Confirm successful PRD creation with file location

## Error Handling

- **No PROMETH.md found**: Display error message and exit immediately
- **Content too tactical**: Suggest using `/prometh-spec` command instead
- **Insufficient strategic context**: Ask for business justification and market impact details
- **File read errors**: Report file access issues and suggest alternatives
- **Directory creation failures**: Report permission or path issues

## Output Format

After successful PRD creation:
```
✅ PRD Created Successfully

File: docs/prds/[filename]-prd.md
Template: prometh-prd (unified)
Type: [Strategic Planning/Major Feature/Critical Issue Resolution]
Date: [Current Date]
Tracking: Added to PROMETH.md inventory

The PRD has been saved and is ready for stakeholder review.

💡 Next Steps:
- Create implementation SPECs: /prometh-spec --from-prd docs/prds/[filename]-prd.md
- Generate project documentation: /prometh-doc readme
- View project status: Open PROMETH.md to see all documents
```

## Example Usage Scenarios

### 1. Creating PRD from Strategic Description
```bash
/prometh-prd
# User provides: "Launch comprehensive B2B platform to capture small business market segment"
# Result: comprehensive-b2b-platform-prd.md in docs/prds/
```

### 2. Normalizing Existing Strategic Document
```bash
/prometh-prd quarterly-planning-doc.pdf
# Result: quarterly-planning-initiative-prd.md in docs/prds/
```

### 3. Converting Business Requirements
```bash
/prometh-prd
# User provides pasted business requirements text
# Result: Normalized PRD document following standard format
```

Start by validating CLAUDE.md existence, then process the input according to type (file path, text content, or interactive prompt), validate strategic scope, and generate the comprehensive PRD document using the unified template.