# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The Prometh Context Framework is an AI tooling framework designed to provide predictable, high-quality output for AI users. As the description states: "Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."

## Project Structure

- `docs/prds/` - Strategic Product Requirements Documents (Epic-level)
- `docs/specs/` - Implementation Specifications (User Story/Task-level)
- `.claude/commands/` - Custom Claude Code slash commands
- `.claude/output-styles/` - Output styles for document normalization
- `LICENSE` - Apache License 2.0
- `README.md` - Project overview and description

## Custom Commands

### Understanding PRDs vs SPECs

The framework distinguishes between two levels of requirements documentation:
- **PRDs (Product Requirements Documents)**: Strategic, Epic-level initiatives requiring cross-functional alignment, market analysis, and business justification
- **SPECs (Specifications)**: Implementation-focused, User Story/Task-level documentation for development teams

### PRD Commands (Strategic Planning)

#### `/prometh-prd`
- Create new PRDs from scratch based on strategic descriptions
- For quarterly planning, market positioning, cross-functional initiatives
- Generates comprehensive business case and stakeholder alignment documents

#### `/prometh-prd-normalize [filename]`
- Normalize strategic documents into standardized PRD format
- Supports single file or text input (no bulk processing)
- Validates strategic scope vs. tactical implementation needs

#### Available PRD Output Styles:
- **prometh-prd-standard**: General strategic requirements and Epic-level planning
- **prometh-prd-feature**: Major feature development with market analysis
- **prometh-prd-bugfix**: Complex issues requiring strategic product decisions

### SPEC Commands (Implementation Planning)

#### `/prometh-spec`
- Create new SPECs from scratch based on implementation descriptions
- For user stories, tasks, feature implementations, bug fixes
- Generates implementation-ready specifications for development teams

#### `/prometh-spec-normalize [filename]`
- Normalize implementation documents into standardized SPEC format
- Supports single file or text input
- Focuses on tactical implementation details

#### Available SPEC Output Styles:
- **prometh-spec-feature**: New feature implementation (user stories)
- **prometh-spec-bugfix**: Bug fixes and defects
- **prometh-spec-enhancement**: Improvements to existing features
- **prometh-spec-task**: Technical/maintenance tasks

### Documentation Generation

#### `/prometh-document [type]`
- Generate technical documentation (README, runbooks, architecture docs)
- Supports various documentation types with appropriate templates
- Auto-detects project characteristics for relevant content

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

### Strategic Planning (PRDs)

#### `/prometh-prd`
- Create new strategic PRDs from user descriptions
- For Epic-level initiatives, market positioning, cross-functional projects
- Generates comprehensive business case and stakeholder alignment

#### `/prometh-prd-normalize [filename]`
- Normalize strategic documents into standardized PRD format
- Single file or text input processing
- Validates strategic scope and business impact

### Implementation Planning (SPECs)

#### `/prometh-spec`
- Create new implementation SPECs from user descriptions
- For user stories, tasks, features, bug fixes
- Generates implementation-ready specifications

#### `/prometh-spec-normalize [filename]`
- Normalize implementation documents into standardized SPEC format
- Single file or text input processing
- Focuses on tactical development details

### Documentation Generation

#### `/prometh-document readme [--style type]`
- Generates comprehensive README.md files
- Auto-detects project type (general, API, CLI tool)
- Analyzes codebase for real examples and configuration

#### `/prometh-document [type]`
- Generate other technical documentation types
- Supports runbook, architecture, api, deployment, troubleshooting, compliance