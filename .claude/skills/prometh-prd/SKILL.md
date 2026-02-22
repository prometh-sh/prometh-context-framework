---
description: Create or normalize strategic Product Requirements Documents (PRDs) with tracking file updates. Handles interactive descriptions, file normalization (PDF/markdown/text), and strategic scope validation. Use this skill when asked to create a PRD, write a product requirements document, or convert strategic planning documents into structured PRD format.
allowed-tools: ["Read", "Write", "LS", "Glob", "MultiEdit"]
---

# PRD Creation and Normalization Skill

You are tasked with creating new Product Requirements Documents (PRDs) or normalizing existing documents into standardized PRD format for strategic product planning.

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
1. **File Path Argument**: If a file path is mentioned, read and normalize that file
2. **Text Input**: If no file path, process the text content provided in the conversation
3. **Interactive Mode**: If no content provided, prompt user for strategic description

### Document Processing
1. **Directory Resolution**: Determine DOCS_DIR and TRACKING_FILE using the logic above
2. **Content Analysis**: Analyze input to validate strategic scope
3. **Template Application**: Apply the unified `prometh-prd` output style
4. **Directory Verification**: Ensure `${DOCS_DIR}/prds/` directory exists
5. **Document Generation**: Create comprehensive PRD with proper formatting
6. **Filename Generation**: Create descriptive filename from content analysis
7. **Tracking File Update**: Update the tracking file with new PRD information

## Supported Input Types
- **File paths**: PDF, markdown, text, Word documents, etc.
- **Text input**: Pasted strategic content or descriptions in the conversation
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

### Redirect to prometh-spec (Not Appropriate)
- Simple feature implementations or enhancements
- Bug fixes and routine maintenance tasks
- Tactical development work and technical tasks
- Implementation details without strategic context

If input is determined to be tactical rather than strategic, suggest using the `prometh-spec` skill instead.

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

## Template Application

Apply the `prometh-prd` output style with the following prompt format:
```
Please create a comprehensive PRD using the 'prometh-prd' output style based on this strategic initiative:

[extracted content or user description]
```

## Tracking File Management

After successfully creating or normalizing a PRD:

### PRD Entry Format
Add new entry to the PRD inventory table:
```
| [filename].md | [Current Date] | Draft | - | [Brief Description] | [Current Date] |
```

**Status Options:** Draft, Under Review, Approved, In Progress, Completed

### Recent Activity Update
```
- **[Current Date]**: Created PRD - [filename].md ([Brief Description])
```

Update the "Last Updated" timestamp at the top of the tracking file.

**Privacy Note**: Use relative paths (`${DOCS_DIR}/prds/filename.md`), never absolute paths or user directories.

## Error Handling

- **No tracking file found**: Display error and suggest `/prometh-init`
- **Content too tactical**: Suggest using the `prometh-spec` skill instead
- **Insufficient strategic context**: Ask for business justification and market impact details
- **File read errors**: Report file access issues and suggest alternatives
- **Directory creation failures**: Report permission or path issues
- **Tracking write failure**: Warn but never block PRD creation

## Output Format

After successful PRD creation:
```
✅ PRD Created Successfully

File: ${DOCS_DIR}/prds/[filename]-prd.md
Template: prometh-prd (unified)
Type: [Strategic Planning/Major Feature/Critical Issue Resolution]
Date: [Current Date]
Tracking: Added to tracking file inventory

💡 Next Steps:
- Create implementation SPECs: /prometh-spec --from-prd ${DOCS_DIR}/prds/[filename]-prd.md
- View project status: /prometh-status
```

Start by resolving the documentation directory and tracking file, then process the input according to type (file path, text content, or interactive prompt), validate strategic scope, and generate the comprehensive PRD document using the `prometh-prd` output style in the resolved directory.
