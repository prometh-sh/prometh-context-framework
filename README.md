# Prometh Context Framework

> *"Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."*

A powerful command-line framework for AI-driven document normalization and technical documentation generation. Transform messy documents into standardized Product Requirements Documents (PRDs) and generate comprehensive README files automatically.

[![Version](https://img.shields.io/badge/version-v1.0.0-blue.svg)](https://github.com/ivannagy/prometh-context-framework/releases)
[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg)](LICENSE)
[![Shell](https://img.shields.io/badge/shell-bash-brightgreen.svg)](#installation)
[![Claude](https://img.shields.io/badge/Claude-Code-orange.svg)](https://claude.ai/code)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-lightgrey.svg)](#prerequisites)
[![Framework](https://img.shields.io/badge/type-AI%20Tooling%20Framework-brightgreen.svg)](#features)

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage](#usage)
- [Commands](#commands)
- [Configuration](#configuration)
- [Examples](#examples)
- [Shell Integration](#shell-integration)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [Changelog](#changelog)
- [Support](#support)

## Features

- **PRD Normalization**: Convert documents from various formats into standardized Product Requirements Documents
- **README Generation**: Auto-generate comprehensive README.md files for any repository type
- **Document Intelligence**: Automatically detect document types and apply appropriate formatting styles
- **Cross-platform**: Works on Windows, macOS, and Linux with Claude Code
- **Fast & Lightweight**: Bash-based installation with minimal dependencies
- **Configurable**: Multiple output styles for different document types and project structures
- **Shell Integration**: Seamless integration with Claude Code's slash command system
- **Rich Output**: Structured document output with consistent formatting and templates

## Installation

### Quick Install (Recommended)

#### Using the Setup Script

```bash
# Clone the repository
git clone https://github.com/ivannagy/prometh-context-framework.git
cd prometh-context-framework

# Run the setup script
./setup.sh
```

The setup script will:
- Safely copy commands and output styles to your `~/.claude/` directory
- Ask before overwriting any existing files
- Preserve your existing Claude Code configuration
- Provide verification of successful installation

#### Manual Installation

```bash
# Create Claude Code directories
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/output-styles

# Copy commands and styles
cp .claude/commands/*.md ~/.claude/commands/
cp .claude/output-styles/*.md ~/.claude/output-styles/
```

### Prerequisites

- **Claude Code**: Access to Claude Code (claude.ai/code)
- **Bash**: Version 4.0 or higher (for setup script)
- **Git**: For cloning the repository  
- **Operating System**: macOS, Linux, or Windows with WSL/Git Bash

### Verify Installation

```bash
# Check if files are installed
ls ~/.claude/commands/
ls ~/.claude/output-styles/

# Files should include:
# Commands: prd-normalize.md, document.md
# Styles: prd-standard.md, prd-bugfix.md, prd-feature.md, readme-*.md
```

## Quick Start

### Basic Usage

```bash
# PRD Normalization - convert documents to standardized PRDs
/prd-normalize bug-report.pdf

# README Generation - create comprehensive README files
/document readme

# Technical Documentation - generate other doc types
/document runbook
```

### Your First Command

```bash
# 1. Place a document in docs/inbox/
mkdir -p docs/inbox
cp your-document.pdf docs/inbox/

# 2. Run PRD normalization
/prd-normalize

# 3. Check generated PRD
ls docs/prds/

# Example output:
# Processing bug-report.pdf
# ├── Type: Bug Report (using prd-bugfix style)
# ├── Output: docs/prds/fix-login-issue-prd.md
# ├── Archived: docs/archive/bug-report-20250817-143022.pdf
# └── Duration: 2.1s
```

## Usage

### Basic Syntax

```bash
/[command] [arguments] [options]
```

### Available Commands

| Command | Description | Arguments |
|---------|-------------|-----------|
| `/prd-normalize` | Convert documents to PRDs | `[filename]` (optional) |
| `/document` | Generate technical documentation | `[type]` (required) |

### Document Types Supported

| Input Format | Output Style | Use Case |
|--------------|--------------|----------|
| PDF, Markdown, Text | `prd-bugfix` | Bug reports, issue documents |
| Feature specs, Requirements | `prd-feature` | New feature requests |
| General documents | `prd-standard` | Comprehensive requirements |
| Repository analysis | `readme-cli` | CLI tool documentation |
| API/Library analysis | `readme-api` | Service documentation |
| General projects | `readme-standard` | Standard README files |

## Commands

### Core Commands

#### `/prd-normalize [filename]`

Normalize documents from `docs/inbox/` into standardized PRD format.

**Arguments:**
- `filename` (optional) - Process specific file, or all files if omitted

**Behavior:**
1. Scans `docs/inbox/` directory for documents
2. Auto-detects document type (bug report, feature request, general)
3. Applies appropriate output style automatically
4. Saves PRD to `docs/prds/` with descriptive filename
5. Archives processed files to `docs/archive/` with timestamp

**Examples:**

```bash
# Process all documents in inbox
/prd-normalize

# Process specific document
/prd-normalize bug-report-login-issue.pdf

# Process feature request
/prd-normalize feature-request-dark-mode.md
```

**Output Styles Applied:**
- **Bug/Issue Reports** → `prd-bugfix` style
- **Feature Requests** → `prd-feature` style  
- **General Requirements** → `prd-standard` style

#### `/document [type]`

Generate comprehensive technical documentation.

**Arguments:**
- `type` (required) - Documentation type to generate

**Available Types:**
| Type | Description | Output Style |
|------|-------------|--------------|
| `readme` | Repository README.md files | Auto-detected (cli/api/standard) |
| `runbook` | Operational procedures | Technical Documentation |
| `architecture` | System design docs | Technical Documentation |
| `api` | Service endpoints | Technical Documentation |
| `deployment` | CI/CD processes | Technical Documentation |
| `troubleshooting` | Diagnostic guides | Technical Documentation |
| `compliance` | Security controls | Technical Documentation |

**Examples:**

```bash
# Generate README for current repository
/document readme

# Generate operational runbook
/document runbook

# Generate API documentation
/document api

# Generate system architecture docs
/document architecture
```

### README Generation Features

The `/document readme` command automatically:

1. **Analyzes Repository Structure**: Examines codebase to determine project type
2. **Auto-detects Style**: Chooses appropriate template:
   - `readme-cli`: For command-line tools (like this project)
   - `readme-api`: For APIs and libraries
   - `readme-standard`: For general repositories
3. **Smart File Handling**: Creates README-new.md if README.md exists
4. **Extracts Real Examples**: Uses actual code from your repository

## Configuration

### Directory Structure

```
prometh-context-framework/
├── docs/
│   ├── inbox/          # Incoming documents for processing
│   ├── prds/           # Generated standardized PRDs
│   └── archive/        # Processed documents with timestamps
├── .claude/
│   ├── commands/       # Custom Claude Code slash commands
│   └── output-styles/  # Document formatting templates
├── setup.sh           # Installation script
└── README.md          # This file
```

### Output Styles

The framework includes several specialized output styles:

#### PRD Styles
- **prd-standard**: General requirements and feature documents
- **prd-bugfix**: Bug/issue reports with systematic resolution focus
- **prd-feature**: Feature requests with market analysis and user value

#### README Styles  
- **readme-standard**: Comprehensive README for general repositories
- **readme-api**: API/library documentation with usage examples
- **readme-cli**: CLI tool documentation with installation guides

#### Technical Documentation
- **technical-documentation**: For runbooks, architecture, and operational docs

### File Naming Conventions

**PRD Output Files:**
- Bug fixes: `fix-[issue-name]-prd.md`
- Features: `feature-[name]-prd.md`
- General: `[document-title]-prd.md`

**Archived Files:**
- Format: `originalfilename-YYYYMMDD-HHMMSS.ext`
- Example: `feature-request.md` → `feature-request-20250817-143022.md`

## Examples

### Example 1: Bug Report Normalization

```bash
# Place bug report in inbox
cp critical-login-bug.pdf docs/inbox/

# Process the document
/prd-normalize critical-login-bug.pdf
```

**Output:**
```
Processing critical-login-bug.pdf
├── Document Type: Bug Report
├── Applied Style: prd-bugfix
├── Generated PRD: docs/prds/fix-critical-login-bug-prd.md
├── Archived: docs/archive/critical-login-bug-20250817-143052.pdf
└── Processing completed successfully
```

### Example 2: Batch Document Processing

```bash
# Place multiple documents in inbox
cp *.pdf docs/inbox/
cp feature-requests/*.md docs/inbox/

# Process all documents
/prd-normalize
```

**Output:**
```
Processing documents from docs/inbox/...
✓ bug-report-payment.pdf → fix-payment-issue-prd.md (prd-bugfix)
✓ feature-mobile-app.md → feature-mobile-app-prd.md (prd-feature)
✓ requirements-v2.docx → requirements-v2-prd.md (prd-standard)

Summary:
├── Processed: 3 documents
├── Generated: 3 PRDs in docs/prds/
├── Archived: 3 files to docs/archive/
└── Total duration: 4.2s
```

### Example 3: README Generation for Different Project Types

```bash
# For a CLI tool project
cd my-cli-tool
/document readme
# → Generates README.md using readme-cli style

# For an API project  
cd my-api-service
/document readme
# → Generates README.md using readme-api style

# For a general project
cd my-web-app
/document readme  
# → Generates README.md using readme-standard style
```

### Example 4: Technical Documentation Generation

```bash
# Generate operational runbook
/document runbook
# → Creates comprehensive operational procedures

# Generate architecture documentation
/document architecture
# → Documents system design and component relationships

# Generate troubleshooting guide
/document troubleshooting
# → Creates diagnostic procedures and common issue solutions
```

### Example 5: Advanced Workflow Integration

```bash
# Complete document processing workflow
mkdir -p docs/{inbox,prds,archive}

# Process requirements from multiple sources
cp project-specs/*.pdf docs/inbox/
cp issue-reports/*.md docs/inbox/
cp feature-requests/*.txt docs/inbox/

# Normalize all documents
/prd-normalize

# Generate project documentation
/document readme
/document architecture
/document deployment

# Result: Comprehensive project documentation suite
```

## Shell Integration

### Bash Aliases

Add useful aliases to your shell configuration:

```bash
# ~/.bashrc or ~/.zshrc
alias prd='/prd-normalize'
alias doc='/document'
alias prd-status='ls -la docs/prds/ docs/archive/'

# Function for quick PRD processing
prd-quick() {
    cp "$1" docs/inbox/
    /prd-normalize "$(basename "$1")"
    echo "PRD generated in docs/prds/"
}
```

### Directory Navigation

```bash
# Create useful functions
goto-inbox() { cd docs/inbox; }
goto-prds() { cd docs/prds; }
goto-archive() { cd docs/archive; }

# Quick file operations
alias inbox-list='ls -la docs/inbox/'
alias prds-list='ls -la docs/prds/'
alias recent-prds='ls -lt docs/prds/ | head -10'
```

### Integration with Git

```bash
# Add to your git workflow
git-doc() {
    /document readme
    git add README.md
    git commit -m "docs: update README.md with latest project structure"
}

# PRD workflow with git
prd-commit() {
    /prd-normalize
    git add docs/prds/
    git commit -m "docs: add normalized PRDs from latest requirements"
}
```

## Best Practices

### Document Organization

**Efficient Workflow:**
```bash
# Maintain a clean workspace
docs/
├── inbox/          # Only active documents to process
├── prds/           # Generated PRDs (commit to git)
├── archive/        # Processed documents (gitignore recommended)
└── templates/      # Custom templates (optional)
```

**File Naming Conventions:**
- Source files: Use descriptive names like `feature-dark-mode-v2.pdf`
- PRD outputs: Auto-generated as `feature-dark-mode-v2-prd.md`
- Archive files: Auto-timestamped as `feature-dark-mode-v2-20250817-143022.pdf`

### Quality Assurance

**Before Processing:**
- Review source documents for completeness
- Ensure documents contain actionable requirements
- Remove sensitive information if needed

**After Processing:**
- Review generated PRDs for accuracy
- Validate that all key requirements are captured
- Test generated documentation with stakeholders

**Documentation Standards:**
- Use consistent terminology across PRDs
- Include measurable acceptance criteria
- Maintain traceability to source documents

### Integration Workflows

**Git Integration:**
```bash
# Process documents and commit results
/prd-normalize
git add docs/prds/
git commit -m "docs: add PRDs for sprint planning"

# Generate updated README
/document readme --update
git add README.md
git commit -m "docs: update README with latest features"
```

**Team Workflows:**
- Use `docs/inbox/` for team document collection
- Configure `.gitignore` to exclude `docs/archive/`
- Share generated PRDs via version control
- Use GitHub Issues/Projects integration with PRD references

**Quality Gates:**
- Review PRDs before sprint planning
- Validate technical feasibility with engineering team
- Confirm business alignment with product stakeholders
- Update PRDs based on implementation learnings

## Troubleshooting

### Common Issues

#### Issue 1: Commands Not Available in Claude Code

**Problem**: Slash commands don't appear or aren't working

**Solutions:**
1. **Verify Installation**:
   ```bash
   ls ~/.claude/commands/
   ls ~/.claude/output-styles/
   ```

2. **Reinstall**:
   ```bash
   ./setup.sh
   # Choose 'y' to overwrite existing files
   ```

3. **Check Claude Code**: Ensure you're using Claude Code (claude.ai/code)

#### Issue 2: Permission Denied on Setup

**Problem**: `permission denied: ./setup.sh`

**Solutions:**
1. **Make executable**:
   ```bash
   chmod +x setup.sh
   ./setup.sh
   ```

2. **Run with bash**:
   ```bash
   bash setup.sh
   ```

#### Issue 3: Documents Not Processing

**Problem**: PRD normalization fails or produces unexpected results

**Solutions:**
1. **Check Directory Structure**:
   ```bash
   mkdir -p docs/{inbox,prds,archive}
   ```

2. **Verify File Format**: Ensure documents are in supported formats (PDF, MD, TXT, DOC)

3. **Check File Permissions**:
   ```bash
   ls -la docs/inbox/
   # Files should be readable
   ```

#### Issue 4: Output Styles Not Applying

**Problem**: Generated documents don't follow expected format

**Solutions:**
1. **Verify Style Installation**:
   ```bash
   ls ~/.claude/output-styles/
   # Should show prd-*.md and readme-*.md files
   ```

2. **Check Style Syntax**: Review output style files for proper frontmatter

3. **Manual Style Application**: Explicitly request style in Claude Code:
   ```
   Please use the 'prd-bugfix' output style for this document
   ```

### Debug Mode

Enable verbose output for troubleshooting:

```bash
# Check setup script in verbose mode
bash -x setup.sh

# Verify file structure
find ~/.claude -name "*.md" -type f

# Test Claude Code integration
# Use verbose flag in Claude Code if available
```

### Directory Structure Validation

```bash
# Verify complete directory structure
tree docs/ 2>/dev/null || find docs/ -type d

# Expected structure:
# docs/
# ├── inbox/
# ├── prds/
# └── archive/
```

### Getting Help

1. **Check Installation**:
   ```bash
   # Verify all components
   ls -la ~/.claude/commands/
   ls -la ~/.claude/output-styles/
   ```

2. **Review Setup Output**: Run setup script again to see any error messages

3. **File Permissions**: Ensure all files are readable and directories are accessible

4. **Claude Code Status**: Verify you have access to Claude Code and slash commands work

## Contributing

We welcome contributions! The Prometh Context Framework is designed to be extensible.

### Development Setup

```bash
# Clone repository
git clone https://github.com/ivannagy/prometh-context-framework.git
cd prometh-context-framework

# Install for development
./setup.sh

# Test installation
ls ~/.claude/commands/
ls ~/.claude/output-styles/
```

### Adding New Output Styles

Create new output styles in `.claude/output-styles/`:

```bash
# Create new style file
cat > .claude/output-styles/my-new-style.md << 'EOF'
---
name: My New Style
description: Description of what this style does
---

[Your style content here]
EOF

# Install the new style
cp .claude/output-styles/my-new-style.md ~/.claude/output-styles/
```

### Adding New Commands

Create new commands in `.claude/commands/`:

```bash
# Create new command file
cat > .claude/commands/my-command.md << 'EOF'
---
description: Description of your command
allowed-tools: Read, Write, LS, Glob
---

# My Command

[Command implementation here]
EOF

# Install the new command
cp .claude/commands/my-command.md ~/.claude/commands/
```

### Code Style

- Follow Markdown conventions for documentation
- Use YAML frontmatter for metadata
- Include clear descriptions and examples
- Test with various document types
- Document any new features in README

### Submitting Changes

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Make your changes
4. Test the installation: `./setup.sh`
5. Test the functionality with sample documents
6. Submit a pull request

## Changelog

### Version 1.0.0 (2025-08-17)

**Initial Release**
- ✨ PRD normalization with auto-detection of document types
- ✨ README generation with project type analysis
- ✨ Technical documentation generation for DevOps workflows
- ✨ Cross-platform setup script with safe installation
- ✨ Multiple output styles for different document types
- ✨ Automated file archiving with timestamp preservation
- 📚 Comprehensive documentation and examples
- 🔧 Shell integration with aliases and functions

**Features Added:**
- `/prd-normalize` command with intelligent document classification
- `/document readme` command with auto-style detection
- `/document [type]` for technical documentation generation
- Support for PDF, Markdown, and text file processing
- Archive system with timestamped file management
- Output styles: `prd-standard`, `prd-bugfix`, `prd-feature`, `readme-cli`, `readme-api`, `readme-standard`

**Infrastructure:**
- Apache 2.0 license
- Bash-based cross-platform setup
- Claude Code slash command integration
- Structured directory organization
- Comprehensive troubleshooting documentation

## Support

### Documentation

- **Project Repository**: [GitHub Repository](https://github.com/ivannagy/prometh-context-framework)
- **Claude Code Documentation**: [Claude Code](https://claude.ai/code)
- **Setup Instructions**: See [Installation](#installation) section above

### Community

- **GitHub Issues**: [Report Issues](https://github.com/ivannagy/prometh-context-framework/issues)
- **GitHub Discussions**: [Community Discussions](https://github.com/ivannagy/prometh-context-framework/discussions)
- **Feature Requests**: Submit via GitHub Issues with "enhancement" label

### Quick Support

- **Installation Issues**: Rerun `./setup.sh` and check output for errors
- **Command Issues**: Verify files exist in `~/.claude/commands/` and `~/.claude/output-styles/`
- **Document Processing**: Check that `docs/inbox/` contains readable files
- **Output Issues**: Verify directory permissions for `docs/prds/` and `docs/archive/`

---

**Latest Release**: [v1.0.0](https://github.com/ivannagy/prometh-context-framework/releases/latest) | **License**: [Apache 2.0](LICENSE) | **Documentation**: [README.md](README.md)

---

*"Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."*