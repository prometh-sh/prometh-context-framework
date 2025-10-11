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

### Framework Initialization

#### `/prometh-init`
- **Purpose**: Initialize Prometh Context Framework in any project
- **Prerequisites**: Requires existing CLAUDE.md or CLAUDE.local.md (created via `/init`)
- **Functions**: Creates directory structure, initializes PROMETH.md tracking file, provides context-aware guidance
- **Output**: Sets up `docs/prds/`, `docs/specs/`, and project tracking system

**Usage:**
```bash
/prometh-init                                       # Initialize framework in current project
```

### Understanding PRDs vs SPECs

The framework distinguishes between two levels of requirements documentation:
- **PRDs (Product Requirements Documents)**: Strategic, Epic-level initiatives requiring cross-functional alignment, market analysis, and business justification
- **SPECs (Specifications)**: Implementation-focused, User Story/Task-level documentation for development teams with 3-phase workflow

### Document Tracking System

All commands integrate with a **PROMETH.md** tracking file that maintains:
- **Document Inventory**: Complete list of PRDs, SPECs, and technical documentation
- **Status Tracking**: Monitor document lifecycle from Draft to Completed
- **Traceability Matrix**: Links between PRDs and their derived SPECs
- **Recent Activity Log**: Chronological record of document creation and updates
- **Context-Aware Guidance**: Smart next steps based on project state

### CLAUDE.md Validation Requirement

**IMPORTANT**: All Prometh commands require either `CLAUDE.md` or `CLAUDE.local.md` to exist in the project root. If neither file is found, commands will display an error message and exit. Use `/init` in Claude Code to create CLAUDE.md with proper project configuration.

### Strategic Planning (PRDs)

#### `/prometh-prd`
- **Unified Command**: Handles both creation from scratch and normalization of existing documents
- **Input Types**: Strategic descriptions, file paths (PDF, markdown, text), or interactive prompts
- **Use Cases**: Quarterly planning, market positioning, cross-functional initiatives, major feature launches
- **Output**: Comprehensive PRD using unified `prometh-prd` template
- **Validation**: Automatically validates strategic scope vs. tactical implementation needs

**Examples:**
```bash
/prometh-prd                                    # Interactive mode - prompts for strategic description
/prometh-prd strategic-planning-document.pdf   # Normalize existing strategic document
/prometh-prd                                    # Text input mode - provide strategic content in prompt
```

### Implementation Planning (SPECs)

#### `/prometh-spec`
- **Unified Command**: Handles both creation from scratch and normalization of existing documents
- **Input Types**: Implementation descriptions, file paths, user stories, bug reports, enhancement requests
- **Use Cases**: Feature development, bug fixes, enhancements, technical tasks
- **Output**: Comprehensive SPEC using unified `prometh-spec` template with 3-phase workflow
- **Classification**: Automatically categorizes as Feature/Bug Fix/Enhancement/Technical Task

**3-Phase Implementation Workflow:**
- **Phase 1: Planning** - Requirements analysis, technical design, resource planning
- **Phase 2: Task Breakdown** - Detailed development tasks, acceptance criteria, dependency mapping
- **Phase 3: Implementation** - Core development, testing, deployment, validation

**PRD-to-SPEC Workflow:**
```bash
/prometh-spec --from-prd docs/prds/strategic-initiative-prd.md  # Create implementation SPECs from existing PRD
```

**Examples:**
```bash
/prometh-spec                                   # Interactive mode - prompts for implementation description
/prometh-spec user-story.md                     # Normalize existing user story
/prometh-spec bug-report.pdf                    # Convert bug report to SPEC format
/prometh-spec --from-prd mobile-strategy-prd.md # Generate SPECs from PRD with traceability
```

### Documentation Generation

#### `/prometh-doc`
- **Renamed**: Previously `/prometh-document`, now simplified to `/prometh-doc`
- **Types Supported**: `readme` and `runbook` documentation
- **Auto-Analysis**: Analyzes repository structure and system configuration
- **Output**: Uses unified templates for consistent documentation

**Usage:**
```bash
/prometh-doc readme                             # Generate comprehensive README.md
/prometh-doc runbook                            # Generate operational runbook
```

### Status Dashboard

#### `/prometh-status`
- **Purpose**: Display comprehensive project documentation status dashboard
- **Features**: Document inventory summary, recent activity feed, traceability matrix overview, health metrics
- **Output**: Formatted console dashboard with project insights and context-aware suggestions
- **Options**: `--brief` (condensed view), `--counts` (document counts only), `--health` (health metrics focus)

**Usage:**
```bash
/prometh-status                                 # Full status dashboard
/prometh-status --brief                         # Quick summary view
/prometh-status --health                        # Health metrics and suggestions
```

## Available Output Styles

The framework now uses 4 unified output styles (simplified from 11):

### Strategic Documentation
- **prometh-prd**: Unified PRD template for all strategic planning scenarios

### Implementation Documentation  
- **prometh-spec**: Unified SPEC template with 3-phase workflow for all implementation tasks

### Technical Documentation
- **prometh-doc-readme**: Unified README template for comprehensive project documentation
- **prometh-doc-runbook**: Specialized runbook template for operational procedures and troubleshooting

## Development Notes

- The project uses Apache License 2.0
- Documentation is organized in the `docs/` directory with PRDs in `docs/prds/` and SPECs in `docs/specs/`
- The gitignore is configured for general development artifacts, temporary files, and common IDE files
- AI development tools (Cursor) are specifically configured in the gitignore
- Custom Claude Code commands are available in `.claude/commands/`
- Unified output styles are stored in `.claude/output-styles/` for version control and backup

## Framework Features

### CLAUDE.md Validation
- **Mandatory Check**: All commands validate presence of CLAUDE.md or CLAUDE.local.md
- **Error Handling**: Clear error messages guide users to create configuration files
- **Context Assurance**: Ensures proper project context for all Prometh operations

### Intelligent Classification
- **PRD vs SPEC Detection**: Automatic classification of strategic vs. tactical content
- **Implementation Type Detection**: Auto-categorizes SPECs as Feature/Bug/Enhancement/Task
- **Scope Validation**: Prevents misclassification and suggests appropriate commands

### Enhanced SPEC Workflow
- **3-Phase Structure**: Planning → Task Breakdown → Implementation
- **Actionable Tasks**: Each phase includes specific deliverables and checkboxes
- **Risk Assessment**: Built-in risk identification and mitigation planning
- **Quality Assurance**: Comprehensive testing and validation procedures

## Setup Instructions

To install the Prometh Context Framework on any machine, run the setup script:

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

## Available Commands Summary

After installation, you will have access to these simplified commands:

### `/prometh-prd`
- **Purpose**: Strategic Product Requirements Documents
- **Input**: Strategic descriptions, file paths, or interactive prompts
- **Output**: Comprehensive PRD using unified template
- **Use For**: Quarterly planning, market positioning, cross-functional initiatives

### `/prometh-spec`  
- **Purpose**: Implementation Specifications with 3-phase workflow
- **Input**: Implementation descriptions, user stories, bug reports, file paths
- **Output**: Comprehensive SPEC with structured workflow
- **Use For**: Feature development, bug fixes, enhancements, technical tasks

### `/prometh-doc`
- **Purpose**: Technical documentation generation
- **Types**: `readme` for project documentation, `runbook` for operational procedures
- **Output**: Uses unified templates based on repository/system analysis
- **Use For**: Project README files, operational runbooks

## Migration from Previous Version

If upgrading from a previous version with multiple output styles:
- **Commands Simplified**: `/prometh-prd-normalize` and `/prometh-spec-normalize` merged into main commands
- **Output Styles Unified**: 11 separate styles consolidated into 4 unified templates
- **CLAUDE.md Required**: New mandatory validation for all commands
- **Enhanced Workflows**: SPECs now include 3-phase implementation structure

The new unified approach provides the same functionality with improved simplicity and consistency.