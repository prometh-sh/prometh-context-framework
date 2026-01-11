---
description: Generate technical documentation (README, runbooks, concept docs) with CLAUDE.md validation
argument-hint: "[type] [options] [concept_name]"
allowed-tools: ["Read", "Glob", "Grep", "LS", "Bash", "WebFetch"]
---

# /prometh-doc Command

Generate comprehensive technical documentation for DevOps, SRE, and Cloud engineering workflows. This command analyzes codebases, infrastructure configurations, and system architectures to produce standardized documentation that meets enterprise engineering standards.

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
/prometh-doc [type] [options] [path]
```

**Note**: If `[type]` is not provided, an interactive menu will prompt you to select the documentation type.

**Examples:**
```bash
/prometh-doc                    # Interactive menu prompts for type selection
/prometh-doc readme             # Generate README directly
/prometh-doc concept            # Generate concept documentation directly
```

## Document Types

1. **README Documentation** (`readme`)
   - Generate comprehensive README.md files for repositories
   - Provides high-level project overview, quick start, installation
   - Saved to: Project root as `README.md`

2. **Runbook Documentation** (`runbook`)
   - Operational procedures and incident response documentation
   - Includes monitoring, troubleshooting, and recovery procedures
   - Saved to: Project root or `docs/` directory

3. **Concept Documentation** (`concept`)
   - Comprehensive deep-dive documentation on project technologies, architecture, and domain concepts
   - Complements README.md with detailed technical understanding
   - Saved to: `${DOCS_DIR}/concepts/[concept-name].md`
   - Template: Uses `prometh-doc-concept` output style
   - Use cases:
     - New team member onboarding
     - Technology stack documentation with rationale
     - Architecture and design decision records
     - Domain concept and business logic documentation
     - Detailed technical reference

## Available Output Styles

- **prometh-doc-readme**: Unified README template for comprehensive project documentation
- **prometh-doc-runbook**: Specialized runbook template for operational procedures and troubleshooting
- **prometh-doc-concept**: Comprehensive concept documentation template
  - Technology deep-dive (languages, frameworks, tools, configuration)
  - Architecture & design decisions (system design, patterns, ADRs)
  - Domain concepts & business logic (entities, workflows, terminology)
  - Getting started guide (onboarding, setup, development workflow)
  - Configuration & data management
  - Integration points and security

## Command Options

- `--format` - Output format (markdown, confluence, notion)
- `--template` - Use predefined documentation templates
- `--include-risks` - Generate risk assessment sections
- `--scope` - Documentation scope (service, environment, full-stack)
- `--output` - Specify output file or directory

## Processing Logic

### Input Handling

**Step 1: CLAUDE.md Validation**
- Verify configuration file exists (mandatory)
- Exit with error if neither CLAUDE.md nor CLAUDE.local.md found

**Step 2: Type Classification**
- Check if documentation type is provided as argument
- **If type is NOT provided**, use interactive menu to prompt user:

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
   • Saved to: prometh-docs/concepts/

Please select a documentation type (1-3):
```

**Step 3: Repository Analysis**
- Scan project structure and configuration files based on selected type

**Step 4: Template Application**
- Apply appropriate output style (prometh-doc-readme, prometh-doc-runbook, or prometh-doc-concept)

**Step 5: Content Generation**
- Create comprehensive documentation following template

**Step 6: File Management**
- Handle existing files and create backups if needed

## README Generation

When using `/prometh-doc readme`, the command will:

### 1. Repository Analysis
- **Project Type Detection**: Examine codebase to determine project characteristics
- **Configuration Analysis**: Extract info from package.json, requirements.txt, Cargo.toml, etc.
- **Dependency Detection**: Identify frameworks, libraries, and tools used
- **Structure Analysis**: Understand project organization and architecture

### 2. Auto-Template Selection
Apply the **prometh-doc-readme** output style which includes:
- **Project Description**: Generated from repository analysis and existing docs
- **Feature Documentation**: Extracted from code structure and existing documentation
- **Installation Instructions**: Based on detected package managers and build tools
- **Usage Examples**: Generated from existing code examples and tests
- **Configuration Options**: Extracted from config files and environment variables
- **API Documentation**: Generated from code analysis if applicable
- **Contributing Guidelines**: Standard practices with project-specific adaptations
- **License Information**: Extracted from LICENSE file

### 3. Content Generation Process
```
Please create comprehensive README documentation using the 'prometh-doc-readme' output style based on this repository analysis:

[repository structure and analysis results]
```

### 4. Smart File Handling
- **Existing README**: If README.md exists, create README-new.md for review
- **Backup Creation**: Preserve existing documentation before updates
- **Merge Considerations**: Identify sections that should be preserved

### README Examples:
```bash
/prometh-doc readme                    # Auto-analyze current directory
/prometh-doc readme --output README-updated.md   # Specify output file
/prometh-doc readme /path/to/project   # Analyze specific project path
```

## Runbook Generation

When using `/prometh-doc runbook`, the command will:

### 1. System Analysis
- **Infrastructure Detection**: Identify deployment platforms, databases, services
- **Configuration Analysis**: Extract operational settings and environment variables
- **Monitoring Setup**: Identify logging, metrics, and alerting configurations
- **Dependency Mapping**: Understand service relationships and external dependencies

### 2. Template Application
Apply the **prometh-doc-runbook** output style which includes:
- **System Architecture**: High-level component relationships and data flow
- **Operational Procedures**: Deployment, maintenance, and routine operations
- **Monitoring & Alerting**: Key metrics, thresholds, and response procedures
- **Incident Response**: Troubleshooting guides and escalation procedures
- **Recovery Procedures**: Backup, restore, and disaster recovery processes
- **Security Procedures**: Access management and incident response

### 3. Content Generation Process
```
Please create operational runbook documentation using the 'prometh-doc-runbook' output style based on this system analysis:

[system architecture and operational analysis results]
```

### Runbook Examples:
```bash
/prometh-doc runbook                   # Generate runbook for current system
/prometh-doc runbook --scope service   # Focus on specific service
/prometh-doc runbook --include-risks   # Include comprehensive risk assessment
```

## Concept Documentation Generation

When using `/prometh-doc concept`, the command will:

### 1. Concept Documentation Analysis

Generate comprehensive concept documentation that provides deep technical understanding.

**Concept Documentation Analysis Requirements:**

**Technology Stack Analysis**:
- Identify all languages, frameworks, and major libraries
- Document versions and compatibility requirements
- Explain technology choices and rationale (from comments, docs, or infer)
- Detail configuration approaches
- List key features being used

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
- Identify key business processes

**Onboarding Information**:
- Document prerequisites (required knowledge, tools)
- Extract setup instructions from README, scripts, or infer
- Describe typical development workflow
- Identify key files new developers should read first
- Document coding standards and conventions

**Codebase Organization**:
- Map directory structure and purpose
- Document code organization patterns
- Explain naming conventions
- Describe module/package structure

### 2. Template Application Process

1. Use `prometh-doc-concept` output style as template
2. Analyze project using requirements above
3. Replace all [placeholders] with project-specific information
4. Remove irrelevant sections (e.g., if no external APIs, remove that section)
5. Expand complex sections with additional detail
6. Add ASCII diagrams where helpful for architecture
7. Include code examples from actual codebase
8. Reference specific files with clickable links ([file.ts:42](src/file.ts#L42))

### 3. Content Generation Process

1. Read dependency files (package.json, requirements.txt, go.mod, etc.)
2. Explore codebase structure with Glob
3. Identify main entry points and core modules
4. Read key source files to understand patterns
5. Extract configuration from config files
6. Document based on actual code, not assumptions
7. Create comprehensive but accessible content
8. Tailor to project's specific domain and complexity

**Generation Prompt Example:**
```
Please create comprehensive concept documentation using the 'prometh-doc-concept' output style based on this project analysis:

[detailed project analysis including technologies, architecture, domain concepts, and onboarding information]
```

### 4. File Output

- **Default Location**: `${DOCS_DIR}/concepts/[project-name]-concept.md`
- **Custom Output**: `--output` flag to specify custom path
- **Naming Convention**: Use kebab-case for concept names
- **Directory Creation**: Creates `concepts/` subdirectory if doesn't exist

### 5. Tracking Integration

- **Type**: `Concept`
- **Description Format**: "[Brief concept description] - Technologies, architecture, and domain concepts"
- **File Path**: Relative to project root (e.g., `${DOCS_DIR}/concepts/project-concept.md`)

### Concept Examples:

```bash
# Generate concept documentation for current project
/prometh-doc concept

# Generate concept documentation with custom name
/prometh-doc concept --output concepts/backend-architecture.md

# Generate concept documentation for specific subsystem
/prometh-doc concept --scope service --output concepts/auth-service-concept.md
```

**Example Output:**
```
✓ Analyzing project structure and technologies...
✓ Extracting architecture and design patterns...
✓ Documenting domain concepts and business logic...
✓ Creating onboarding information...
✓ Concept documentation generated: prometh-docs/concepts/project-name-concept.md
✓ Tracking file updated: PROMETH.md

Concept documentation created successfully!

Next steps:
- Review the generated documentation for accuracy
- Add project-specific examples or diagrams
- Share with team members for feedback
- Update as project evolves
```

## Technical Capabilities

When executing this command, analyze and document:

### Repository Analysis
- **File Format Support**: Parse YAML, JSON, HCL (Terraform), Dockerfile, Kubernetes manifests
- **Dependency Extraction**: Extract service dependencies and data flow patterns
- **Security Configuration**: Identify security configurations and access controls
- **Code Analysis**: Generate examples from existing code and test files

### Infrastructure Analysis
- **Platform Detection**: Recognize common DevOps toolchains (Terraform, Kubernetes, Docker, Jenkins)
- **Cloud Provider Support**: Identify configurations for AWS, GCP, Azure
- **Monitoring Integration**: Parse monitoring and observability setups
- **Network Analysis**: Understand service communication and API patterns

## Output Standards

### Documentation Quality
- **Professional Formatting**: Clean markdown syntax without decorative elements
- **Consistent Structure**: Logical heading hierarchy and section organization
- **Actionable Content**: Include practical examples and implementation guidance
- **Cross-References**: Provide linking between related sections and external resources

### Risk Assessment Requirements
For runbook documentation, include mandatory risk assessment sections:

#### Critical Risks to Monitor
- **Sensitive Data Exposure**: Detect and sanitize secrets, API keys, or confidential configuration details
- **Security Misconfiguration Documentation**: Highlight security implications of documented configurations
- **Incomplete Context Analysis**: Validate critical dependencies and infrastructure components

#### Operational Risks
- **Documentation Drift**: Implement refresh mechanisms for infrastructure changes
- **Procedure Accuracy**: Ensure operational procedures are tested and validated
- **Access Control**: Document proper authentication and authorization procedures

## ${TRACKING_FILE} Tracking

After successfully generating documentation, update the project tracking file:

### 1. Check ${TRACKING_FILE} Existence
```bash
# Check if ${TRACKING_FILE} exists in project root
ls ${TRACKING_FILE} 2>/dev/null
```

### 2. Update ${TRACKING_FILE} Content

**If ${TRACKING_FILE} exists:**
- Read current content
- Update the technical documentation section
- Update the recent activity section
- Maintain chronological order

**If ${TRACKING_FILE} doesn't exist:**
- Display suggestion: "Run `/prometh-init` to initialize project tracking"
- Continue with documentation creation (don't block the process)

### 3. Documentation Entry Format

Add new entry to the technical documentation table:
```
| [Type] | [filename] | [Current Date] | [Brief Description] | [Current Date] |
```

**Type Options:**
- `README` - Project overview and setup documentation (saved to root)
- `Runbook` - Operational procedures and troubleshooting guides (saved to root or docs/)
- `Architecture` - System design and component documentation (saved to docs/)
- `API` - API documentation and endpoint guides (saved to docs/)
- `Deployment` - Deployment procedures and configuration guides (saved to docs/)
- `Concept` - Comprehensive technology, architecture, and domain documentation (saved to prometh-docs/concepts/)

### 4. Recent Activity Update

Add entry to recent activity section:
```
- **[Current Date]**: Generated [Type] documentation - [filename] ([Brief Description])
```

### 5. Update Timestamps

Update the "Last Updated" timestamp at the top of ${TRACKING_FILE}:
```
*Last Updated: [Current Date and Time]*
```

### 6. ${TRACKING_FILE} Update Process

**Privacy Note**: When updating ${TRACKING_FILE}, ensure no private information is exposed:
- Use relative paths (${DOCS_DIR}/filename.md) not absolute paths
- Never include user directories or private file paths
- Keep all content shareable with team members

**Implementation Steps:**
1. Read existing ${TRACKING_FILE} (if exists)
2. Parse technical documentation table
3. Add new documentation entry with filename, type, and description
4. Update recent activity section
5. Update last modified timestamp
6. Write updated content back to ${TRACKING_FILE}
7. Handle any write errors gracefully

**Error Handling:**
- If ${TRACKING_FILE} is locked or unwriteable, continue with documentation creation but warn user
- If parsing fails, suggest running `/prometh-init` to reset tracking file
- Never block documentation creation due to tracking file issues

## Instructions

1. **Always validate ${TRACKING_FILE} existence first** - Exit with error if not found
2. **Check for documentation type argument** - If not provided, display interactive menu and ask user to select type (README/Runbook/Concept)
3. **Analyze repository structure thoroughly** - Understand project characteristics before generation
4. **Apply appropriate template** - Use correct output style based on documentation type
5. **Generate practical content** - Focus on actionable information and real examples
6. **Handle existing files safely** - Create backups and avoid overwriting important content
7. **Include risk assessments** - Add mandatory risk sections for operational documentation
8. **Update ${TRACKING_FILE} tracking** - Add documentation to project inventory and activity log
9. **Report completion** - Confirm successful documentation creation with file location

## Error Handling

- **No ${TRACKING_FILE} found**: Display error message and exit immediately
- **Invalid documentation type**: Suggest valid types (readme/runbook/concept)
- **Repository analysis failures**: Report analysis issues and suggest manual input
- **File access errors**: Report permission or path issues
- **Template application failures**: Provide fallback options and troubleshooting guidance

## Output Format

After successful documentation creation:
```
✅ Documentation Created Successfully

Type: [README/Runbook]
File: [output-file-path]
Template: [prometh-doc-readme/prometh-doc-runbook]
Analysis: [Project type/System type detected]
Date: [Current Date]

The documentation has been generated and is ready for review.
```

## Example Usage Scenarios

### 1. Interactive Type Selection (No Type Provided)
```bash
/prometh-doc
```

**User Experience:**
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
   • Saved to: prometh-docs/concepts/

Please select a documentation type (1-3): _
```

User selects option (e.g., `3` for Concept), then command proceeds with generation.

### 2. Generate README for New Repository
```bash
/prometh-doc readme
# Analyzes current repository and generates comprehensive README.md
```

### 3. Create Operational Runbook
```bash
/prometh-doc runbook
# Analyzes system configuration and generates operational procedures
```

### 4. Update Existing Documentation
```bash
/prometh-doc readme --output README-updated.md
# Creates updated README while preserving original
```

### 5. Generate Concept Documentation

```bash
/prometh-doc concept
```

**What happens:**
1. Analyzes project structure, dependencies, and codebase
2. Extracts technology stack, architecture, and domain concepts
3. Creates comprehensive concept documentation
4. Saves to `prometh-docs/concepts/[project-name]-concept.md`
5. Updates `PROMETH.md` tracking file:
   - Adds entry to Technical Documentation table
   - Logs to Recent Activity
   - Updates timestamp

**Generated file structure:**
- Technology Stack (languages, frameworks, tools, rationale)
- System Architecture (components, data flow, patterns, ADRs)
- Domain Concepts (entities, workflows, terminology)
- Project Structure (organization, conventions, standards)
- Getting Started (prerequisites, setup, workflow)
- Configuration & Environment
- Integration Points
- Security & Performance
- Learning Resources

## File System Analysis Capabilities

- **Project Structure Scanning**: Identify configuration files, source code organization, and documentation
- **Dependency Analysis**: Extract dependencies from package managers and configuration files
- **Build System Detection**: Identify build tools, CI/CD configurations, and deployment scripts
- **Documentation Mining**: Extract existing documentation and code comments for context

## Context Awareness Features

- **Technology Stack Detection**: Automatically identify languages, frameworks, and tools
- **Architecture Pattern Recognition**: Understand common patterns (microservices, monolith, serverless)
- **Deployment Environment Analysis**: Identify containerization, orchestration, and cloud deployment
- **Integration Point Mapping**: Document API endpoints, database connections, and service dependencies

## Execution Flow

1. **Validate CLAUDE.md**: Check for CLAUDE.md or CLAUDE.local.md existence
2. **Check for Type Argument**:
   - If type argument is provided (`readme`, `runbook`, or `concept`), proceed with that type
   - If NO type argument is provided, display the interactive menu and wait for user selection
3. **Resolve Directories**: Determine DOCS_DIR and TRACKING_FILE using priority rules
4. **Analyze Project**: Scan codebase, configuration files, and project structure
5. **Apply Template**: Use appropriate output style based on selected/provided type
6. **Generate Documentation**: Create comprehensive documentation
7. **Update Tracking**: Add entry to PROMETH.md or PROMETH.local.md
8. **Report Success**: Display completion message with file location

Start by validating CLAUDE.md existence. If no documentation type is provided as an argument, present the interactive menu to the user. Once type is determined (either from argument or user selection), analyze the specified path (or current directory), apply the appropriate template, and generate comprehensive technical documentation following enterprise standards.