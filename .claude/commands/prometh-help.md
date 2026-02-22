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
- `/prometh-status --health` - Health metrics and suggestions

**Dashboard Features:**
- Document inventory summary (PRDs, SPECs, documentation)
- Recent activity feed with chronological updates
- Traceability matrix showing PRD → SPEC relationships
- Health metrics and context-aware next step suggestions

---

## Available Skills

Skills can be invoked explicitly via slash commands OR contextually — just describe what you need in conversation and Claude will load the appropriate skill automatically.

### Strategic Planning (PRDs) — `prometh-prd` skill

**Purpose**: Create strategic Product Requirements Documents
**Input Types**: Strategic descriptions, file paths (PDF/markdown/text), interactive prompts
**Usage**:
- `/prometh-prd` — Interactive mode with prompts
- `/prometh-prd strategic-document.pdf` — Normalize existing file
- `/prometh-prd` + paste strategic content — Process text input
- Or naturally: *"Create a PRD for our new mobile platform"*

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
**Usage**:
- `/prometh-spec` — Interactive mode with prompts
- `/prometh-spec user-story.md` — Normalize existing file
- `/prometh-spec --from-prd mobile-strategy-prd.md` — Generate SPECs from PRD
- `/prometh-spec` + paste implementation requirements — Process text input
- Or naturally: *"Create a SPEC for the user authentication feature"*

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
**Usage**:
- `/prometh-doc readme` — Generate comprehensive README.md
- `/prometh-doc runbook` — Generate operational runbook
- `/prometh-doc concept` — Generate deep-dive concept documentation
- `/prometh-doc` — Interactive menu to select type
- Or naturally: *"Generate a README for this project"*

**Features:**
- Analyzes repository structure and system configuration
- Uses unified templates for consistent documentation
- Integrates with existing project context

---

## Workflow Examples

### 1. Strategic Initiative → Implementation
```bash
# Create strategic PRD (skill invoked via slash or naturally)
/prometh-prd
# Input: "Launch comprehensive mobile platform for customer self-service"

# Generate implementation SPECs from PRD
/prometh-spec --from-prd prometh-docs/prds/mobile-customer-platform-prd.md

# Check project status
/prometh-status
```

### 2. Bug Report → SPEC
```bash
# Convert bug report to implementation SPEC
/prometh-spec critical-payment-bug.pdf

# Generate project documentation
/prometh-doc readme
```

### 3. Document Normalization
```bash
# Normalize existing strategic document
/prometh-prd quarterly-planning-deck.pdf

# Normalize existing user story
/prometh-spec existing-user-story.md
```

### 4. Complete Implementation Workflow
```bash
# Create strategic PRD
/prometh-prd
# Input: "Launch comprehensive mobile platform"

# Generate implementation SPEC from PRD
/prometh-spec --from-prd prometh-docs/prds/mobile-platform-prd.md

# Execute SPEC with guided implementation
/prometh-build prometh-docs/specs/mobile-platform-implementation-spec.md

# Monitor overall project status
/prometh-status
```

### 5. Generate Concept Documentation
```bash
# Deep-dive documentation for new team members / architecture review
/prometh-doc concept
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
1. **PRD Creation** → Strategic planning and stakeholder alignment (`/prometh-prd`)
2. **SPEC Generation** → Implementation planning from PRDs (`/prometh-spec`)
3. **Guided Implementation** → Execute SPEC phases with tracking (`/prometh-build`) 
4. **Documentation** → Generate README/runbooks as needed (`/prometh-doc`)
5. **Status Tracking** → Monitor progress via `/prometh-status`

### Complete Implementation Flow
```
Strategic Vision (PRD) → Implementation Plan (SPEC) → Guided Execution (BUILD) → Delivery
       ↓                        ↓                         ↓                    ↓
  /prometh-prd            /prometh-spec            /prometh-build         Completed
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