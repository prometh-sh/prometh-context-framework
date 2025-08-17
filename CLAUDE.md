# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The Prometh Context Framework is an AI tooling framework designed to provide predictable, high-quality output for AI users. As the description states: "Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."

## Project Structure

- `docs/inbox/` - Incoming documents for PRD normalization (PDFs, markdown, text files)
- `docs/prds/` - Standardized Product Requirements Documents
- `.claude/commands/` - Custom Claude Code slash commands
- `.claude/output-styles/` - PRD output styles for document normalization
- `LICENSE` - Apache License 2.0
- `README.md` - Project overview and description

## Custom Commands

### PRD Normalization Workflow

This project includes a custom `/prometh-prd-normalize` command that automatically converts documents from various formats into standardized PRDs.

#### Available PRD Output Styles:
- **prometh-prd-standard**: For general requirements and feature documents
- **prometh-prd-bugfix**: Specialized for bug/issue reports converted to PRDs  
- **prometh-prd-feature**: For new feature requests and development
- **prometh-prd-codebase-analysis**: For repository initialization and codebase analysis scenarios

#### PRD Workflow:
1. Place documents (PDF, markdown, text, etc.) in `docs/inbox/`
2. Run `/prometh-prd-normalize` or `/prometh-prd-normalize [filename]`
3. System analyzes document type and applies appropriate output style
4. Generates standardized PRD in `docs/prds/` directory

#### Document Types Supported:
- **Bug/Issue Reports**: Converted using `prometh-prd-bugfix` style with focus on problem analysis and resolution
- **Feature Requests**: Processed using `prometh-prd-feature` style with market analysis and user value
- **General Requirements**: Normalized using `prometh-prd-standard` style for comprehensive specification

### Repository Initialization Workflow

This project includes an advanced `/prometh-init` command that intelligently analyzes repositories with poor documentation and generates comprehensive PRDs based on codebase analysis.

#### Available Thinking Depth Options:
- **--think**: Basic repository analysis (file structure, dependencies, technology stack)
- **--think-hard**: Deep analysis (architecture patterns, API discovery, security assessment)
- **--think-harder**: Advanced analysis (user flows, integration patterns, business logic extraction)
- **--ultrathink**: Comprehensive analysis (domain modeling, competitive analysis, strategic recommendations)

#### Repository Initialization Workflow:
1. Navigate to repository with poor or missing documentation
2. Run `/prometh-init [thinking-option]` to analyze codebase
3. System performs intelligent analysis based on selected depth level
4. Generates multiple specialized PRDs using `prometh-prd-codebase-analysis` style
5. Creates comprehensive documentation structure for ongoing development

#### Repository Analysis Capabilities:
- **Codebase Assessment**: Technology stack, architecture patterns, code quality analysis
- **Feature Discovery**: Existing functionality inventory and business logic extraction
- **Gap Analysis**: Missing documentation, technical debt, security vulnerabilities
- **Strategic Planning**: Development roadmaps, prioritization recommendations, competitive positioning

### README Generation Workflow

The project includes an enhanced `/prometh-document` command that can generate comprehensive README.md files for repositories.

#### Available README Output Styles:
- **prometh-readme-standard**: Comprehensive README.md for general repositories with all essential sections
- **prometh-readme-api**: Specialized for API/library documentation with usage examples and endpoint documentation
- **prometh-readme-cli**: For command-line tools with installation instructions and usage guides

#### README Generation Workflow:
1. Navigate to any repository directory
2. Run `/prometh-document readme` for auto-detection, or `/prometh-document readme --style [type]` for specific style
3. System analyzes the codebase to determine project type and appropriate template
4. Generates comprehensive README.md (or README-new.md if one already exists)

#### Repository Types Supported:
- **General Projects**: Uses `prometh-readme-standard` with comprehensive sections for features, installation, usage
- **APIs/Libraries**: Uses `prometh-readme-api` with endpoint documentation, SDK examples, authentication guides
- **CLI Tools**: Uses `prometh-readme-cli` with installation methods, command references, shell integration

#### README Features:
- Auto-detects project type from package.json, requirements.txt, Cargo.toml, etc.
- Extracts actual code examples from the repository
- Generates appropriate badges and metadata
- Includes installation instructions for multiple platforms
- Smart file handling (creates README-new.md if README.md exists)

## Development Notes

- The project uses Apache License 2.0
- Documentation is organized in the `docs/` directory with PRDs in `docs/prds/`
- The gitignore is configured for general development artifacts, temporary files, and common IDE files
- AI development tools (Cursor) are specifically configured in the gitignore
- Custom Claude Code commands are available in `.claude/commands/`
- PRD output styles are stored in `.claude/output-styles/` for version control and backup

## Setup Instructions

To install the PRD normalization system on any machine, run the setup script:

```bash
./setup.sh
```

The setup script will:
- Safely copy commands and output styles to your `~/.claude/` directory
- Ask before overwriting any existing files
- Preserve your existing Claude Code configuration
- Provide verification of successful installation

Manual installation (if preferred):
```bash
cp .claude/output-styles/prometh-*.md ~/.claude/output-styles/
cp .claude/commands/prometh-*.md ~/.claude/commands/
```

## Available Commands

After installation, you will have access to:

### `/prometh-prd-normalize [filename]`
- Converts documents to standardized PRDs
- Auto-detects document type (bug report, feature request, general requirements)
- Applies appropriate output style automatically
- Archives processed files with timestamps

### `/prometh-init [thinking-option]`
- Smart repository initialization and codebase analysis
- Thinking depth options: `--think`, `--think-hard`, `--think-harder`, `--ultrathink`
- Generates comprehensive PRDs from repository analysis
- Creates complete documentation structure for poorly documented projects
- Analyzes technology stack, architecture, features, and strategic opportunities

### `/prometh-document readme [--style type]`
- Generates comprehensive README.md files
- Auto-detects project type (general, API, CLI tool)
- Analyzes codebase for real examples and configuration
- Creates README-new.md if README.md already exists

### `/prometh-document [type]` 
- Generate other technical documentation types
- Supports runbook, architecture, api, deployment, troubleshooting, compliance