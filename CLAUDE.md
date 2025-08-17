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

This project includes a custom `/prd-normalize` command that automatically converts documents from various formats into standardized PRDs.

#### Available PRD Output Styles:
- **prd-standard**: For general requirements and feature documents
- **prd-bugfix**: Specialized for bug/issue reports converted to PRDs  
- **prd-feature**: For new feature requests and development

#### PRD Workflow:
1. Place documents (PDF, markdown, text, etc.) in `docs/inbox/`
2. Run `/prd-normalize` or `/prd-normalize [filename]`
3. System analyzes document type and applies appropriate output style
4. Generates standardized PRD in `docs/prds/` directory

#### Document Types Supported:
- **Bug/Issue Reports**: Converted using `prd-bugfix` style with focus on problem analysis and resolution
- **Feature Requests**: Processed using `prd-feature` style with market analysis and user value
- **General Requirements**: Normalized using `prd-standard` style for comprehensive specification

### README Generation Workflow

The project includes an enhanced `/document` command that can generate comprehensive README.md files for repositories.

#### Available README Output Styles:
- **readme-standard**: Comprehensive README.md for general repositories with all essential sections
- **readme-api**: Specialized for API/library documentation with usage examples and endpoint documentation
- **readme-cli**: For command-line tools with installation instructions and usage guides

#### README Generation Workflow:
1. Navigate to any repository directory
2. Run `/document readme` for auto-detection, or `/document readme --style [type]` for specific style
3. System analyzes the codebase to determine project type and appropriate template
4. Generates comprehensive README.md (or README-new.md if one already exists)

#### Repository Types Supported:
- **General Projects**: Uses `readme-standard` with comprehensive sections for features, installation, usage
- **APIs/Libraries**: Uses `readme-api` with endpoint documentation, SDK examples, authentication guides
- **CLI Tools**: Uses `readme-cli` with installation methods, command references, shell integration

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
cp .claude/output-styles/prd-*.md ~/.claude/output-styles/
cp .claude/output-styles/readme-*.md ~/.claude/output-styles/
cp .claude/commands/*.md ~/.claude/commands/
```

## Available Commands

After installation, you will have access to:

### `/prd-normalize [filename]`
- Converts documents to standardized PRDs
- Auto-detects document type (bug report, feature request, general requirements)
- Applies appropriate output style automatically
- Archives processed files with timestamps

### `/document readme [--style type]`
- Generates comprehensive README.md files
- Auto-detects project type (general, API, CLI tool)
- Analyzes codebase for real examples and configuration
- Creates README-new.md if README.md already exists

### `/document [type]` 
- Generate other technical documentation types
- Supports runbook, architecture, api, deployment, troubleshooting, compliance