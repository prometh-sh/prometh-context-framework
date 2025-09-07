```
██████╗ ██████╗  ██████╗ ███╗   ███╗███████╗████████╗██╗  ██╗
██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔════╝╚══██╔══╝██║  ██║
██████╔╝██████╔╝██║   ██║██╔████╔██║█████╗     ██║   ███████║
██╔═══╝ ██╔══██╗██║   ██║██║╚██╔╝██║██╔══╝     ██║   ██╔══██║
██║     ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗   ██║   ██║  ██║
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝
                  CONTEXT FRAMEWORK
```

# Prometh Context Framework

> *"Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."*

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://docs.anthropic.com/en/docs/claude-code)

A comprehensive AI tooling framework that provides structured commands and templates for creating strategic Product Requirements Documents (PRDs), implementation Specifications (SPECs), and technical documentation. Designed to deliver predictable, high-quality output for software development teams.

## Features

### Simplified Command Structure
- **3 Unified Commands**: Down from 5 separate commands for streamlined usage
- **CLAUDE.md Validation**: Mandatory project configuration ensures proper context
- **Smart Input Handling**: Supports file paths, text input, and interactive prompts

### Strategic Planning (PRDs)
- **Epic-Level Documentation**: Comprehensive PRDs for cross-functional initiatives
- **Market Analysis Integration**: Built-in templates for competitive positioning and business justification
- **Stakeholder Alignment**: Structured formats for quarterly planning and strategic decisions
- **Scope Validation**: Automatic detection of strategic vs. tactical content

### Implementation Planning (SPECs)
- **3-Phase Workflow**: Structured Planning → Task Breakdown → Implementation phases
- **User Story Documentation**: Task-level specifications ready for development teams
- **Auto-Classification**: Automatic categorization as Feature/Bug Fix/Enhancement/Task
- **Comprehensive Testing**: Built-in test strategies and acceptance criteria

### Documentation Generation
- **Repository Analysis**: Smart analysis to determine appropriate documentation style
- **Unified Templates**: Single template per documentation type for consistency
- **Multi-Format Support**: README and runbook generation with auto-detection

## Quick Start

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/ivannagy/prometh-context-framework.git
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

### Project Initialization

After installing the framework commands, initialize it in any project:

1. **Initialize Claude Code in your project:**
   ```bash
   # Navigate to your project directory
   cd /path/to/your/project
   
   # Initialize with Claude Code (creates CLAUDE.md)
   /init
   ```

2. **Initialize Prometh Framework:**
   ```bash
   # Set up Prometh tracking and directory structure
   /prometh-init
   ```

3. **Verify setup:**
   ```bash
   # Check created directories and tracking file
   ls docs/prds docs/specs
   ls PROMETH.md
   ```

### Basic Usage

#### Strategic Planning
```bash
# Interactive mode - prompts for strategic description
/prometh-prd

# Create from file - normalizes existing strategic documents  
/prometh-prd strategic-planning-document.pdf

# Text input mode - provide content directly in prompt
/prometh-prd
# Then paste or type your strategic initiative description
```

#### Implementation Planning
```bash
# Interactive mode - prompts for implementation description
/prometh-spec

# Create from user story file
/prometh-spec user-story.md

# Convert bug report to SPEC format
/prometh-spec bug-report.pdf
```

#### Documentation Generation
```bash
# Generate comprehensive README
/prometh-doc readme

# Create operational runbook
/prometh-doc runbook
```

#### Status Dashboard
```bash
# Full project status overview
/prometh-status

# Quick summary view
/prometh-status --brief

# Health metrics and suggestions
/prometh-status --health
```

## Project Structure

```
prometh-context-framework/
├── .claude/
│   ├── commands/              # 5 unified Claude Code commands
│   │   ├── prometh-init.md    # Framework initialization and project setup
│   │   ├── prometh-prd.md     # Strategic PRD creation & normalization
│   │   ├── prometh-spec.md    # Implementation SPEC creation & normalization
│   │   ├── prometh-doc.md     # Technical documentation generation
│   │   └── prometh-status.md  # Project documentation status dashboard
│   └── output-styles/         # 4 unified templates
│       ├── prometh-prd.md     # Unified PRD template
│       ├── prometh-spec.md    # Unified SPEC template with workflow
│       ├── prometh-doc-readme.md    # Unified README template
│       └── prometh-doc-runbook.md   # Specialized runbook template
├── docs/
│   ├── prds/                  # Strategic Product Requirements Documents
│   └── specs/                 # Implementation Specifications
├── setup.sh                   # Installation script
├── CLAUDE.md                  # Claude Code configuration
├── PROMETH.md                 # Framework status and document tracking
└── LICENSE                    # Apache License 2.0
```

## Available Commands

| Command | Purpose | Input Types | Output Location |
|---------|---------|-------------|-----------------|
| `/prometh-init` | Initialize framework in project | N/A | Current directory |
| `/prometh-prd` | Create or normalize strategic PRDs | Descriptions, file paths, interactive | `docs/prds/` |
| `/prometh-spec` | Create or normalize implementation SPECs | User stories, bug reports, file paths, interactive, PRD references | `docs/specs/` |
| `/prometh-doc` | Generate technical documentation | `readme` or `runbook` types | Current directory |
| `/prometh-status` | Display project documentation status dashboard | Optional flags: `--brief`, `--counts`, `--health` | Console output |

## Framework Architecture

### Unified Output Styles

The framework uses 4 simplified templates (reduced from 11):

#### Strategic Documentation
- **prometh-prd**: Unified PRD template handling all strategic scenarios
  - Quarterly planning and roadmap initiatives
  - Market positioning and competitive strategy  
  - Cross-functional initiatives and major feature launches

#### Implementation Documentation
- **prometh-spec**: Unified SPEC template with 3-phase workflow
  - **Phase 1: Planning** - Requirements analysis, technical design, resource planning
  - **Phase 2: Task Breakdown** - Development tasks, acceptance criteria, dependencies
  - **Phase 3: Implementation** - Execution, testing, deployment, validation

#### Technical Documentation
- **prometh-doc-readme**: Comprehensive README template for project documentation
- **prometh-doc-runbook**: Specialized template for operational procedures and troubleshooting

### CLAUDE.md Validation

All commands require `CLAUDE.md` or `CLAUDE.local.md` in the project root:
- **Context Assurance**: Ensures proper project configuration
- **Clear Error Handling**: Guides users to create required configuration files
- **Consistent Behavior**: Standardized validation across all commands

### Smart Classification

- **PRD vs SPEC Detection**: Automatic classification based on strategic vs. tactical content
- **Implementation Type Detection**: Auto-categorizes SPECs as Feature/Bug Fix/Enhancement/Task
- **Scope Validation**: Prevents misclassification and suggests appropriate commands

## Usage Examples

### Creating a Strategic PRD
```bash
# Epic-level initiative
/prometh-prd
# Prompt: "Implement microservices architecture migration for improved scalability and team autonomy"
# Output: docs/prds/microservices-architecture-migration-prd.md
```

### Converting Existing Documents
```bash
# Normalize strategic document from file
/prometh-prd quarterly-planning-doc.pdf
# Output: docs/prds/quarterly-planning-initiative-prd.md

# Normalize implementation requirements  
/prometh-spec feature-requirements.md
# Output: docs/specs/feature-user-authentication-spec.md
```

### Generating Project Documentation
```bash
# Auto-detect project type and generate README
/prometh-doc readme
# Analyzes repository structure and creates comprehensive README.md

# Generate operational runbook
/prometh-doc runbook  
# Creates runbook based on system configuration analysis
```

## 3-Phase SPEC Workflow

All implementation SPECs include a structured workflow:

### Phase 1: Planning
- [ ] Requirements analysis and clarification
- [ ] Technical design and architecture decisions
- [ ] Resource allocation and timeline estimation

### Phase 2: Task Breakdown
- [ ] Create detailed development tasks
- [ ] Define acceptance criteria for each task
- [ ] Identify dependencies and risk factors

### Phase 3: Implementation
- [ ] Execute development tasks in priority order
- [ ] Perform testing and quality assurance
- [ ] Deploy and validate in production environment

## Configuration

### CLAUDE.md Requirement
Initialize your project with Claude Code to create the required configuration:
```bash
# Initialize project with Claude Code (creates CLAUDE.md)
/init

# Or create local override file manually if needed
touch CLAUDE.local.md
```

### Directory Setup
The framework automatically creates required directories:
- `docs/prds/` - Strategic Product Requirements Documents
- `docs/specs/` - Implementation Specifications

## Migration from Previous Version

If upgrading from a previous version:

### Changes Made
- **Commands Simplified**: `/prometh-prd-normalize` and `/prometh-spec-normalize` merged into main commands
- **Output Styles Unified**: 11 separate styles consolidated into 4 unified templates  
- **CLAUDE.md Required**: New mandatory validation for all commands
- **Enhanced Workflows**: SPECs now include 3-phase implementation structure

### Migration Steps
1. Run `./setup.sh` to install updated commands and templates
2. Add `CLAUDE.md` file to your projects
3. Existing documents remain compatible - no changes needed

## Contributing

### Development Setup
1. Fork the repository
2. Create your feature branch: `git checkout -b feature/amazing-feature`
3. Test your changes with the setup script
4. Commit your changes: `git commit -m 'Add amazing feature'`
5. Push to the branch: `git push origin feature/amazing-feature`
6. Open a Pull Request

### Guidelines
- Follow the unified command structure in `.claude/commands/`
- Test output styles thoroughly before submitting
- Update documentation for new features
- Maintain backward compatibility with existing functionality

## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## Framework Philosophy

The Prometh Context Framework follows a dual-documentation approach:

- **PRDs (Strategic)**: For Epic-level initiatives requiring cross-functional alignment, market analysis, and business justification
- **SPECs (Implementation)**: For User Story/Task-level documentation that development teams can execute directly with structured 3-phase workflow

This separation ensures that strategic planning remains focused on business value while implementation details stay practical and actionable.

## Key Benefits

### Simplified Usage
- **5 Commands**: Includes initialization, status dashboard, and 3 core document commands for complete workflow
- **Unified Templates**: Single template per command type reduces complexity
- **Smart Input**: Handles files, text, and interactive input seamlessly

### Enhanced Quality  
- **Status Dashboard**: Real-time visibility into documentation health and progress
- **3-Phase Workflow**: Structured implementation approach for SPECs
- **Auto-Classification**: Prevents document type confusion
- **Traceability Matrix**: Links between strategic PRDs and implementation SPECs

### Consistent Output
- **Unified Templates**: Predictable structure across all document types
- **Professional Standards**: Enterprise-ready documentation formatting
- **Attribution Included**: All documents credit the Prometh Context Framework

## Related Projects

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) - Official Claude CLI tool
- [Claude API](https://docs.anthropic.com/en/api) - Anthropic's Claude API documentation

---

*Ready to ignite high-quality, predictable output! 🔥*