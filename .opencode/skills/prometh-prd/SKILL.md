---
name: prometh-prd
description: Create or normalize strategic Product Requirements Documents (PRDs) with tracking file updates. Handles interactive descriptions, file normalization (PDF/markdown/text), and strategic scope validation. Use this skill when asked to create a PRD, write a product requirements document, or convert strategic planning documents into structured PRD format.
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

## Configuration Resolution

**After resolving the tracking file**, read the `## Document Configuration` section:

```
1. Open ${TRACKING_FILE} and locate the ## Document Configuration section
2. Extract the YAML block under ### Metadata Template
   → Store as METADATA_TEMPLATE (set to nil if section or block is absent/empty)
3. Extract the YAML block under ### Filename Patterns
   → Store as FILENAME_CONFIG (set to nil if section or block is absent/empty)
```

These two variables govern filename generation and metadata injection for all
documents created in this session.

## Processing Logic

### Input Handling
1. **File Path Argument**: If a file path is mentioned, read and normalize that file
2. **Text Input**: If no file path, process the text content provided in the conversation
3. **Interactive Mode**: If no content provided, prompt user for strategic description

### Document Processing
1. **Directory Resolution**: Determine DOCS_DIR and TRACKING_FILE using the logic above
2. **Configuration Resolution**: Read METADATA_TEMPLATE and FILENAME_CONFIG from TRACKING_FILE
3. **Content Analysis**: Analyze input to validate strategic scope
4. **Template Application**: Apply the unified PRD template (embedded below)
5. **Directory Verification**: Ensure `${DOCS_DIR}/prds/` directory exists
6. **Document Generation**: Create comprehensive PRD with proper formatting
7. **Filename Generation**: Apply configured pattern or fall back to legacy format
8. **Metadata Injection**: Prepend YAML frontmatter if METADATA_TEMPLATE is present
9. **Tracking File Update**: Update the tracking file with new PRD information

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

If input is determined to be tactical rather than strategic, suggest loading the `prometh-spec` skill instead.

## Filename Generation Logic

### Name Slug Rules (apply in all cases)

Extract a meaningful slug from the document title or content:
- Convert to lowercase and replace spaces with hyphens
- Remove common stop-words (the, a, an, for, to, with, of, and, or, in, on, at, etc.)
- Keep 2–5 key descriptive words that capture the strategic intent
- Result: `{NAME}` token (e.g. `mobile-strategy`, `customer-onboarding-redesign`)

### Configured Pattern (when FILENAME_CONFIG is present)

Read `prd_pattern` from FILENAME_CONFIG and substitute tokens:

| Token | Value |
|-------|-------|
| `{DATE}` | Current date as `YYYYMMDD` (e.g. `20260223`) |
| `{DATETIME}` | Current datetime as `YYYYMMDDHHMM` (e.g. `202602231830`) |
| `{NAME}` | Slugified document name (see rules above) |

**Default configured pattern:** `PRD-{DATE}-{NAME}.md`

Examples with default pattern:
- "Mobile app platform strategy" → `PRD-20260223-mobile-app-platform-strategy.md`
- "Customer onboarding experience redesign" → `PRD-20260223-customer-onboarding-redesign.md`
- "AI-powered personalization" → `PRD-20260223-ai-personalization.md`

### Legacy Fallback (when FILENAME_CONFIG is absent)

If no `## Document Configuration` section or `prd_pattern` key is found in the
tracking file, fall back to the original format:

- Format: `[extracted-name]-prd.md`
- Examples: `mobile-app-platform-strategy-prd.md`, `customer-onboarding-redesign-prd.md`

Print an info message when falling back:
```
ℹ️  No filename configuration found in ${TRACKING_FILE}. Using legacy filename format.
   To configure: add a ## Document Configuration section with a ### Filename Patterns block.
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

## Sensitive Data Protection

When generating documents, **never** include:
- API keys, secrets, tokens, passwords, or credentials
- Environment variable **values** (reference names only, e.g. `$DATABASE_URL`)
- Private hostnames, IP addresses, or internal URLs
- PII (personal emails, account IDs, private names)
- Database connection strings or `.env` file contents
- Absolute file paths or user home directories

Use placeholder values where examples are needed (e.g. `sk-...`, `your-api-key-here`, `https://your-domain.example.com`).

## Metadata Injection

Before writing the final document file, inject YAML frontmatter if configured:

### When to inject

- METADATA_TEMPLATE is present (non-nil, non-empty)
- **AND** the destination is inside `${DOCS_DIR}` (i.e. `${DOCS_DIR}/prds/`)

### Injection procedure

1. Clone METADATA_TEMPLATE
2. Compute and set the following dynamic fields:
   - `title`: extracted from the first `# H1` heading of the generated document
   - `created`: current datetime as ISO 8601 (e.g. `2026-02-23T18:30:29`)
   - `uuid`: newly generated UUID v4 (e.g. `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`)
3. Prepend the populated block as a YAML frontmatter fence at the very top of the document:

```
---
title: "Mobile App Platform Strategy"
created: "2026-02-23T18:30:29"
author: "Your Name"
focus: "Personal"
tags: []
project:
  - name: "Your Project Name"
    uuid: "YOUR-PROJECT-UUID"
status: "Draft"
uuid: "GENERATED-UUID-V4-PER-DOCUMENT"
related: []
---
```

4. Write the combined frontmatter + document body to the output file.

### When METADATA_TEMPLATE is absent

Skip injection and print:
```
ℹ️  No metadata template found in ${TRACKING_FILE}. Skipping metadata injection.
   To enable: add a ## Document Configuration section with a ### Metadata Template block.
```

## Error Handling

- **No tracking file found**: Display error message and suggest `/prometh-init`
- **Content too tactical**: Suggest loading `prometh-spec` skill instead
- **Insufficient strategic context**: Ask for business justification and market impact details
- **File read errors**: Report file access issues and suggest alternatives
- **Directory creation failures**: Report permission or path issues

---

## PRD Template

You are a Product Requirements Document (PRD) specialist. Transform the input content into a comprehensive, well-structured PRD following 2025 industry best practices. Always output in proper PRD format with the following structure:

# [Product/Feature Name] - Product Requirements Document

## Document Information
- **Version**: 1.0
- **Date**: [Current Date]
- **Status**: Draft
- **Type**: [Strategic Planning/Major Feature/Critical Issue Resolution]
- **Priority**: [Critical/High/Medium/Low]
- **Owner**: [Product Owner]
- **Stakeholders**: [Key Stakeholders]

## 1. Executive Summary

### 1.1 Project Overview
[Brief project description and strategic context]

### 1.2 Problem Statement
[Clear articulation of the business problem or opportunity being addressed]

### 1.3 Solution Summary
[High-level solution approach, key benefits, and expected outcomes]

## 2. Purpose & Objectives

### 2.1 Business Objectives
- [Primary business goals and strategic alignment]
- [Secondary business goals and market positioning]

### 2.2 User Objectives
- [Primary user goals and value proposition]
- [Secondary user benefits and experience improvements]

### 2.3 Success Criteria
| Metric | Baseline | Target | Timeline | Measurement Method |
|--------|----------|--------|----------|-------------------|
| [Key Metric 1] | [Current] | [Goal] | [When] | [How measured] |
| [Key Metric 2] | [Current] | [Goal] | [When] | [How measured] |

## 3. Target Audience & Stakeholders

### 3.1 Primary Users
- **User Persona 1**: [Description, needs, pain points, and goals]
- **User Persona 2**: [Description, needs, pain points, and goals]

### 3.2 Secondary Users
- [Secondary user groups, their needs, and interaction patterns]

### 3.3 Key Stakeholders
- **Internal Stakeholders**: [Teams, roles, and interests]
- **External Stakeholders**: [Partners, customers, and concerns]

## 4. Product Features & Requirements

### 4.1 Core Features
| Feature | Priority | Description | Business Value | Acceptance Criteria |
|---------|----------|-------------|----------------|-------------------|
| [Feature 1] | High | [Description] | [Value] | [Criteria] |
| [Feature 2] | Medium | [Description] | [Value] | [Criteria] |

### 4.2 Functional Requirements
- **FR1**: [Detailed functional requirement with specific behaviors]
- **FR2**: [Additional functional requirement with measurable outcomes]

### 4.3 Non-Functional Requirements
- **Performance**: [Response times, throughput, scalability requirements]
- **Security**: [Authentication, authorization, data protection requirements]
- **Reliability**: [Uptime, error handling, recovery requirements]
- **Usability**: [User experience, accessibility, interface requirements]

## 5. User Experience & Design

### 5.1 User Journey
[Step-by-step user flow from problem awareness to goal completion]

### 5.2 Key Interactions
- [Primary user touchpoints and interaction patterns]
- [Secondary interactions and edge case handling]

### 5.3 Design Considerations
- **UI/UX Guidelines**: [Interface principles and design constraints]
- **Accessibility**: [WCAG compliance and inclusive design requirements]
- **Brand Alignment**: [Brand consistency and visual identity requirements]

## 6. Technical Architecture & Implementation

### 6.1 High-Level Architecture
[System design overview, component relationships, and data flow]

### 6.2 Technical Requirements
- **Platform Constraints**: [Technology stack, framework limitations]
- **Integration Requirements**: [API connections, third-party services]
- **Data Requirements**: [Storage, processing, privacy compliance]

### 6.3 Implementation Approach
- [Development methodology and technical strategy]
- [Resource allocation and team coordination]

## 7. Market Analysis & Competitive Landscape

### 7.1 Market Opportunity
- **Market Size**: [Total addressable market and growth potential]
- **Market Trends**: [Industry trends and emerging opportunities]

### 7.2 Competitive Analysis
| Competitor | Strengths | Weaknesses | Our Differentiation |
|------------|-----------|------------|-------------------|
| [Competitor 1] | [Strengths] | [Gaps] | [How we're different] |
| [Competitor 2] | [Strengths] | [Gaps] | [How we're different] |

### 7.3 Positioning Strategy
- [Unique value proposition and market positioning]
- [Competitive advantages and differentiation factors]

## 8. Success Metrics & Analytics

### 8.1 Key Performance Indicators
| KPI | Current State | Target | Timeline | Owner |
|-----|---------------|--------|----------|-------|
| [Business KPI 1] | [Baseline] | [Goal] | [When] | [Who] |
| [User KPI 1] | [Baseline] | [Goal] | [When] | [Who] |

### 8.2 Engagement Metrics
- [User adoption and retention measurements]
- [Feature usage and interaction tracking]

### 8.3 Business Impact Metrics
- [Revenue impact and cost efficiency measures]
- [Market share and competitive positioning metrics]

## 9. Risk Assessment & Mitigation

| Risk Category | Risk | Impact | Probability | Mitigation Strategy | Contingency Plan |
|---------------|------|--------|-------------|-------------------|------------------|
| Technical | [Risk] | High/Med/Low | High/Med/Low | [Prevention] | [Response] |
| Market | [Risk] | High/Med/Low | High/Med/Low | [Prevention] | [Response] |
| Resource | [Risk] | High/Med/Low | High/Med/Low | [Prevention] | [Response] |

## 10. Dependencies & Assumptions

### 10.1 Critical Dependencies
- **Technical Dependencies**: [Infrastructure, tools, external services]
- **Resource Dependencies**: [Team availability, skill requirements]
- **Business Dependencies**: [Budget approval, stakeholder alignment]

### 10.2 Key Assumptions
- [Market assumptions and user behavior predictions]
- [Technical assumptions and capability expectations]
- [Resource assumptions and timeline expectations]

### 10.3 Constraints
- **Budget Constraints**: [Financial limitations and resource allocation]
- **Timeline Constraints**: [Launch deadlines and milestone requirements]
- **Technical Constraints**: [Platform limitations and integration requirements]

## 11. Implementation Roadmap

### 11.1 Development Phases
- **Phase 1 - Foundation**: [Timeline, scope, and key deliverables]
- **Phase 2 - Core Features**: [Timeline, scope, and key deliverables]
- **Phase 3 - Enhancement**: [Timeline, scope, and key deliverables]

### 11.2 Key Milestones
- [Milestone 1]: [Date, deliverables, and success criteria]
- [Milestone 2]: [Date, deliverables, and success criteria]

### 11.3 Launch Strategy
- **Go-to-Market Plan**: [Marketing, sales, and distribution strategy]
- **Rollout Approach**: [Phased launch, user onboarding, support planning]

## 12. Resource Planning & Budget

### 12.1 Team Requirements
- **Development Team**: [Roles, skills, and time allocation]
- **Design Team**: [UI/UX requirements and collaboration needs]
- **Product Team**: [Management, analysis, and coordination needs]

### 12.2 Budget Allocation
| Category | Estimated Cost | Timeline | Notes |
|----------|----------------|----------|-------|
| Development | [Cost] | [Period] | [Details] |
| Design | [Cost] | [Period] | [Details] |
| Infrastructure | [Cost] | [Period] | [Details] |
| Marketing | [Cost] | [Period] | [Details] |

## 13. Communication & Change Management

### 13.1 Stakeholder Communication
- **Internal Updates**: [Frequency, format, and audience]
- **User Communication**: [Announcement strategy and feedback channels]
- **Executive Reporting**: [Status updates and decision points]

### 13.2 Change Management
- **User Adoption Strategy**: [Training, onboarding, and support plans]
- **Process Changes**: [Workflow modifications and team adaptations]
- **Success Monitoring**: [Feedback collection and iteration planning]

## 14. Document Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Author] | Initial PRD creation |

---

**Instructions for transformation:**
- Analyze input content and classify as Strategic Planning, Major Feature, or Critical Issue Resolution
- Extract key business information and map to appropriate PRD sections
- Focus on strategic value, market impact, and cross-functional alignment
- Include comprehensive business case with measurable outcomes
- Ensure all sections are properly formatted with professional tone
- Fill gaps with reasonable assumptions or research-backed insights
- Maintain formal business documentation standards
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

## Output Format

After successful PRD creation:
```
✅ PRD Created Successfully

File: ${DOCS_DIR}/prds/[filename]-prd.md
Type: [Strategic Planning/Major Feature/Critical Issue Resolution]
Date: [Current Date]
Tracking: Added to tracking file inventory

💡 Next Steps:
- Create implementation SPECs: say "Derive a SPEC from ${DOCS_DIR}/prds/[filename]-prd.md" (prometh-spec skill)
- View project status: /prometh-status
```

Start by resolving the documentation directory and tracking file, then process the input according to type (file path, text content, or interactive prompt), validate strategic scope, and generate the comprehensive PRD document using the embedded template in the resolved directory.
