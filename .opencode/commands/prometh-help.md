---
description: Display comprehensive help for all Prometh Context Framework commands with usage examples and workflow guidance.
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

## Available Commands

All commands require AGENTS.md or AGENTS.local.md in project root. Use `/init` if missing.

> **Note**: `prometh-prd`, `prometh-spec`, and `prometh-doc` are **Agent Skills** in OpenCode — the agent loads them automatically when you ask it to create a PRD, SPEC, or documentation. The four workflow commands below are slash commands.

### Framework Setup

#### `/prometh-init`
**Purpose**: Initialize Prometh Context Framework in any project
**Prerequisites**: Requires existing AGENTS.md or AGENTS.local.md (created via `/init`)
**Usage**: `/prometh-init`

**What it does:**
- Prompts you to choose committed or local-only documentation structure
- Creates `prometh-docs/prds/` and `prometh-docs/specs/` (or `.local` variants)
- Initializes PROMETH.md or PROMETH.local.md tracking file for document inventory
- Sets up project-wide documentation workflow
- Provides context-aware guidance based on project state

---

### Strategic Planning (PRDs)

#### `prometh-prd` skill
**Purpose**: Create strategic Product Requirements Documents
**Input Types**: Strategic descriptions, file paths (PDF/markdown/text), interactive prompts
**How to invoke**: Ask the agent directly — e.g. *"Create a PRD for our mobile platform strategy"* or *"Normalize this strategic document into a PRD"*

**Use Cases:**
- Quarterly planning and roadmap initiatives
- Market positioning and competitive strategy
- Cross-functional initiatives requiring alignment
- Major feature launches with business impact
- Strategic technical decisions affecting multiple teams

**Output**: Comprehensive PRD using unified template in `prometh-docs/prds/` (or `prometh-docs.local/prds/`)

---

### Implementation Planning (SPECs)

#### `prometh-spec` skill
**Purpose**: Create implementation specifications with 3-phase workflow
**Input Types**: Implementation descriptions, user stories, bug reports, file paths
**How to invoke**: Ask the agent directly — e.g. *"Create a SPEC from this user story"* or *"Generate SPECs from the PRD"*

**Implementation Types:** Feature/Bug Fix/Enhancement/Technical Task

**3-Phase Workflow:**
- **Phase 1: Planning** - Requirements analysis, technical design, resource planning
- **Phase 2: Task Breakdown** - Detailed development tasks, acceptance criteria, dependency mapping
- **Phase 3: Implementation** - Core development, testing, deployment, validation

**Output**: Comprehensive SPEC using unified template in `prometh-docs/specs/` (or `prometh-docs.local/specs/`)

---

### Documentation Generation

#### `prometh-doc` skill
**Purpose**: Generate technical documentation with auto-analysis
**Types**: `readme`, `runbook`, and `concept` documentation
**How to invoke**: Ask the agent directly — e.g. *"Generate a README for this project"*, *"Create an operational runbook"*, or *"Write concept documentation for onboarding"*

**Features:**
- Analyzes repository structure and system configuration
- Uses unified templates for consistent documentation
- Integrates with existing project context

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

## Workflow Examples

### 1. Strategic Initiative → Implementation
```
# Ask the agent to create a strategic PRD:
"Create a PRD for launching a comprehensive mobile platform for customer self-service"

# Ask the agent to generate implementation SPECs from the PRD:
"Generate implementation SPECs from prometh-docs/prds/mobile-customer-platform-prd.md"
```

Then check project status:
```bash
/prometh-status
```

### 2. Bug Report → SPEC
```
# Ask the agent to convert a bug report to an implementation SPEC:
"Create a SPEC from critical-payment-bug.pdf"

# Ask the agent to generate project documentation:
"Generate a README for this project"
```

### 3. Document Normalization
```
# Ask the agent to normalize existing documents:
"Normalize quarterly-planning-deck.pdf into a PRD"
"Normalize existing-user-story.md into a SPEC"
```

### 4. Complete Implementation Workflow
```
# Step 1 — Ask the agent to create a strategic PRD:
"Create a PRD for launching a comprehensive mobile platform"

# Step 2 — Ask the agent to generate a SPEC from the PRD:
"Create a SPEC from prometh-docs/prds/mobile-platform-prd.md"
```

Then execute and monitor with slash commands:
```bash
# Execute SPEC with guided implementation
/prometh-build prometh-docs/specs/mobile-platform-implementation-spec.md

# Monitor overall project status
/prometh-status
```

---

## Key Features

### ✅ **AGENTS.md Validation**
All commands require AGENTS.md or AGENTS.local.md in project root. Use `/init` to create if missing.

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

### 📁 **Organized Structure**
```
prometh-docs/       # (or prometh-docs.local/)
├── prds/           # Strategic Product Requirements
└── specs/          # Implementation Specifications

PROMETH.md          # Project tracking and inventory (or PROMETH.local.md)
```

### 🔄 **Unified Templates**
- `prometh-prd`: Strategic planning template
- `prometh-spec`: Implementation template with 3-phase workflow
- `prometh-doc-readme`: Project documentation template
- `prometh-doc-runbook`: Operational procedures template
- `prometh-doc-concept`: Technical deep-dive and onboarding template

---

## Installation & Setup

### Quick Setup
```bash
# In your Prometh framework repository
./setup.sh --opencode

# Initialize in any project
/prometh-init
```

### Manual Installation
```bash
# Copy slash commands to your OpenCode directory
cp .opencode/commands/prometh-*.md ~/.config/opencode/commands/

# Copy Agent Skills to your OpenCode skills directory
cp -r .opencode/skills/prometh-*/ ~/.config/opencode/skills/
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
1. **PRD Creation** → Strategic planning and stakeholder alignment (`prometh-prd` skill)
2. **SPEC Generation** → Implementation planning from PRDs (`prometh-spec` skill)
3. **Guided Implementation** → Execute SPEC phases with tracking (`/prometh-build`)
4. **Documentation** → Generate README/runbooks as needed (`prometh-doc` skill)
5. **Status Tracking** → Monitor progress via `/prometh-status`

### Complete Implementation Flow
```
Strategic Vision (PRD) → Implementation Plan (SPEC) → Guided Execution (BUILD) → Delivery
       ↓                        ↓                         ↓                    ↓
  prometh-prd skill        prometh-spec skill        /prometh-build         Completed
```

---

## Troubleshooting

### Common Issues
- **AGENTS.md missing**: Run `/init` to create project configuration
- **Tracking file missing**: Run `/prometh-init` to initialize framework
- **Wrong document type**: The `prometh-prd` and `prometh-spec` skills auto-detect and suggest the correct approach
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
