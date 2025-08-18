---
description: Normalize single file or text input into standardized PRD format for strategic product planning
allowed-tools: Read, Write, LS, Glob, MultiEdit
---

# PRD Normalization Command

You are tasked with normalizing a single document or text input into a standardized Product Requirements Document (PRD) for strategic product planning, using Claude Code output styles.

## Available Output Styles:
- **prometh-prd-standard**: For general strategic requirements and Epic-level planning
- **prometh-prd-feature**: For major feature development with market analysis
- **prometh-prd-bugfix**: For complex issues requiring strategic product decisions

## Supported Input Types:
- **Direct file path**: Single file (PDF, markdown, text, etc.)
- **Text input**: Pasted text or description in the prompt
- **Strategic documents**: Business requirements, market research, executive summaries
- **Initiative proposals**: Cross-functional project proposals, quarterly planning documents
- **Complex issue reports**: Critical issues requiring business analysis and strategic response

## Process:

1. **Analyze Input**: Read and classify the input for strategic scope:
   - **Strategic Planning Documents** → Use `prometh-prd-standard` style
   - **Major Feature Initiatives** → Use `prometh-prd-feature` style
   - **Critical Business Issues** → Use `prometh-prd-bugfix` style

2. **Validate Strategic Scope**: Ensure content is appropriate for PRD-level documentation:
   - **Appropriate**: Cross-functional initiatives, market positioning, quarterly planning
   - **Not appropriate**: Tactical implementations, simple features (suggest `/prometh-spec-normalize` instead)

3. **Apply Output Style**: Transform the content using the appropriate style:
   ```
   Please transform this content using the '[style-name]' output style
   ```

4. **Extract Strategic Information**:
   - Business objectives and market opportunity
   - Cross-functional requirements and stakeholder alignment
   - Competitive analysis and strategic positioning
   - Success metrics and business impact
   - Resource allocation and timeline planning
   - Risk assessment and mitigation strategies

5. **Generate PRD**: Create structured PRD following the selected output style format

6. **Save Output**: Save to `docs/prds/` with descriptive filenames:
   - Strategic planning: `[initiative-name]-prd.md`
   - Major features: `[feature-name]-prd.md`
   - Critical issues: `[issue-resolution]-prd.md`

## Special Handling by Document Type:

### Strategic Planning Documents (→ prometh-prd-standard):
- Focus on cross-functional alignment and business objectives
- Include comprehensive stakeholder analysis and resource planning
- Define measurable business outcomes and success criteria
- Plan quarterly or release-level implementation roadmap

### Major Feature Initiatives (→ prometh-prd-feature):
- Emphasize market opportunity and competitive positioning
- Include comprehensive user research and market analysis
- Define go-to-market strategy and adoption planning
- Plan feature rollout and success measurement strategies

### Critical Business Issues (→ prometh-prd-bugfix):
- Focus on business impact analysis and strategic resolution approach
- Include stakeholder alignment and resource coordination requirements
- Define systematic problem analysis and solution roadmap
- Plan comprehensive testing, rollout, and success validation

## Instructions:

- Always specify which output style is being used
- Validate that content is strategic/Epic-level (not tactical implementation)
- Generate meaningful, descriptive filenames
- Add current date for document creation
- Focus on business value, market impact, and cross-functional alignment
- Ensure `docs/prds/` directory exists before writing
- Report successful PRD creation with file location and selected template

## Strategic Scope Validation:

- **Appropriate for PRDs**: Quarterly planning, market positioning, cross-functional initiatives, major feature launches, strategic technical decisions
- **Redirect to SPECs**: Simple feature implementations, bug fixes, routine tasks, tactical development work

## Arguments:
- If `$ARGUMENTS` contains a file path, read and process that file
- If no file path, process the text content provided in the prompt
- If no content provided, prompt user for input

## Example Usage:
```
/prometh-prd-normalize strategic-planning-document.pdf
/prometh-prd-normalize market-research-findings.md
/prometh-prd-normalize [followed by pasted strategic content]
```

Start by checking if a file path is provided in arguments, otherwise process the prompt text content. Validate strategic scope, classify the content type, apply the appropriate output style, and generate the comprehensive PRD document.