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

### Complete Implementation Workflow
- **End-to-End Lifecycle**: From strategic vision to guided delivery
- **6 Unified Commands**: Streamlined workflow with comprehensive tracking
- **CLAUDE.md Validation**: Mandatory project configuration ensures proper context
- **Smart Input Handling**: Supports file paths, text input, and interactive prompts

### Strategic Planning (PRDs)
- **Epic-Level Documentation**: Comprehensive PRDs for cross-functional initiatives
- **Market Analysis Integration**: Built-in templates for competitive positioning and business justification
- **Stakeholder Alignment**: Structured formats for quarterly planning and strategic decisions
- **Scope Validation**: Automatic detection of strategic vs. tactical content

### Implementation Planning & Execution (SPECs + BUILD)
- **3-Phase Workflow**: Structured Planning → Task Breakdown → Implementation phases
- **Guided Implementation**: Interactive execution with progress tracking (`/prometh-build`)
- **User Story Documentation**: Task-level specifications ready for development teams
- **Auto-Classification**: Automatic categorization as Feature/Bug Fix/Enhancement/Task
- **Comprehensive Testing**: Built-in test strategies and acceptance criteria
- **Complete Traceability**: Full visibility from strategic vision to delivery

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

#### Implementation Execution
```bash
# Execute SPEC with guided workflow
/prometh-build docs/specs/user-authentication-spec.md

# Resume implementation from last checkpoint
/prometh-build docs/specs/payment-integration-spec.md
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
│   ├── commands/              # 6 unified Claude Code commands
│   │   ├── prometh-init.md    # Framework initialization and project setup
│   │   ├── prometh-prd.md     # Strategic PRD creation & normalization
│   │   ├── prometh-spec.md    # Implementation SPEC creation & normalization
│   │   ├── prometh-build.md   # Guided SPEC implementation execution
│   │   ├── prometh-doc.md     # Technical documentation generation
│   │   ├── prometh-status.md  # Project documentation status dashboard
│   │   └── prometh-help.md    # Comprehensive command reference
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
| `/prometh-build` | **Execute SPEC with guided implementation** | **SPEC file path (required)** | **PROMETH.md tracking** |
| `/prometh-doc` | Generate technical documentation | `readme` or `runbook` types | Current directory |
| `/prometh-status` | Display project documentation status dashboard | Optional flags: `--brief`, `--counts`, `--health` | Console output |
| `/prometh-help` | Display comprehensive command reference | N/A | Console output |

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

## Complete Implementation Workflow

**Your complete workflow is now:**
```
/prometh-prd → /prometh-spec → /prometh-build → Delivery
Strategic      Implementation    Guided          Complete
Vision         Planning          Execution       Traceability
```

### Phase 1: Strategic Planning (`/prometh-prd`)
- Create strategic PRDs for Epic-level initiatives
- Market analysis and business justification
- Cross-functional alignment and stakeholder buy-in

### Phase 2: Implementation Planning (`/prometh-spec`)
- Convert PRDs into actionable SPECs
- 3-phase workflow structure (Planning → Task Breakdown → Implementation)
- Detailed acceptance criteria and technical requirements

### Phase 3: Guided Execution (`/prometh-build`)
- Interactive implementation tracking through SPEC phases
- Real-time progress updates in PROMETH.md
- Phase transition validation and milestone tracking
- Complete traceability from strategic vision to delivery

### 3-Phase SPEC Implementation Workflow

When using `/prometh-build`, you'll be guided through:

#### Phase 1: Planning
- [ ] Requirements analysis and clarification
- [ ] Technical design and architecture decisions  
- [ ] Resource allocation and timeline estimation
- [ ] Deliverable validation and sign-off

#### Phase 2: Task Breakdown
- [ ] Create detailed development tasks with priorities
- [ ] Define acceptance criteria for each task
- [ ] Identify dependencies and critical path
- [ ] Risk assessment and mitigation planning

#### Phase 3: Implementation
- [ ] Execute development tasks in priority order
- [ ] Perform integration testing and quality assurance
- [ ] Deploy to staging and production environments
- [ ] Validate against original SPEC acceptance criteria

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

### Complete Workflow Coverage
- **6 Commands**: End-to-end lifecycle from strategic planning to guided delivery
- **Interactive Execution**: `/prometh-build` provides guided implementation with progress tracking
- **Unified Templates**: Single template per command type reduces complexity
- **Smart Input**: Handles files, text, and interactive input seamlessly

### Enhanced Quality  
- **Status Dashboard**: Real-time visibility into documentation health and progress
- **Guided Implementation**: Interactive execution with `/prometh-build` for SPECs
- **3-Phase Workflow**: Structured implementation approach with progress tracking
- **Auto-Classification**: Prevents document type confusion
- **Complete Traceability**: Full visibility from strategic PRDs through SPEC execution to delivery

### Consistent Output
- **Unified Templates**: Predictable structure across all document types
- **Professional Standards**: Enterprise-ready documentation formatting
- **Attribution Included**: All documents credit the Prometh Context Framework

## Related Projects

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) - Official Claude CLI tool
- [Claude API](https://docs.anthropic.com/en/api) - Anthropic's Claude API documentation

---

*Ready to ignite high-quality, predictable output! 🔥*