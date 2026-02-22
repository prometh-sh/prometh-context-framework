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

## Usage

```bash
/prometh-doc [type] [options]
```

**Note**: If `[type]` is not provided, present an interactive menu to select the documentation type.

## Document Types

1. **README Documentation** (`readme`)
   - Comprehensive project overview, quick start, installation, usage
   - Saved to: Project root as `README.md`
   - Template: `prometh-doc-readme` output style

2. **Runbook Documentation** (`runbook`)
   - Operational procedures, monitoring, incident response, recovery
   - Saved to: Project root or `docs/` directory
   - Template: `prometh-doc-runbook` output style

3. **Concept Documentation** (`concept`)
   - Deep-dive documentation: technology stack, architecture, domain concepts
   - Comprehensive onboarding guide for new team members
   - Saved to: `${DOCS_DIR}/concepts/[concept-name].md`
   - Template: `prometh-doc-concept` output style

## Processing Logic

### Step 1: Type Classification
- Check if documentation type is provided as argument or in conversation
- **If type is NOT provided**, present interactive menu:

```
📚 Documentation Type Selection

What type of documentation would you like to generate?

1. README - High-level project overview
   • Quick start guide and installation instructions
   • Features and basic usage examples
   • Saved to: README.md (project root)

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

When generating README documentation:

### Repository Analysis
- **Project Type Detection**: Examine codebase to determine project characteristics
- **Configuration Analysis**: Extract info from package.json, requirements.txt, Cargo.toml, go.mod, etc.
- **Dependency Detection**: Identify frameworks, libraries, and tools used
- **Structure Analysis**: Understand project organization and architecture

### Template Application
Apply the `prometh-doc-readme` output style:
```
Please create comprehensive README documentation using the 'prometh-doc-readme' output style based on this repository analysis:

[repository structure and analysis results]
```

### Smart File Handling
- **Existing README**: If README.md exists, create README-new.md for review
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
- **Default Location**: `${DOCS_DIR}/concepts/[project-name]-concept.md`
- **Custom Output**: `--output` flag to specify custom path
- **Naming Convention**: Use kebab-case for concept names
- **Directory Creation**: Creates `concepts/` subdirectory if it doesn't exist

## Command Options

- `--include-risks` — Add risk assessment sections
- `--scope [service|environment|full-stack]` — Documentation scope
- `--output [path]` — Specify custom output file or directory

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

**Privacy Note**: Use relative paths, never absolute paths or user directories.

**Error Handling for Tracking**: If tracking file is unwriteable, warn but never block documentation creation.

## Error Handling

- **No tracking file found**: Display error and suggest `/prometh-init`
- **Invalid documentation type**: Suggest valid types (readme/runbook/concept)
- **Repository analysis failures**: Report analysis issues and suggest manual input
- **File access errors**: Report permission or path issues
- **Template application failures**: Provide fallback options

## Output Format

After successful documentation creation:
```
✅ Documentation Created Successfully

Type: [README/Runbook/Concept]
File: [output-file-path]
Template: [prometh-doc-readme/prometh-doc-runbook/prometh-doc-concept]
Date: [Current Date]
Tracking: Added to tracking file inventory

The documentation has been generated and is ready for review.
```

Start by resolving the documentation directory and tracking file. If no documentation type is provided, present the interactive menu. Once type is determined, analyze the project structure, apply the appropriate output style (`prometh-doc-readme`, `prometh-doc-runbook`, or `prometh-doc-concept`), and generate comprehensive documentation.
