---
description: Normalize documents from docs/inbox into standardized PRD format using output styles
allowed-tools: Read, Write, LS, Glob, MultiEdit
---

# PRD Normalization Command

You are tasked with normalizing documents from the `docs/inbox/` directory into standardized Product Requirements Documents (PRDs) using Claude Code output styles.

## Available Output Styles:
- **prd-standard**: For general requirements and feature documents  
- **prd-bugfix**: Specialized for bug/issue reports converted to PRDs
- **prd-feature**: For new feature requests and development

## Supported Document Types:
- **PDFs**: Requirements documents, bug reports, issue exports, specifications
- **Markdown**: Feature requests, technical docs, user stories  
- **Text files**: Notes, informal requirements, meeting minutes
- **Any readable format**: Word docs, RTF, etc.

## Process:

1. **Check Inbox**: List all files in `docs/inbox/` directory

2. **Read & Analyze**: Read each document and classify its type:
   - **Bug/Issue Reports** → Use `prd-bugfix` style
   - **Feature Requests** → Use `prd-feature` style  
   - **General Requirements** → Use `prd-standard` style

3. **Apply Output Style**: Transform the document using the appropriate style:
   ```
   Please transform this document using the '[style-name]' output style
   ```

4. **Extract Key Information**: From source documents, identify:
   - Problem statement and context
   - Target audience and user impact
   - Requirements and acceptance criteria
   - Technical specifications and constraints
   - Success metrics and validation
   - Priority and timeline information

5. **Generate PRD**: Create structured PRD following the selected output style format

6. **Save Output**: Save to `docs/prds/` with descriptive filenames:
   - Bug fixes: `fix-[issue-name]-prd.md`
   - Features: `feature-[name]-prd.md`
   - General: `[document-title]-prd.md`

7. **Archive Processed Files**: After successful PRD creation:
   - Create `docs/archive/` directory if it doesn't exist
   - Move processed files from `docs/inbox/` to `docs/archive/`
   - Rename files with timestamp: `originalfilename-YYYYMMDD-HHMMSS.ext`
   - Example: `feature-request.md` → `feature-request-20241217-143022.md`

## Special Handling by Document Type:

### Bug/Issue Documents (→ prd-bugfix):
- Focus on problem analysis and systematic resolution
- Convert reproduction steps to user impact scenarios  
- Map severity levels to business priority
- Include comprehensive testing and rollback plans

### Feature Requests (→ prd-feature):
- Emphasize user value and market positioning
- Include competitive analysis and differentiation
- Define comprehensive user experience design
- Plan go-to-market and adoption strategies

### General Requirements (→ prd-standard):
- Comprehensive product specification approach
- Balance business and technical requirements
- Focus on measurable outcomes and success criteria

## Instructions:

- Always specify which output style you're using
- Preserve all critical information from source documents
- Generate meaningful, descriptive filenames
- Add current date for document creation
- If source contains multiple items, create separate PRDs
- Create `docs/archive/` directory if it doesn't exist
- After successful processing, move files to archive with timestamp
- Report processing results, file locations, and archive status

## Arguments:
- If `$ARGUMENTS` contains a filename, process only that file
- If no arguments, process all files in `docs/inbox/`

## Example Usage:
```
/prd-normalize bug-report-login-issue.pdf
/prd-normalize feature-request-dark-mode.md  
/prd-normalize
```

Start by checking available files in the inbox, classify each document type, and proceed with normalization using the appropriate output style.