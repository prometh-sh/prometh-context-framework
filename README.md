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
[![OpenCode](https://img.shields.io/badge/OpenCode-Compatible-blue.svg)](https://opencode.ai/)

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

The framework supports both **Claude Code** and **OpenCode** platforms.

1. **Clone the repository:**
   ```bash
   git clone https://github.com/prometh-sh/prometh-context-framework.git
   cd prometh-context-framework
   ```

2. **Run the setup script:**
   ```bash
   # Interactive mode - choose platform(s)
   ./setup.sh

   # Or specify platform directly
   ./setup.sh --claude      # Claude Code only
   ./setup.sh --opencode    # OpenCode only
   ./setup.sh --all         # Both platforms
   ```

3. **Verify installation:**
   ```bash
   # For Claude Code
   ls ~/.claude/commands/prometh-*

   # For OpenCode
   ls ~/.config/opencode/commands/prometh-*
   ls ~/.config/opencode/skills/prometh-*/SKILL.md
   ```

### Platform Compatibility

| Platform | Status | Configuration File | Commands Location |
|----------|--------|-------------------|-------------------|
| **Claude Code** | ✅ Fully Supported | CLAUDE.md / CLAUDE.local.md | ~/.claude/commands/ |
| **OpenCode** | ✅ Fully Supported | AGENTS.md / AGENTS.local.md | ~/.config/opencode/commands/ + ~/.config/opencode/skills/ |

### Project Initialization

After installing the framework commands, initialize it in any project.

**For Claude Code users:**
```bash
# Navigate to your project directory
cd /path/to/your/project

# Initialize Claude Code in your project (creates CLAUDE.md)
/init

# Initialize Prometh Framework
/prometh-init
```

**For OpenCode users:**
```bash
# Navigate to your project directory
cd /path/to/your/project

# Initialize OpenCode in your project (creates AGENTS.md)
/init

# Initialize Prometh Framework
/prometh-init
```

3. **Verify setup:**
   ```bash
   # Check created directories and tracking file
   # (Will be prometh-docs/ or prometh-docs.local/ depending on your choice)
   ls prometh-docs/prds prometh-docs/specs
   # OR
   ls prometh-docs.local/prds prometh-docs.local/specs

   # Check tracking file (PROMETH.md or PROMETH.local.md)
   ls PROMETH.md
   # OR
   ls PROMETH.local.md
   ```

### Basic Usage

> **Note for OpenCode users**: `prometh-prd`, `prometh-spec`, and `prometh-doc` are Agent Skills — the agent loads them automatically when you ask it to create a PRD, SPEC, or documentation. The four workflow commands (`/prometh-init`, `/prometh-build`, `/prometh-status`, `/prometh-help`) remain slash commands on both platforms.

#### Strategic Planning
```bash
# Claude Code slash command
/prometh-prd

# OpenCode — just ask the agent directly:
# "Create a PRD for our mobile platform strategy"
# (agent loads the prometh-prd skill automatically)
```

#### Implementation Planning
```bash
# Claude Code slash command
/prometh-spec user-story.md

# OpenCode — ask the agent:
# "Create a SPEC from this user story" or "Create a SPEC from the PRD"
```

#### Documentation Generation
```bash
# Claude Code slash commands
/prometh-doc readme
/prometh-doc runbook
/prometh-doc concept

# OpenCode — ask the agent:
# "Generate a README for this project"
# "Create a runbook for this service"
```

#### Implementation Execution
```bash
# Available as a slash command on both platforms
/prometh-build prometh-docs/specs/user-authentication-spec.md

# Resume implementation from last checkpoint
/prometh-build prometh-docs/specs/payment-integration-spec.md
```

#### Status Dashboard
```bash
# Available as a slash command on both platforms
/prometh-status

# Quick summary view
/prometh-status --brief

# Health metrics and suggestions
/prometh-status --health
```

## Project Structure

```
prometh-context-framework/
├── .claude/                   # Claude Code commands and templates
│   ├── commands/              # 7 unified Claude Code commands
│   │   ├── prometh-init.md    # Framework initialization and project setup
│   │   ├── prometh-prd.md     # Strategic PRD creation & normalization
│   │   ├── prometh-spec.md    # Implementation SPEC creation & normalization
│   │   ├── prometh-build.md   # Guided SPEC implementation execution
│   │   ├── prometh-doc.md     # Technical documentation generation
│   │   ├── prometh-status.md  # Project documentation status dashboard
│   │   └── prometh-help.md    # Comprehensive command reference
│   └── output-styles/         # 5 unified templates
│       ├── prometh-prd.md     # Unified PRD template
│       ├── prometh-spec.md    # Unified SPEC template with workflow
│       ├── prometh-doc-readme.md    # Unified README template
│       ├── prometh-doc-runbook.md   # Specialized runbook template
│       └── prometh-doc-concept.md   # Comprehensive concept template
├── .opencode/                 # OpenCode commands and skills
│   ├── commands/              # 4 workflow slash commands
│   │   ├── prometh-init.md    # Framework initialization (AGENTS.md validation)
│   │   ├── prometh-build.md   # Guided SPEC implementation execution
│   │   ├── prometh-status.md  # Project documentation status dashboard
│   │   └── prometh-help.md    # Comprehensive command reference
│   └── skills/                # 3 document-creation Agent Skills
│       ├── prometh-prd/SKILL.md    # Strategic PRD creation (self-contained)
│       ├── prometh-spec/SKILL.md   # Implementation SPEC creation (self-contained)
│       └── prometh-doc/SKILL.md    # Technical documentation generation (3 embedded templates)
├── setup.sh                   # Multi-platform installation script
├── CLAUDE.md                  # Claude Code configuration (example)
├── AGENTS.md                  # OpenCode / general agent configuration
├── PROMETH.md                 # Framework status and document tracking (created by /prometh-init)
└── LICENSE                    # Apache License 2.0
```

## Available Commands

### Slash Commands (both platforms)

| Command | Purpose | Input Types | Output Location |
|---------|---------|-------------|-----------------|
| `/prometh-init` | Initialize framework in project | N/A | Current directory |
| `/prometh-build` | **Execute SPEC with guided implementation** | **SPEC file path (required)** | **PROMETH.md tracking** |
| `/prometh-status` | Display project documentation status dashboard | Optional flags: `--brief`, `--counts`, `--health` | Console output |
| `/prometh-help` | Display comprehensive command reference | N/A | Console output |

### Agent Skills (OpenCode) / Slash Commands (Claude Code)

| Name | Purpose | Input Types | Output Location |
|------|---------|-------------|-----------------|
| `prometh-prd` | Create or normalize strategic PRDs | Descriptions, file paths, interactive | `prometh-docs/prds/` |
| `prometh-spec` | Create or normalize implementation SPECs | User stories, bug reports, file paths, PRD references | `prometh-docs/specs/` |
| `prometh-doc` | Generate technical documentation | `readme`, `runbook`, or `concept` types | Root or `prometh-docs/concepts/` |

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
- **prometh-doc-concept**: Comprehensive concept template for technology, architecture, and domain documentation

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
# Claude Code slash command
/prometh-prd
# Prompt: "Implement microservices architecture migration for improved scalability and team autonomy"
# Output: prometh-docs/prds/microservices-architecture-migration-prd.md

# OpenCode — ask the agent:
# "Create a PRD for microservices architecture migration"
```

### Converting Existing Documents

```bash
# Claude Code
/prometh-prd quarterly-planning-doc.pdf
# Output: prometh-docs/prds/quarterly-planning-initiative-prd.md

/prometh-spec feature-requirements.md
# Output: prometh-docs/specs/feature-user-authentication-spec.md

# OpenCode — ask the agent:
# "Normalize this strategic document into a PRD" (then paste/reference the file)
# "Create a SPEC from feature-requirements.md"
```

### Generating Project Documentation

```bash
# Claude Code slash commands
/prometh-doc readme
/prometh-doc runbook
/prometh-doc concept

# OpenCode — ask the agent:
# "Generate a README for this project"
# "Create an operational runbook"
# "Write concept documentation for onboarding"
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

The framework supports two directory structures:

**Committed Documentation (Team Projects)**
- Directory: `prometh-docs/` - Tracked in git
- Tracking File: `PROMETH.md` - Tracked in git
- Use Case: Team projects with shared documentation

**Local-Only Documentation (Personal Projects)**
- Directory: `prometh-docs.local/` - Not tracked in git (added to .gitignore)
- Tracking File: `PROMETH.local.md` - Not tracked in git
- Use Case: Personal projects, private work, local experiments

**Priority**: If both exist, `.local` variants take precedence.

During `/prometh-init`, you'll be prompted to choose your preferred structure.

## Migrating from Previous Version

If you have an existing `docs/` directory from a previous version of Prometh:

### Automatic Migration (Recommended)

Run `/prometh-init` and it will detect your legacy `docs/` directory and offer migration options:

1. **Migrate to prometh-docs/** (Committed)
   ```bash
   # The command will prompt you to select this option
   # It will automatically: mv docs prometh-docs
   ```

2. **Migrate to prometh-docs.local/** (Local-only)
   ```bash
   # The command will prompt you to select this option
   # It will automatically: mv docs prometh-docs.local
   ```

### Manual Migration

If you prefer to migrate manually:

1. **For committed documentation:**
   ```bash
   # Rename directory
   mv docs prometh-docs

   # PROMETH.md is already correctly named (no change needed)
   ```

2. **For local-only documentation:**
   ```bash
   # Rename directory
   mv docs prometh-docs.local

   # Rename tracking file (if you want local-only tracking)
   mv PROMETH.md PROMETH.local.md

   # Add to .gitignore
   echo "prometh-docs.local/" >> .gitignore
   echo "PROMETH.local.md" >> .gitignore
   ```

3. **Verify the migration:**
   ```bash
   /prometh-status
   # Should display your documentation with the new directory structure
   ```

### Post-Migration Notes

- All documents within the directories remain unchanged
- Tracking file content is preserved
- Commands automatically detect and use the new directory structure
- No manual updates to PROMETH.md are needed

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
- [OpenCode](https://opencode.ai) - Open source AI coding agent for the terminal

---

*Ready to ignite high-quality, predictable output! 🔥*