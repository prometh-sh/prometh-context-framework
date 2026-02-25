---
description: Generate technical documentation (README, runbooks, concept docs) with project analysis. Handles README files, operational runbooks, and deep-dive concept documentation. Use this skill when asked to generate a README, create a runbook, write concept documentation, or document the project's technology stack and architecture.
allowed-tools: ["Read", "Write", "LS", "Glob", "MultiEdit", "Grep"]
---

# Technical Documentation Generation Skill

Generate comprehensive technical documentation for DevOps, SRE, and Cloud engineering workflows. This skill analyzes codebases, infrastructure configurations, and system architectures to produce standardized documentation that meets enterprise engineering standards.

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

README and RUNBOOK files are always excluded from both filename patterns and
metadata injection regardless of configuration.

## Usage

This skill is invoked naturally in conversation — there is no `/prometh-doc` slash command.

**How to invoke:**
- *"Generate a README for this project"* → readme type (produces README.md + docs/getting-started.md + CONTRIBUTING.md)
- *"Write an operational runbook"* → runbook type
- *"Write concept documentation for new team members"* → concept type
- *"Generate documentation"* → triggers interactive type selection menu

**Options** (include in your request):
- `--include-risks` — add risk assessment sections
- `--scope [service|environment|full-stack]` — documentation scope
- `--output [path]` — specify custom output path

## Document Types

1. **README Documentation** (`readme`)
   - Produces **three commit-ready files** in one operation:
     - `README.md` — lean landing page (5-min read): value prop, demo, quick install, links
     - `docs/getting-started.md` — full guided walkthrough (tutorial)
     - `CONTRIBUTING.md` — contribution guidelines, dev setup, PR process
   - These files go to the **project root / `docs/`** — NOT to `${DOCS_DIR}`.
     No metadata injection, no filename patterns applied.
   - Templates: `prometh-doc-readme`, `prometh-doc-readme-getting-started`, `prometh-doc-readme-contributing`

2. **Runbook Documentation** (`runbook`)
   - Operational procedures, monitoring, incident response, recovery
   - Saved to: Project root or `docs/` directory
   - Template: `prometh-doc-runbook` output style

3. **Concept Documentation** (`concept`)
   - Deep-dive documentation: technology stack, architecture, domain concepts
   - Comprehensive onboarding guide for new team members
   - Saved to: `${DOCS_DIR}/concepts/[concept-name].md` (filename governed by `concept_pattern` — see Filename Generation)
   - Template: `prometh-doc-concept` output style
   - Metadata: YAML frontmatter injected if METADATA_TEMPLATE is configured (see Metadata Injection)

## Processing Logic

### Step 1: Type Classification
- Check if documentation type is provided as argument or in conversation
- **If type is NOT provided**, present interactive menu:

```
📚 Documentation Type Selection

What type of documentation would you like to generate?

1. README - Project landing page + companion docs
   • README.md: lean overview, demo, quick install, links (5-min read)
   • docs/getting-started.md: full guided walkthrough (tutorial)
   • CONTRIBUTING.md: dev setup, PR process, coding standards
   • All saved to project root / docs/ — ready to commit

2. Runbook - Operational procedures
   • Monitoring, troubleshooting, and incident response
   • Deployment and recovery procedures
   • Saved to: project root or docs/

3. Concept - Deep-dive technical documentation
   • Technology stack, architecture, and domain concepts
   • Comprehensive onboarding guide for new team members
   • Design decisions (ADRs) and technical reference
   • Saved to: ${DOCS_DIR}/concepts/

Please select a documentation type (1-3):
```

### Step 2: Repository Analysis
Scan project structure and configuration files based on selected type.

### Step 3: Template Application
Apply the appropriate output style:
- `prometh-doc-readme` for README
- `prometh-doc-runbook` for Runbook
- `prometh-doc-concept` for Concept documentation

### Step 4: Content Generation
Create comprehensive documentation following the selected template.

### Step 5: File Management
Handle existing files gracefully (create backups or review copies as needed).

## README Generation

When generating README documentation, produce **three files** in one operation.

### Repository Analysis
- **Project Type Detection**: Examine codebase to determine project characteristics
- **Configuration Analysis**: Extract info from package.json, requirements.txt, Cargo.toml, go.mod, etc.
- **Dependency Detection**: Identify frameworks, libraries, and tools used
- **Structure Analysis**: Understand project organization and architecture

### File 1: README.md (project root)
Apply the `prometh-doc-readme` output style. This is the **landing page** — lean, scannable,
≤300 lines. It links to `docs/getting-started.md` and `CONTRIBUTING.md` for detail.

### File 2: docs/getting-started.md
Apply the `prometh-doc-readme-getting-started` output style. This is the **full tutorial**:
step-by-step walkthrough from install through first real usage. Create `docs/` directory if needed.

### File 3: CONTRIBUTING.md (project root)
Apply the `prometh-doc-readme-contributing` output style. This is the **contributor guide**:
dev environment setup, branch strategy, commit format, PR process, code quality.
GitHub auto-links this file in the repository UI.

### Important constraints
- These files go to **project root** (`README.md`, `CONTRIBUTING.md`) or **`docs/`** (`getting-started.md`)
- They are **NOT** stored in `${DOCS_DIR}` — they are project source files, not Prometh-tracked docs
- No metadata injection, no filename patterns — names are always fixed
- No tracking file entry for these files

### Smart File Handling
- **Existing README**: If README.md exists, create README-new.md for review; same for CONTRIBUTING.md
- **Existing docs/getting-started.md**: Create docs/getting-started-new.md for review
- **Backup Creation**: Preserve existing documentation before updates

## Runbook Generation

When generating Runbook documentation:

### System Analysis
- **Infrastructure Detection**: Identify deployment platforms, databases, services
- **Configuration Analysis**: Extract operational settings and environment variables
- **Monitoring Setup**: Identify logging, metrics, and alerting configurations
- **Dependency Mapping**: Understand service relationships and external dependencies

### Template Application
Apply the `prometh-doc-runbook` output style:
```
Please create operational runbook documentation using the 'prometh-doc-runbook' output style based on this system analysis:

[system architecture and operational analysis results]
```

## Concept Documentation Generation

When generating Concept documentation:

### Analysis Requirements

**Technology Stack Analysis**:
- Identify all languages, frameworks, and major libraries
- Document versions and compatibility requirements
- Explain technology choices and rationale
- Detail configuration approaches

**Architecture Analysis**:
- Identify system architecture pattern (monolith, microservices, serverless, etc.)
- Map components and their responsibilities
- Document data flow and component interactions
- Identify design patterns in use
- Extract architectural decision records (ADRs) if present

**Domain Concept Extraction**:
- Read business logic code to identify core domain entities
- Extract entity relationships from data models
- Document business workflows and rules
- Build domain terminology glossary

**Onboarding Information**:
- Document prerequisites (required knowledge, tools)
- Extract setup instructions from README, scripts, or infer
- Describe typical development workflow
- Identify key files new developers should read first

### Template Application
Apply the `prometh-doc-concept` output style:
```
Please create comprehensive concept documentation using the 'prometh-doc-concept' output style based on this project analysis:

[detailed project analysis including technologies, architecture, domain concepts, and onboarding information]
```

### Content Generation Process
1. Read dependency files (package.json, requirements.txt, go.mod, etc.)
2. Explore codebase structure with Glob
3. Identify main entry points and core modules
4. Read key source files to understand patterns
5. Extract configuration from config files
6. Document based on actual code, not assumptions
7. Replace all [placeholders] with project-specific information
8. Remove irrelevant sections for the project type
9. Add ASCII diagrams where helpful for architecture
10. Reference specific files with clickable links

### File Output
- **Default Location**: `${DOCS_DIR}/concepts/[concept-name].md` (filename governed by `concept_pattern` — see Filename Generation)
- **Custom Output**: `--output` flag to specify custom path
- **Naming Convention**: Use kebab-case for concept names
- **Directory Creation**: Creates `concepts/` subdirectory if it doesn't exist
- **Metadata**: Inject YAML frontmatter if METADATA_TEMPLATE is configured (see Metadata Injection)


## Tracking File Management

After successfully generating documentation, update the tracking file:

### Documentation Entry Format
Add new entry to the Technical Documentation table:
```
| [Type] | [filename] | [Current Date] | [Brief Description] | [Current Date] |
```

**Type Options:** README, Runbook, Concept, Architecture, API, Deployment

### Recent Activity Update
```
- **[Current Date]**: Generated [Type] documentation - [filename] ([Brief Description])
```

Update the "Last Updated" timestamp.

**Sensitive Data Protection**: When generating documents, **never** include:
- API keys, secrets, tokens, passwords, or credentials
- Environment variable **values** (reference names only, e.g. `$DATABASE_URL`)
- Private hostnames, IP addresses, or internal URLs
- PII (personal emails, account IDs, private names)
- Database connection strings or `.env` file contents
- Absolute file paths or user home directories

Use placeholder values where examples are needed (e.g. `sk-...`, `your-api-key-here`, `https://your-domain.example.com`).

**Error Handling for Tracking**: If tracking file is unwriteable, warn but never block documentation creation.

## Filename Generation (Concept docs only)

README and RUNBOOK filenames are always fixed. Only Concept docs use this logic.

### Name Slug Rules (apply in all cases)

Extract a meaningful slug from the document title or topic:
- Convert to lowercase and replace spaces with hyphens
- Remove common stop-words (the, a, an, for, to, with, of, and, or, in, on, at, etc.)
- Keep 2–5 key descriptive words that capture the concept topic
- Result: `{NAME}` token (e.g. `architecture-overview`, `authentication-flow`)

### Configured Pattern (when FILENAME_CONFIG is present)

Read `concept_pattern` from FILENAME_CONFIG and substitute tokens:

| Token | Value |
|-------|-------|
| `{DATE}` | Current date as `YYYYMMDD` (e.g. `20260223`) |
| `{DATETIME}` | Current datetime as `YYYYMMDDHHMM` (e.g. `202602231830`) |
| `{NAME}` | Slugified document name (see rules above) |

**Default configured pattern:** `{DATETIME}-{NAME}.md`

Examples with default pattern:
- "Architecture Overview" → `202602231830-architecture-overview.md`
- "Authentication Flow" → `202602231830-authentication-flow.md`
- "Database Schema Design" → `202602231830-database-schema-design.md`

### Legacy Fallback (when FILENAME_CONFIG is absent)

If no `## Document Configuration` section or `concept_pattern` key is found:
- Format: `[project-name]-concept.md` (plain kebab-case name, no date prefix)

Print an info message when falling back:
```
ℹ️  No filename configuration found in ${TRACKING_FILE}. Using legacy filename format.
   To configure: add a ## Document Configuration section with a ### Filename Patterns block.
```

## Metadata Injection (Concept docs only)

README and RUNBOOK files are always excluded. Only documents written inside
`${DOCS_DIR}/concepts/` receive metadata injection.

### When to inject

- METADATA_TEMPLATE is present (non-nil, non-empty)
- **AND** the destination is `${DOCS_DIR}/concepts/`

### Injection procedure

1. Clone METADATA_TEMPLATE
2. Compute and set the following dynamic fields:
   - `title`: extracted from the first `# H1` heading of the generated document
   - `created`: current datetime as ISO 8601 (e.g. `2026-02-23T18:30:29`)
   - `uuid`: newly generated UUID v4 (e.g. `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`)
3. Prepend the populated block as a YAML frontmatter fence at the very top of the document:

```
---
title: "Architecture Overview"
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

Skip injection for README/RUNBOOK silently. For Concept docs, print:
```
ℹ️  No metadata template found in ${TRACKING_FILE}. Skipping metadata injection.
   To enable: add a ## Document Configuration section with a ### Metadata Template block.
```

## Error Handling

- **No tracking file found**: Display error and suggest `/prometh-init`
- **Invalid documentation type**: Suggest valid types (readme/runbook/concept)
- **Repository analysis failures**: Report analysis issues and suggest manual input
- **File access errors**: Report permission or path issues
- **Template application failures**: Provide fallback options

## Output Format

After successful documentation creation, report varies by type:

**README type** (3 files created):
```
✅ Documentation Created Successfully

Type: README (landing page + companion docs)
Files:
  README.md              → project root (landing page)
  docs/getting-started.md → full tutorial walkthrough
  CONTRIBUTING.md        → contributor guide (GitHub auto-linked)
Date: [Current Date]

These files are ready to commit. No tracking file entry added.
```

**Runbook / Concept type** (1 file created):
```
✅ Documentation Created Successfully

Type: [Runbook/Concept]
File: [output-file-path]
Template: [prometh-doc-runbook/prometh-doc-concept]
Date: [Current Date]
Tracking: Added to tracking file inventory

The documentation has been generated and is ready for review.
```

Start by resolving the documentation directory and tracking file. If no documentation type is provided, present the interactive menu. Once type is determined, analyze the project structure, apply the appropriate output style (`prometh-doc-readme`, `prometh-doc-runbook`, or `prometh-doc-concept`), and generate comprehensive documentation.
