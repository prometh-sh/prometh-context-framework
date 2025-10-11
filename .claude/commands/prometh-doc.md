---
description: Generate technical documentation (README, runbooks) with CLAUDE.md validation
argument-hint: "[type] [options] [path]"
allowed-tools: ["Read", "Glob", "Grep", "LS", "Bash", "WebFetch"]
---

# /prometh-doc Command

Generate comprehensive technical documentation for DevOps, SRE, and Cloud engineering workflows. This command analyzes codebases, infrastructure configurations, and system architectures to produce standardized documentation that meets enterprise engineering standards.

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

## Usage

```bash
/prometh-doc [type] [options] [path]
```

## Document Types

- `readme` - Generate comprehensive README.md files for repositories
- `runbook` - Operational procedures and incident response documentation

## Available Output Styles

- **prometh-doc-readme**: Unified README template for comprehensive project documentation
- **prometh-doc-runbook**: Specialized runbook template for operational procedures and troubleshooting

## Command Options

- `--format` - Output format (markdown, confluence, notion)
- `--template` - Use predefined documentation templates
- `--include-risks` - Generate risk assessment sections
- `--scope` - Documentation scope (service, environment, full-stack)
- `--output` - Specify output file or directory

## Processing Logic

### Input Handling
1. **CLAUDE.md Validation**: Verify configuration file exists (mandatory)
2. **Type Classification**: Determine documentation type (readme/runbook)
3. **Repository Analysis**: Scan project structure and configuration files
4. **Template Application**: Apply appropriate output style
5. **Content Generation**: Create comprehensive documentation
6. **File Management**: Handle existing files and create backups

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

## PROMETH.md Tracking

After successfully generating documentation, update the project tracking file:

### 1. Check PROMETH.md Existence
```bash
# Check if PROMETH.md exists in project root
ls PROMETH.md 2>/dev/null
```

### 2. Update PROMETH.md Content

**If PROMETH.md exists:**
- Read current content
- Update the technical documentation section
- Update the recent activity section
- Maintain chronological order

**If PROMETH.md doesn't exist:**
- Display suggestion: "Run `/prometh-init` to initialize project tracking"
- Continue with documentation creation (don't block the process)

### 3. Documentation Entry Format

Add new entry to the technical documentation table:
```
| [Type] | [filename] | [Current Date] | [Brief Description] | [Current Date] |
```

**Type Options:**
- `README` - Project overview and setup documentation
- `Runbook` - Operational procedures and troubleshooting guides
- `Architecture` - System design and component documentation
- `API` - API documentation and endpoint guides
- `Deployment` - Deployment procedures and configuration guides

### 4. Recent Activity Update

Add entry to recent activity section:
```
- **[Current Date]**: Generated [Type] documentation - [filename] ([Brief Description])
```

### 5. Update Timestamps

Update the "Last Updated" timestamp at the top of PROMETH.md:
```
*Last Updated: [Current Date and Time]*
```

### 6. PROMETH.md Update Process

**Privacy Note**: When updating PROMETH.md, ensure no private information is exposed:
- Use relative paths (docs/filename.md) not absolute paths
- Never include user directories or private file paths
- Keep all content shareable with team members

**Implementation Steps:**
1. Read existing PROMETH.md (if exists)
2. Parse technical documentation table
3. Add new documentation entry with filename, type, and description
4. Update recent activity section
5. Update last modified timestamp
6. Write updated content back to PROMETH.md
7. Handle any write errors gracefully

**Error Handling:**
- If PROMETH.md is locked or unwriteable, continue with documentation creation but warn user
- If parsing fails, suggest running `/prometh-init` to reset tracking file
- Never block documentation creation due to tracking file issues

## Instructions

1. **Always validate PROMETH.md existence first** - Exit with error if not found
2. **Analyze repository structure thoroughly** - Understand project characteristics before generation
3. **Apply appropriate template** - Use correct output style based on documentation type
4. **Generate practical content** - Focus on actionable information and real examples
5. **Handle existing files safely** - Create backups and avoid overwriting important content
6. **Include risk assessments** - Add mandatory risk sections for operational documentation
7. **Update PROMETH.md tracking** - Add documentation to project inventory and activity log
8. **Report completion** - Confirm successful documentation creation with file location

## Error Handling

- **No PROMETH.md found**: Display error message and exit immediately
- **Invalid documentation type**: Suggest valid types (readme/runbook)
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

### 1. Generate README for New Repository
```bash
/prometh-doc readme
# Analyzes current repository and generates comprehensive README.md
```

### 2. Create Operational Runbook
```bash
/prometh-doc runbook
# Analyzes system configuration and generates operational procedures
```

### 3. Update Existing Documentation
```bash
/prometh-doc readme --output README-updated.md
# Creates updated README while preserving original
```

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

Start by validating CLAUDE.md existence, then analyze the specified path (or current directory), determine the appropriate documentation type and template, and generate comprehensive technical documentation following enterprise standards.