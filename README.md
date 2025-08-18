# Prometh Context Framework

> *"Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."*

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://docs.anthropic.com/en/docs/claude-code)

A comprehensive AI tooling framework that provides structured commands and templates for creating strategic Product Requirements Documents (PRDs), implementation Specifications (SPECs), and technical documentation. Designed to deliver predictable, high-quality output for software development teams.

## 🔥 Features

### Strategic Planning (PRDs)
- **Epic-Level Documentation**: Create comprehensive PRDs for cross-functional initiatives
- **Market Analysis Integration**: Built-in templates for competitive positioning and business justification
- **Stakeholder Alignment**: Structured formats for quarterly planning and strategic decisions

### Implementation Planning (SPECs)
- **User Story Documentation**: Task-level specifications ready for development teams
- **Feature Implementation**: Detailed technical specifications with acceptance criteria
- **Bug Fix Planning**: Systematic approach to complex issue resolution

### Documentation Generation
- **Auto-Detection**: Smart repository analysis to determine appropriate documentation style
- **Multi-Format Support**: README generation for general, API, and CLI projects
- **Technical Documentation**: Runbooks, architecture docs, and operational procedures

## 🚀 Quick Start

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-org/prometh-context-framework.git
   cd prometh-context-framework
   ```

2. **Run the setup script:**
   ```bash
   ./setup.sh
   ```

3. **Verify installation:**
   ```bash
   # Check installed commands in Claude Code
   ls ~/.claude/commands/prometh-*
   ```

### Basic Usage

#### Strategic Planning
```bash
# Create a new PRD from description
/prometh-prd "Implement multi-tenant authentication system for enterprise customers"

# Normalize existing document to PRD format
/prometh-prd-normalize project-proposal.md
```

#### Implementation Planning
```bash
# Create implementation specification
/prometh-spec "Add user profile avatar upload with image compression"

# Convert requirements to SPEC format
/prometh-spec-normalize feature-requirements.md
```

#### Documentation Generation
```bash
# Generate comprehensive README
/prometh-document readme

# Create technical runbook
/prometh-document runbook
```

## 📁 Project Structure

```
prometh-context-framework/
├── .claude/
│   ├── commands/           # Custom Claude Code slash commands
│   │   ├── prometh-prd.md
│   │   ├── prometh-spec.md
│   │   └── prometh-document.md
│   └── output-styles/      # Standardized output templates
│       ├── prometh-prd-*.md
│       ├── prometh-spec-*.md
│       └── prometh-readme-*.md
├── docs/
│   ├── prds/              # Strategic Product Requirements Documents
│   └── specs/             # Implementation Specifications
├── setup.sh               # Installation script
├── CLAUDE.md              # Claude Code configuration
└── LICENSE                # Apache License 2.0
```

## 📋 Available Commands

| Command | Purpose | Output Location |
|---------|---------|----------------|
| `/prometh-prd [description]` | Create strategic PRDs from scratch | `docs/prds/` |
| `/prometh-prd-normalize [file]` | Convert documents to PRD format | `docs/prds/` |
| `/prometh-spec [description]` | Create implementation SPECs from scratch | `docs/specs/` |
| `/prometh-spec-normalize [file]` | Convert documents to SPEC format | `docs/specs/` |
| `/prometh-document [type]` | Generate technical documentation | Current directory |

## 🎨 Output Styles

### PRD Styles (Strategic)
- **prometh-prd-standard**: General strategic requirements and Epic-level planning
- **prometh-prd-feature**: Major feature development with market analysis
- **prometh-prd-bugfix**: Complex issues requiring strategic product decisions

### SPEC Styles (Implementation)
- **prometh-spec-feature**: New feature implementation (user stories)
- **prometh-spec-bugfix**: Bug fixes and defects
- **prometh-spec-enhancement**: Improvements to existing features
- **prometh-spec-task**: Technical/maintenance tasks

### Documentation Styles
- **prometh-readme-standard**: Comprehensive README.md for general repositories
- **prometh-readme-api**: API/library documentation with usage examples
- **prometh-readme-cli**: CLI tool documentation with installation guides
- **prometh-technical-documentation**: Technical documentation for DevOps workflows

## 🔧 Configuration

### Directory Setup
The framework expects the following directory structure:
```bash
mkdir -p docs/{prds,specs,inbox}
```

### Environment Variables
```bash
# Optional: Customize output directories
export PROMETH_PRD_DIR="docs/prds"
export PROMETH_SPEC_DIR="docs/specs"
```

## 📖 Usage Examples

### Creating a Strategic PRD
```bash
# Epic-level initiative
/prometh-prd "Implement microservices architecture migration for improved scalability and team autonomy"
```

### Converting Existing Documents
```bash
# Place document in any location
/prometh-prd-normalize requirements/q4-planning.md

# Or provide content directly
/prometh-prd-normalize "text content here"
```

### Generating Project Documentation
```bash
# Auto-detect project type and generate README
/prometh-document readme

# Generate specific documentation types
/prometh-document architecture
/prometh-document runbook
/prometh-document api
```

## 🤝 Contributing

### Development Setup
1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Test your changes with the setup script
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

### Guidelines
- Follow the existing command structure in `.claude/commands/`
- Test output styles thoroughly before submitting
- Update documentation for new features
- Maintain backward compatibility with existing commands

## 📄 License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🎯 Framework Philosophy

The Prometh Context Framework follows a dual-documentation approach:

- **PRDs (Strategic)**: For Epic-level initiatives requiring cross-functional alignment, market analysis, and business justification
- **SPECs (Implementation)**: For User Story/Task-level documentation that development teams can execute directly

This separation ensures that strategic planning remains focused on business value while implementation details stay practical and actionable.

## 🔗 Related Projects

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) - Official Claude CLI tool
- [Claude API](https://docs.anthropic.com/en/api) - Anthropic's Claude API documentation

---

*Ready to ignite high-quality, predictable output! 🔥*