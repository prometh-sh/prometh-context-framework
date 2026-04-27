---
description: Initialize Prometh Context Framework in a project with validation, directory setup, and manifest initialization
allowed-tools: ["Read", "Write", "Edit", "LS", "Glob", "MultiEdit", "Bash"]
---

# Prometh Framework Initialization Command

You are tasked with initializing the Prometh Context Framework in a project. This command validates the Claude Code setup, creates required directory structure, initializes tracking, and provides helpful next steps.

## Processing Logic

### 0. Directory and Tracking File Resolution (for Existing Projects)

**IMPORTANT**: If the project already has Prometh initialized, resolve existing directories before prompting:

**Directory Resolution:**
```bash
# Check for existing documentation directories
if [ -d "prometh-docs.local" ]; then
  EXISTING_DOCS_DIR="prometh-docs.local"
  DOCS_EXISTS=true
elif [ -d "prometh-docs" ]; then
  EXISTING_DOCS_DIR="prometh-docs"
  DOCS_EXISTS=true
elif [ -d "docs" ]; then
  # Legacy directory from previous version
  LEGACY_DOCS=true
  DOCS_EXISTS=false
else
  DOCS_EXISTS=false
fi
```

**Tracking File Resolution:**
```bash
# Check for existing tracking files
if [ -f "PROMETH.local.md" ]; then
  EXISTING_TRACKING_FILE="PROMETH.local.md"
  TRACKING_EXISTS=true
elif [ -f "PROMETH.md" ]; then
  EXISTING_TRACKING_FILE="PROMETH.md"
  TRACKING_EXISTS=true
else
  TRACKING_EXISTS=false
fi
```

**Priority Rules:**
- `prometh-docs.local/` takes precedence over `prometh-docs/`
- `PROMETH.local.md` takes precedence over `PROMETH.md`
- If either exists, skip prompts and use existing structure
- If legacy `docs/` exists, offer migration (see Migration section below)

### 1. Project Validation

**LIGHTWEIGHT VALIDATION**: Check that the project root is valid (a git repository or has necessary files):

```bash
# Check for basic project indicators
if [ ! -d ".git" ] && [ ! -f "package.json" ] && [ ! -f "pyproject.toml" ]; then
  # Optional check only - warn but don't block
  echo "ℹ️  No git repo or package.json detected. Initializing Prometh anyway..."
fi
```

**Note**: CLAUDE.md or CLAUDE.local.md presence is no longer required. The Prometh Harness Protocol is now stored entirely in the tracking manifest (PROMETH.md / PROMETH.local.md) and read by the agent at session start.

**Proceed to next step.**

### 2. Directory Structure Selection

**Prompt user to choose directory structure:**

```
📁 Prometh Documentation Directory Setup

Which directory structure would you like to create?

1. prometh-docs/ (Committed - Recommended for team projects)
   ✓ Documentation will be tracked in git
   ✓ Shared with all team members
   ✓ Public project history

2. prometh-docs.local/ (Local-only - Recommended for personal projects)
   ✓ Documentation stays on your machine only
   ✓ Not committed to git (added to .gitignore)
   ✓ Private local work

Which option would you like? (1 or 2):
```

**Wait for user selection before proceeding.**

### 3. Directory Structure Creation

Based on user selection, create the required directory structure:

```bash
# Option 1: Committed documentation (user chose 1)
mkdir -p prometh-docs/prds/archive
mkdir -p prometh-docs/specs/archive
mkdir -p prometh-docs/plans
mkdir -p prometh-docs/concepts
mkdir -p prometh-docs/runbooks
mkdir -p prometh-docs/adrs
mkdir -p prometh-docs/contracts/archive
DOCS_DIR="prometh-docs"

# Option 2: Local-only documentation (user chose 2)
mkdir -p prometh-docs.local/prds/archive
mkdir -p prometh-docs.local/specs/archive
mkdir -p prometh-docs.local/plans
mkdir -p prometh-docs.local/concepts
mkdir -p prometh-docs.local/runbooks
mkdir -p prometh-docs.local/adrs
mkdir -p prometh-docs.local/contracts/archive
DOCS_DIR="prometh-docs.local"
```

**Verification:**
- Check that `${DOCS_DIR}/prds/` and `${DOCS_DIR}/prds/archive/` were created successfully
- Check that `${DOCS_DIR}/specs/` and `${DOCS_DIR}/specs/archive/` were created successfully
- Check that `${DOCS_DIR}/plans/` was created successfully
- Check that `${DOCS_DIR}/contracts/archive/` was created successfully
- Archive directories hold `Completed` or `Deprecated` PRDs/SPECs moved out of the active workspace (see lifecycle docs)
- Plans directory holds `PLN-YYYYMMDD-<slug>.md` Pixel Planner project plan files
- Report any creation failures

**Store the selected directory for use in subsequent steps.**

### 4. Tracking File Selection

**Prompt user to choose tracking file type:**

```
📊 Prometh Tracking File Setup

Would you like local-only tracking (not committed to git)?

1. PROMETH.md (Committed - Recommended for team projects)
   ✓ Tracking shared with all team members
   ✓ Project history visible in git

2. PROMETH.local.md (Local-only - Recommended for personal projects)
   ✓ Tracking stays on your machine only
   ✓ Not committed to git (added to .gitignore)

Which option would you like? (1 or 2):
```

**Wait for user selection before proceeding.**

### 5. Tracking File Initialization

Based on user selection, determine tracking file to use:

```bash
# Option 1: Committed tracking (user chose 1)
TRACKING_FILE="PROMETH.md"

# Option 2: Local-only tracking (user chose 2)
TRACKING_FILE="PROMETH.local.md"
```

**Check if tracking file exists:**
- If exists: Update initialization timestamp and validate structure
- If missing: Create new tracking file with complete template

**Tracking File Template:**

**IMPORTANT**: When creating the tracking file, sanitize any private information:
- Use only the project directory name (not full path)
- Extract project name from CLAUDE.md if available
- Never include user home directories or private paths
- Keep content shareable with team members

```markdown
# Prometh Context Framework Status

*Last Updated: [Current Date and Time]*

## Initialization Status

- [x] CLAUDE.md validated ([Date])
- [x] Directory structure created ([Date])  
- [x] Prometh framework initialized ([Date])

## Project Configuration

- **Project Name**: [Extract project name from directory basename, not full path]
- **CLAUDE.md Found**: [Yes/No] 
- **CLAUDE.local.md Found**: [Yes/No]
- **Initialization Date**: [Current Date]

## Document Configuration

*Project-level configuration read by all Prometh skills before creating any document.
Both sub-sections are optional — if absent, skills fall back to legacy defaults.*

### Metadata Template

*YAML frontmatter injected into every new document created inside `prometh-docs/` or
`prometh-docs.local/`. Remove or leave this block empty to disable metadata injection.*

```yaml
author: ""
focus: ""
tags: []
project:
  - name: ""
    uuid: ""
status: Draft
related: []
```

> `title`, `created`, and `uuid` are computed automatically at document creation time
> and are never stored here.

### Filename Patterns

*Filename patterns applied when skills generate new documents. Supported tokens:
`{DATE}` (YYYYMMDD), `{DATETIME}` (YYYYMMDDHHMM), `{NAME}` (slugified title).*

```yaml
prd_pattern: "PRD-{DATE}-{NAME}.md"
spec_pattern: "SPC-{DATE}-{NAME}.md"
concept_pattern: "{DATETIME}-{NAME}.md"
```

> README.md and RUNBOOK.md always use fixed names regardless of this config.
> Remove this block to fall back to legacy patterns (e.g. `mobile-strategy-prd.md`).

## Document Inventory

### Product Requirements Documents (PRDs)
*Strategic, Epic-level initiatives requiring cross-functional alignment*

| File | Created | Status | Linked SPECs | Description | Last Updated |
|------|---------|--------|--------------|-------------|--------------|
| *No PRDs created yet* |

### Implementation Specifications (SPECs)
*Implementation-focused, User Story/Task-level documentation*

| File | Created | Type | Linked PRD | Status | Description | Last Updated |
|------|---------|------|------------|--------|-------------|--------------|
| *No SPECs created yet* |

### Project Plans (Pixel Planner)
*High-level project plans with Gantt timelines, phases, and milestone tracking*

| Plan | Project | Status | Created | Last Updated |
|------|---------|--------|---------|--------------|
| *No plans created yet* |

### Technical Documentation
*Project documentation, runbooks, and operational guides*

| Type | File | Created | Description | Last Updated |
|------|------|---------|-------------|--------------|
| *No documentation created yet* |

## Traceability Matrix

*Relationships between PRDs and their derived SPECs*

| PRD Document | Derived SPECs | Implementation Status |
|--------------|---------------|----------------------|
| *No traceability established yet* |

## Harness Configuration

### Project
- Repository: [Extract from git remote or leave blank]
- Stack: [Placeholder - user to fill in]
- Mode: [committed | local]
- Initialized: [Current Date]

### Guides (Feedforward)
- Concepts: ${DOCS_DIR}/concepts/
- Runbooks: ${DOCS_DIR}/runbooks/
- ADRs: ${DOCS_DIR}/adrs/
- PRDs: ${DOCS_DIR}/prds/
- Specs: ${DOCS_DIR}/specs/
- Plans: ${DOCS_DIR}/plans/

### Sensors (Feedback)

#### Computational (run before commit)
| Sensor | Command | Added |
|--------|---------|-------|
| *No sensors registered yet* |

#### Computational (run in pipeline)
| Sensor | Command | Added |
|--------|---------|-------|
| *No sensors registered yet* |

#### Inferential (run on PR)
| Sensor | Description | Added |
|--------|-------------|-------|
| *No sensors registered yet* |

### Contracts
- Active: *none*
- Directory: ${DOCS_DIR}/contracts/
- Archive: ${DOCS_DIR}/contracts/archive/

### Progress
- File: PROMETH-PROGRESS.local.md (project root, always gitignored)
- Created and managed by: `/prometh-progress` command
- Update: end of each agent session via `/prometh-progress update`
- Note: per-worktree ephemeral state — never committed, never symlinked across worktrees

### Red Flags and Risk Assessment
- Critical: *none registered*
- High: *none registered*
- Medium: *none registered*
- Low: *none registered*

## Harness Protocol

### Session Start
1. Read `${TRACKING_FILE}` at project root for harness configuration
2. Read `PROMETH-PROGRESS.local.md` at project root for current state (per-worktree ephemeral file)
3. If the progress file's `Branch:` field differs from the current git branch, run `/prometh-progress update` before proceeding
4. If an active contract exists in `${DOCS_DIR}/contracts/`, read it
5. Do not begin implementation until progress state is understood

### Session End
1. Update `PROMETH-PROGRESS.local.md` at project root with:
   - What was completed (include commit hashes if applicable)
   - What remains
   - Blockers or decisions pending
   - Codebase state (clean / tests passing / known issues)
2. If a contract is active, note which criteria are now met

### Sensors
Before committing or creating a PR, run these checks:
- *No sensors registered yet - use `/prometh-sensor add` to register*

For the full sensor registry and inferential review instructions,
see the Sensors (Feedback) section in the harness manifest.

## Recent Activity

- **[Current Date]**: Prometh Context Framework initialized

## Next Steps

Run one of these commands to get started:

**Strategic Planning** (`prometh-prd` skill — invoked naturally in conversation):
- *"Create a PRD for [your initiative]"*
- *"Normalize [filename.pdf] into a PRD"*

**Implementation Planning** (`prometh-spec` skill — invoked naturally in conversation):
- *"Create a SPEC for [your task]"*
- *"Convert [filename.md] into a SPEC"*

**Documentation** (`prometh-doc` skill — invoked naturally in conversation):
- *"Generate a README for this project"*
- *"Write an operational runbook"*

---

*Generated with: Prometh Context Framework by Prometh*
```

### 6. Next Steps Guidance

After successful initialization, display context-aware next steps based on project state:

**Success Message (Committed variant example):**
```
✅ Prometh Context Framework Initialized Successfully!

📁 Directory Structure:
  ✓ prometh-docs/prds/     - Strategic Product Requirements Documents (committed)
  ✓ prometh-docs/specs/    - Implementation Specifications (committed)
  ✓ PROMETH.md             - Framework status and tracking (committed)

🎯 Recommended Next Steps:

[Context-specific recommendations based on project state]
```

**Success Message (Local-only variant example):**
```
✅ Prometh Context Framework Initialized Successfully!

📁 Directory Structure:
  ✓ prometh-docs.local/prds/   - Strategic Product Requirements Documents (local-only)
  ✓ prometh-docs.local/specs/  - Implementation Specifications (local-only)
  ✓ PROMETH.local.md           - Framework status and tracking (local-only)

ℹ️  Note: Your documentation will remain local and won't be committed to git.

🎯 Recommended Next Steps:

[Context-specific recommendations based on project state]
```

**Adapt the success message based on user's selections from steps 2 and 4.**

**Context-Aware Recommendations:**

**For Empty Projects (No existing docs):**
```
🚀 Getting Started:

1. Strategic Planning First:
   → say "Create a PRD for [your initiative]" (prometh-prd skill)
   📝 Create your first PRD for Epic-level strategic initiatives

2. Or Jump to Implementation:
   → say "Create a SPEC for [your task]" (prometh-spec skill)
   ⚡ Create implementation SPECs for immediate development tasks

3. Project Documentation:
   → say "Generate a README for this project" (prometh-doc skill)
   📚 Generate comprehensive project documentation
```

**For Projects with Existing Documents:**
```
📋 Document Normalization:

Found existing documents in your project:
• [List found documents that could be normalized]

Recommendations:
1. say "Normalize [document.pdf] into a PRD" (prometh-prd skill)
2. say "Convert [document.md] into a SPEC" (prometh-spec skill)
3. say "Generate a README for this project" (prometh-doc skill)
```

**For Projects with PRDs but no SPECs:**
```
⚡ Implementation Ready:

Found PRDs in ${DOCS_DIR}/prds/:
• [List existing PRD files]

Next Steps:
1. say "Derive a SPEC from ${DOCS_DIR}/prds/[prd-file.md]" (prometh-spec skill)
   🔗 Create implementation SPECs from existing PRDs

2. say "Create a SPEC for [task]" (prometh-spec skill)
   ➕ Create additional implementation SPECs
```

**For Projects with Both PRDs and SPECs:**
```
📈 Project Management:

Your project has strategic documents (PRDs) and implementation plans (SPECs).

Maintenance Tasks:
1. Update document status in PROMETH.md
2. Create new documents as needed:
   • say "Create a PRD for [initiative]" (prometh-prd skill)
   • say "Create a SPEC for [task]" (prometh-spec skill)
   • say "Generate documentation" (prometh-doc skill)

3. Generate documentation:
   • say "Generate a README for this project" (prometh-doc skill)
   • say "Write an operational runbook" (prometh-doc skill)
```

### 5. Error Handling

**Common Error Scenarios:**

**Permission Errors:**
```
❌ Permission Error: Cannot create directory structure
• Check write permissions in current directory
• Run with appropriate permissions or contact system administrator
```

**PROMETH.md Write Errors:**
```
❌ Cannot create or update PROMETH.md
• Verify write permissions in project root
• Check if file is locked or in use by another process
```

**Invalid Project State:**
```
⚠️  Warning: Existing PROMETH.md has invalid structure
• Backing up existing file to PROMETH.md.backup
• Creating new PROMETH.md with correct template
```

### 7. Legacy Directory Migration

**If legacy `docs/` directory detected:**

```
🔄 Legacy Directory Detected

Found existing 'docs/' directory from previous version of Prometh.

Migration Options:

1. Migrate to prometh-docs/ (Committed)
   • Renames docs/ → prometh-docs/
   • Preserves all existing documents
   • Tracked in git

2. Migrate to prometh-docs.local/ (Local-only)
   • Renames docs/ → prometh-docs.local/
   • Preserves all existing documents
   • Not tracked in git

3. Cancel (manual migration)
   • Keep docs/ directory as-is
   • Manually migrate later

Which option would you like? (1, 2, or 3):
```

**Migration Process:**
```bash
# Option 1: Migrate to committed
mv docs prometh-docs
echo "✓ Migrated docs/ → prometh-docs/"

# Option 2: Migrate to local-only
mv docs prometh-docs.local
echo "✓ Migrated docs/ → prometh-docs.local/"

# Option 3: Cancel
echo "ℹ️  Keeping docs/ directory. You can migrate manually later."
echo "   For committed: mv docs prometh-docs"
echo "   For local-only: mv docs prometh-docs.local"
```

**After migration, continue with normal initialization using migrated directory.**

## Instructions

1. **Perform lightweight project validation** - Warn if no git repo or package.json, but don't block
2. **Create directory structure safely** - Check permissions and report issues
3. **Initialize or update PROMETH.md** - Maintain existing data while ensuring correct structure
4. **Do NOT create PROMETH-PROGRESS.local.md** - This file is managed by `/prometh-progress` command
5. **Provide contextual guidance** - Analyze project state and give specific next step recommendations
6. **Handle errors gracefully** - Provide clear error messages and recovery instructions
7. **Report completion status** - Confirm successful initialization with helpful summary

## Example Usage

```bash
# Initialize Prometh in current project
/prometh-init

# Expected output: Validation, setup, initialization, and next steps guidance
```

The command should work in any directory where the user wants to set up Prometh Context Framework, requiring only that Claude Code has already been initialized (CLAUDE.md exists) or that the user creates CLAUDE.local.md for local overrides.