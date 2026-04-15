---
description: Display comprehensive help for all Prometh Context Framework commands with usage examples and workflow guidance.
argument-hint: ""
allowed-tools: []
---

# Prometh Context Framework - Help & Command Reference

## 🔥 Prometh Context Framework
*Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output.*

The Prometh Context Framework provides structured documentation workflows for strategic planning (PRDs) and implementation specifications (SPECs) with integrated project tracking.

---

## Directory Structure Variants

The framework supports two directory structures:

**Committed Documentation** (Team Projects):
- `prometh-docs/` - Documentation tracked in git and shared with team
- `PROMETH.md` - Tracking file tracked in git

**Local-Only Documentation** (Personal Projects):
- `prometh-docs.local/` - Documentation stays local, not committed
- `PROMETH.local.md` - Tracking file stays local, not committed

**Priority**: If both exist, `.local` variants take precedence and non-local versions are ignored.

---

## Available Slash Commands

All slash commands require PROMETH.md or PROMETH.local.md in project root. Use `/prometh-init` if missing.

### Framework Setup

#### `/prometh-init`
**Purpose**: Initialize Prometh Context Framework in any project
**Prerequisites**: Requires existing CLAUDE.md or CLAUDE.local.md (created via `/init`)
**Usage**: `/prometh-init`

**What it does:**
- Prompts you to choose committed or local-only documentation structure
- Creates `prometh-docs/prds/` and `prometh-docs/specs/` (or `.local` variants)
- Initializes PROMETH.md or PROMETH.local.md tracking file for document inventory
- Sets up project-wide documentation workflow
- Provides context-aware guidance based on project state

---

### Implementation Execution

#### `/prometh-build`
**Purpose**: Execute SPEC implementation with 3-phase workflow tracking  
**Input**: SPEC file path (required)  
**Usage**: `/prometh-build prometh-docs/specs/user-authentication-spec.md` (or `prometh-docs.local/specs/...`)

**3-Phase Execution:**
- **Phase 1: Planning** - Interactive task completion for requirements analysis and technical design
- **Phase 2: Task Breakdown** - Detailed development tasks and dependency mapping  
- **Phase 3: Implementation** - Core development, testing, and deployment validation

**Features:**
- Interactive progress tracking with task completion
- Tracking file status updates (Draft → Planning → Implementation → Completed)
- Phase transition validation and milestone tracking
- Resume sessions from last checkpoint
- Complete traceability back to original PRD

**Output**: Guided implementation workflow with comprehensive progress tracking

---

### Project Status & Tracking

#### `/prometh-status`
**Purpose**: Display comprehensive project documentation dashboard  
**Usage**:
- `/prometh-status` - Full status dashboard
- `/prometh-status --brief` - Condensed view
- `/prometh-status --counts` - Document counts only
- `/prometh-status --health` - Health metrics + harness readiness scorecard (adopted projects)
- `/prometh-status --harness` - Harness readiness scorecard only (13 checks across Guides, Sensors, Contracts, Progress, Codebase)
- `/prometh-status --include-archive` - Also include `prds/archive/` and `specs/archive/` (combinable with other flags)

**Dashboard Features:**
- Document inventory summary (PRDs, SPECs, documentation)
- Recent activity feed with chronological updates
- Traceability matrix showing PRD → SPEC relationships
- Harness panel: active contract, progress summary, sensor counts, agent-file sync check
- Health metrics and context-aware next step suggestions

---

## Harness Engineering Commands

These commands close the feedback loop around the feedforward guides above. They manage the progress file (cross-session memory), contracts (testable definitions of done), feedback sensors, and contract evaluation.

#### `/prometh-progress [update|reset]`
**Purpose**: View or update the progress file that bridges context windows
**Usage**:
- `/prometh-progress` - Display current progress state
- `/prometh-progress update` - Refresh progress from git log, diff, and active contract
- `/prometh-progress reset` - Reset progress to an initial template (with confirmation)

#### `/prometh-contract <name>`
**Purpose**: Generate a sprint or feature contract with testable acceptance criteria
**Usage**:
- `/prometh-contract sprint-7` - Create a contract named sprint-7
- `/prometh-contract auth-rewrite` - Create a feature contract

**Contract contents**: metadata, scope, acceptance criteria table (with verification method and type — computational/inferential/manual), required sensors, out of scope, red flags and risk assessment.

#### `/prometh-eval [contract-name]`
**Purpose**: Evaluate the codebase against an active contract's acceptance criteria
**Usage**:
- `/prometh-eval` - Evaluate the active contract
- `/prometh-eval sprint-7` - Evaluate a specific contract

Runs each criterion (computational checks via their verification command, inferential via semantic analysis, manual flagged for human) and writes Status updates, Evaluation Notes, and an Evaluation Summary back into the contract plus a summary into `PROMETH-PROGRESS.local.md`.

#### `/prometh-sensor add <name> <cmd> --type <t> --when <w>`
**Purpose**: Register a feedback sensor in the harness
**Usage**:
- `/prometh-sensor add terraform-validate "mise run terraform:validate" --type computational --when pre-commit`
- `/prometh-sensor add terratest "mise run terraform:test" --type computational --when pipeline`
- `/prometh-sensor add arch-review "Review against concept doc" --type inferential --when pre-pr`

Computational pre-commit sensors are dual-written to both the harness manifest and the `### Sensors` block in `CLAUDE.md` / `AGENTS.md` so the agent runs them every session.

#### `/prometh-sensor list`
**Purpose**: Display all registered sensors grouped by timing (pre-commit, pipeline, pre-pr).

#### `/prometh-sensor remove <name>`
**Purpose**: Remove a sensor from the harness (removes from both manifest and agent file if applicable).

---

## Available Skills

Skills are invoked contextually — describe what you need in conversation and Claude loads the right skill automatically. There is no `/prometh-prd`, `/prometh-spec`, or `/prometh-doc` slash command.

### Strategic Planning (PRDs) — `prometh-prd` skill

**Purpose**: Create strategic Product Requirements Documents
**Input Types**: Strategic descriptions, file paths (PDF/markdown/text), interactive prompts
**How to invoke** (natural conversation):
- *"Create a PRD for our new mobile platform"*
- *"Normalize this strategic document into a PRD"* (then paste or reference the file)
- *"Convert quarterly-planning.pdf into a PRD"*

**Use Cases:**
- Quarterly planning and roadmap initiatives
- Market positioning and competitive strategy
- Cross-functional initiatives requiring alignment
- Major feature launches with business impact
- Strategic technical decisions affecting multiple teams

**Output**: Comprehensive PRD using unified `prometh-prd` template in `prometh-docs/prds/` (or `prometh-docs.local/prds/`)

---

### Implementation Planning (SPECs) — `prometh-spec` skill

**Purpose**: Create implementation specifications with 3-phase workflow
**Input Types**: Implementation descriptions, user stories, bug reports, file paths
**How to invoke** (natural conversation):
- *"Create a SPEC for the user authentication feature"*
- *"Normalize this user story into a SPEC"* (then paste or reference the file)
- *"Derive a SPEC from prometh-docs/prds/mobile-strategy-prd.md"*
- *"Convert this bug report into a SPEC"*

**Implementation Types:** Feature/Bug Fix/Enhancement/Technical Task

**3-Phase Workflow:**
- **Phase 1: Planning** - Requirements analysis, technical design, resource planning
- **Phase 2: Task Breakdown** - Detailed development tasks, acceptance criteria, dependency mapping
- **Phase 3: Implementation** - Core development, testing, deployment, validation

**Output**: Comprehensive SPEC using unified `prometh-spec` template in `prometh-docs/specs/` (or `prometh-docs.local/specs/`)

---

### Documentation Generation — `prometh-doc` skill

**Purpose**: Generate technical documentation with auto-analysis
**Types**: `readme`, `runbook`, and `concept` documentation
**How to invoke** (natural conversation):
- *"Generate a README for this project"*
- *"Write an operational runbook for the deployment process"*
- *"Write concept documentation for new team members"*
- *"Generate documentation"* — triggers interactive type selection

**Features:**
- Analyzes repository structure and system configuration
- Uses unified templates for consistent documentation
- Integrates with existing project context

---

## Workflow Examples

### 1. Strategic Initiative → Implementation
```
# 1. Create strategic PRD (say this in conversation)
"Create a PRD for our mobile platform for customer self-service"
→ prometh-prd skill creates: prometh-docs/prds/PRD-20260223-mobile-platform.md

# 2. Generate implementation SPEC from PRD (say this in conversation)
"Derive a SPEC from prometh-docs/prds/PRD-20260223-mobile-platform.md"
→ prometh-spec skill creates: prometh-docs/specs/SPC-20260223-mobile-platform.md

# 3. Check project status (slash command)
/prometh-status
```

### 2. Bug Report → SPEC
```
# Convert bug report to implementation SPEC (say this in conversation)
"Convert critical-payment-bug.pdf into a SPEC"
→ prometh-spec skill creates SPEC

# Generate project documentation (say this in conversation)
"Generate a README for this project"
→ prometh-doc skill creates README.md
```

### 3. Document Normalization
```
# Normalize existing strategic document (say this in conversation)
"Normalize quarterly-planning-deck.pdf into a PRD"
→ prometh-prd skill normalizes into PRD format

# Normalize existing user story (say this in conversation)
"Convert existing-user-story.md into a SPEC"
→ prometh-spec skill normalizes into SPEC format
```

### 4. Complete Implementation Workflow
```
# 1. Create strategic PRD (say this in conversation)
"Create a PRD for our mobile platform"
→ prometh-prd skill creates PRD

# 2. Derive implementation SPEC from PRD (say this in conversation)
"Derive a SPEC from prometh-docs/prds/PRD-20260223-mobile-platform.md"
→ prometh-spec skill creates SPEC

# 3. Execute SPEC with guided implementation (slash command)
/prometh-build prometh-docs/specs/SPC-20260223-mobile-platform.md

# 4. Monitor overall project status (slash command)
/prometh-status
```

### 5. Generate Concept Documentation
```
# Deep-dive documentation for new team members (say this in conversation)
"Write concept documentation for new team members"
→ prometh-doc skill creates concept doc in prometh-docs/concepts/
```

---

## Key Features

### ✅ **CLAUDE.md Validation**
All commands and skills require CLAUDE.md or CLAUDE.local.md in project root. Use `/init` to create if missing.

### 📊 **Integrated Tracking**
Tracking files (PROMETH.md or PROMETH.local.md) maintain:
- Complete document inventory with status tracking
- Traceability matrix linking PRDs to SPECs
- Recent activity log with chronological updates
- Context-aware next step suggestions

### 🎯 **Intelligent Classification**
- Automatic PRD vs SPEC scope detection
- Implementation type classification (Feature/Bug/Enhancement/Task)
- Content validation and workflow guidance
- Skills auto-invoked based on conversation context

### 📁 **Organized Structure**
```
prometh-docs/       # (or prometh-docs.local/)
├── prds/           # Strategic Product Requirements
├── specs/          # Implementation Specifications
└── concepts/       # Concept documentation

PROMETH.md          # Project tracking and inventory (or PROMETH.local.md)
```

### 🔄 **Unified Templates**
- `prometh-prd`: Strategic planning template
- `prometh-spec`: Implementation template with 3-phase workflow
- `prometh-doc-readme`: Project documentation template
- `prometh-doc-runbook`: Operational procedures template
- `prometh-doc-concept`: Technology stack, architecture, and domain concept documentation

---

## Installation & Setup

### Quick Setup
```bash
# In your Prometh framework repository
./setup.sh

# Initialize in any project
/prometh-init
```

### Manual Installation
```bash
# Copy to your Claude Code directory
cp -r .claude/skills/prometh-*/  ~/.claude/skills/
cp .claude/output-styles/prometh-*.md ~/.claude/output-styles/
cp .claude/commands/prometh-*.md ~/.claude/commands/
```

---

## Best Practices

### When to Use PRDs
- Strategic initiatives requiring business justification
- Cross-functional projects needing stakeholder alignment  
- Market-driven feature development
- Complex technical decisions with business impact

### When to Use SPECs
- Feature implementation and development tasks
- Bug fixes and system enhancements
- Technical debt and refactoring projects
- User stories requiring detailed implementation

### Document Lifecycle
1. **PRD Creation** → Strategic planning and stakeholder alignment (`prometh-prd` skill — invoked naturally)
2. **SPEC Generation** → Implementation planning from PRDs (`prometh-spec` skill — invoked naturally)
3. **Guided Implementation** → Execute SPEC phases with tracking (`/prometh-build` slash command)
4. **Documentation** → Generate README/runbooks as needed (`prometh-doc` skill — invoked naturally)
5. **Status Tracking** → Monitor progress via `/prometh-status` slash command

### Complete Implementation Flow
```
Strategic Vision (PRD) → Implementation Plan (SPEC) → Guided Execution (BUILD) → Delivery
       ↓                        ↓                            ↓                       ↓
  prometh-prd skill        prometh-spec skill          /prometh-build            Completed
  (conversation)           (conversation)              (slash command)
```

---

## Troubleshooting

### Common Issues
- **CLAUDE.md missing**: Run `/init` to create project configuration
- **Tracking file missing**: Run `/prometh-init` to initialize framework
- **Wrong document type**: Framework auto-detects and suggests correct command
- **File access errors**: Check file permissions and paths

### Getting Help
- Use `/prometh-help` for this reference
- Check tracking file (PROMETH.md or PROMETH.local.md) for project-specific guidance
- View `/prometh-status` for context-aware next steps

---

## Framework Philosophy

The Prometh Context Framework separates strategic thinking (PRDs) from implementation execution (SPECs), ensuring:
- **Clear scope boundaries** between business strategy and technical implementation
- **Traceability** from strategic initiatives to delivered features
- **Predictable workflows** that scale across teams and projects
- **Quality documentation** that serves both planning and execution phases

---

*Generated with: **Prometh Context Framework by Prometh***