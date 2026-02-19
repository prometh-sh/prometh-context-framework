---
description: Initialize Prometh Context Framework in a project with validation and directory setup
---

# Prometh Framework Initialization Command

You are tasked with initializing the Prometh Context Framework in a project. This command validates the OpenCode setup, creates required directory structure, initializes tracking, and provides helpful next steps.

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

### 1. AGENTS.md Validation

**MANDATORY FIRST STEP**: Check for AGENTS.md or AGENTS.local.md in the project root:

```bash
# Check for required configuration files
ls AGENTS.md AGENTS.local.md 2>/dev/null
```

**If NEITHER file exists:**
```
❌ Prometh Context Framework Error

AGENTS.md or AGENTS.local.md not found in project root.

Please initialize your project with OpenCode first:
• Run '/init' in OpenCode to create AGENTS.md with project configuration
• Or create AGENTS.local.md for local development overrides

These files are required for Prometh commands to ensure proper context and configuration.

Learn more: https://opencode.ai/docs/

After creating AGENTS.md, run '/prometh-init' again to continue setup.
```

**If files exist, proceed to next step.**

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
mkdir -p prometh-docs/prds
mkdir -p prometh-docs/specs
DOCS_DIR="prometh-docs"

# Option 2: Local-only documentation (user chose 2)
mkdir -p prometh-docs.local/prds
mkdir -p prometh-docs.local/specs
DOCS_DIR="prometh-docs.local"
```

**Verification:**
- Check that `${DOCS_DIR}/prds/` was created successfully
- Check that `${DOCS_DIR}/specs/` was created successfully
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
- Extract project name from AGENTS.md if available
- Never include user home directories or private paths
- Keep content shareable with team members

```markdown
# Prometh Context Framework Status

*Last Updated: [Current Date and Time]*

## Initialization Status

- [x] AGENTS.md validated ([Date])
- [x] Directory structure created ([Date])
- [x] Prometh framework initialized ([Date])

## Project Configuration

- **Project Name**: [Extract project name from directory basename, not full path]
- **AGENTS.md Found**: [Yes/No]
- **AGENTS.local.md Found**: [Yes/No]
- **Initialization Date**: [Current Date]

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

## Recent Activity

- **[Current Date]**: Prometh Context Framework initialized

## Next Steps

Run one of these commands to get started:

**Strategic Planning:**
- `/prometh-prd` - Create new strategic PRD from description
- `/prometh-prd [filename.pdf]` - Normalize existing strategic document

**Implementation Planning:**
- `/prometh-spec` - Create new implementation SPEC from description
- `/prometh-spec [filename.md]` - Normalize existing implementation document

**Documentation:**
- `/prometh-doc readme` - Generate comprehensive project README
- `/prometh-doc runbook` - Create operational runbook

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
   /prometh-prd
   📝 Create your first PRD for Epic-level strategic initiatives

2. Or Jump to Implementation:
   /prometh-spec
   ⚡ Create implementation SPECs for immediate development tasks

3. Project Documentation:
   /prometh-doc readme
   📚 Generate comprehensive project documentation
```

**For Projects with Existing Documents:**
```
📋 Document Normalization:

Found existing documents in your project:
• [List found documents that could be normalized]

Recommendations:
1. /prometh-prd [document.pdf]    - Normalize strategic documents to PRD format
2. /prometh-spec [document.md]    - Convert requirements to SPEC format
3. /prometh-doc readme           - Generate updated project documentation
```

**For Projects with PRDs but no SPECs:**
```
⚡ Implementation Ready:

Found PRDs in ${DOCS_DIR}/prds/:
• [List existing PRD files]

Next Steps:
1. /prometh-spec --from-prd ${DOCS_DIR}/prds/[prd-file.md]
   🔗 Create implementation SPECs from existing PRDs

2. /prometh-spec
   ➕ Create additional implementation SPECs
```

**For Projects with Both PRDs and SPECs:**
```
📈 Project Management:

Your project has strategic documents (PRDs) and implementation plans (SPECs).

Maintenance Tasks:
1. Update document status in PROMETH.md
2. Create new documents as needed:
   • /prometh-prd    - New strategic initiatives
   • /prometh-spec   - New implementation tasks
   • /prometh-doc    - Technical documentation

3. Generate documentation:
   • /prometh-doc readme   - Update project README
   • /prometh-doc runbook  - Create operational guides
```

### 7. Error Handling

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

### 8. Legacy Directory Migration

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

1. **Always validate AGENTS.md first** - This is the foundation requirement
2. **Create directory structure safely** - Check permissions and report issues
3. **Initialize or update PROMETH.md** - Maintain existing data while ensuring correct structure
4. **Provide contextual guidance** - Analyze project state and give specific next step recommendations
5. **Handle errors gracefully** - Provide clear error messages and recovery instructions
6. **Report completion status** - Confirm successful initialization with helpful summary

## Example Usage

```bash
# Initialize Prometh in current project
/prometh-init

# Expected output: Validation, setup, initialization, and next steps guidance
```

The command should work in any directory where the user wants to set up Prometh Context Framework, requiring only that OpenCode has already been initialized (AGENTS.md exists) or that the user creates AGENTS.local.md for local overrides.
