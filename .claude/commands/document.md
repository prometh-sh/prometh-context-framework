---
description: Generate comprehensive technical documentation for DevOps, SRE, and Cloud engineering workflows
argument-hint: "[type] [options] [path]"
allowed-tools: ["Read", "Glob", "Grep", "LS", "Bash", "WebFetch"]
---

# /document Command

Generate comprehensive technical documentation for DevOps, SRE, and Cloud engineering workflows. This command analyzes codebases, infrastructure configurations, and system architectures to produce standardized documentation that meets enterprise engineering standards.

## Usage

```bash
/document [type] [options] [path]
```

## Document Types

- `readme` - Generate comprehensive README.md files for repositories
- `runbook` - Operational procedures and incident response
- `architecture` - System design and component relationships  
- `api` - Service endpoints and interface documentation
- `deployment` - CI/CD pipeline and release processes
- `troubleshooting` - Diagnostic procedures and common issues
- `compliance` - Security controls and audit documentation

## Command Options

- `--format` - Output format (markdown, confluence, notion)
- `--template` - Use predefined documentation templates
- `--include-risks` - Generate risk assessment sections
- `--scope` - Documentation scope (service, environment, full-stack)
- `--output` - Specify output file or directory

## Technical Capabilities

When executing this command, analyze and document:

- Parse multiple file formats: YAML, JSON, HCL (Terraform), Dockerfile, Kubernetes manifests
- Extract service dependencies and data flow patterns
- Identify security configurations and access controls
- Generate markdown documentation with consistent formatting
- Include code examples and configuration snippets
- Cross-reference related components and services

## File System Analysis

- Scan project directories for relevant configuration files
- Identify infrastructure patterns and architectural decisions
- Extract metadata from version control history
- Analyze dependencies between services and components

## Context Awareness

- Understand common DevOps toolchains (Terraform, Kubernetes, Docker, Jenkins)
- Recognize cloud provider configurations (AWS, GCP, Azure)
- Identify monitoring and observability setups
- Parse security configurations and access patterns

## Output Standards

- Follow established markdown documentation standards
- Include mandatory risk assessment sections for operational documents
- Generate table of contents for complex documents
- Provide cross-references and linking between related sections
- Include version information and last-updated timestamps

## Risk Assessment Requirements

### Critical Risks to Monitor
- **Sensitive Data Exposure**: Detect and sanitize secrets, API keys, or confidential configuration details
- **Security Misconfiguration Documentation**: Highlight security implications of documented configurations
- **Incomplete Context Analysis**: Validate critical dependencies and infrastructure components

### High Risks to Address
- **Documentation Drift**: Implement refresh mechanisms for infrastructure changes
- **Over-Documentation**: Balance detail with operational clarity
- **Compliance Violations**: Ensure industry-specific regulatory requirements

### Medium Risks to Consider
- **Tool Chain Dependencies**: Maintain adaptability across infrastructure tools
- **Performance Impact**: Optimize analysis for large codebases
- **Version Control Integration**: Align with existing documentation workflows

## README Generation (New Feature)

When using `/document readme`, the command will:

1. **Analyze Repository Structure**: Examine codebase to determine project type
2. **Auto-detect Documentation Style**: Choose appropriate README template:
   - **readme-standard**: General repositories with comprehensive sections
   - **readme-api**: API/library documentation with usage examples  
   - **readme-cli**: Command-line tools with installation instructions
3. **Generate Content**: Create well-structured README.md with:
   - Project description and features
   - Installation instructions
   - Usage examples from actual code
   - Configuration options
   - Contributing guidelines
   - License information
4. **Smart File Handling**: 
   - If README.md exists, create README-new.md for review
   - Extract info from package.json, requirements.txt, etc.
   - Include relevant badges and links

### README Examples:
```bash
/document readme                    # Auto-detect project type
/document readme --style api        # Force API documentation style
/document readme --style cli        # Force CLI tool style
/document readme --update           # Update existing README.md
```

## Implementation Instructions

1. **For README generation**: Apply appropriate "readme-*" output style based on project analysis
2. **For other document types**: Apply the "Technical Documentation" output style
3. Scan the specified path for relevant configuration and source files
4. Analyze file contents and extract specifications
5. Generate documentation following the specified type and format
6. Include mandatory risk assessment sections (for non-README docs)
7. Validate output against documentation standards
8. Save to specified output location or display inline

When no specific path is provided, analyze the current working directory and subdirectories for relevant files.