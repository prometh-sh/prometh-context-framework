---
description: Initialize Prometh Context Framework in a project with validation and directory setup
allowed-tools: Read, Write, LS, Glob, MultiEdit, Bash
---

# Prometh Framework Initialization Command

You are tasked with initializing the Prometh Context Framework in a project. This command validates the Claude Code setup, creates required directory structure, initializes tracking, and provides helpful next steps.

## Processing Logic

### 1. CLAUDE.md Validation

**MANDATORY FIRST STEP**: Check for CLAUDE.md or CLAUDE.local.md in the project root:

```bash
# Check for required configuration files
ls CLAUDE.md CLAUDE.local.md 2>/dev/null
```

**If NEITHER file exists:**
```
❌ Prometh Context Framework Error

CLAUDE.md or CLAUDE.local.md not found in project root.

Please initialize your project with Claude Code first:
• Run '/init' in Claude Code to create CLAUDE.md with project configuration
• Or create CLAUDE.local.md for local development overrides

These files are required for Prometh commands to ensure proper context and configuration.

Learn more: https://docs.anthropic.com/en/docs/claude-code

After creating CLAUDE.md, run '/prometh-init' again to continue setup.
```

**If files exist, proceed to next step.**

### 2. Directory Structure Creation

Create the required directory structure for Prometh documents:

```bash
# Create docs directories if they don't exist
mkdir -p docs/prds
mkdir -p docs/specs
```

**Verification:**
- Check that `docs/prds/` was created successfully
- Check that `docs/specs/` was created successfully
- Report any creation failures

### 3. PROMETH.md Initialization

**Check if PROMETH.md exists:**
- If exists: Update initialization timestamp and validate structure
- If missing: Create new PROMETH.md with complete template

**PROMETH.md Template:**
```markdown
# Prometh Context Framework Status

*Last Updated: [Current Date and Time]*

## Initialization Status

- [x] CLAUDE.md validated ([Date])
- [x] Directory structure created ([Date])  
- [x] Prometh framework initialized ([Date])

## Project Configuration

- **Project Directory**: [Current Directory Path]
- **CLAUDE.md Found**: [Yes/No] 
- **CLAUDE.local.md Found**: [Yes/No]
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

### 4. Next Steps Guidance

After successful initialization, display context-aware next steps based on project state:

**Success Message:**
```
✅ Prometh Context Framework Initialized Successfully!

📁 Directory Structure:
  ✓ docs/prds/     - Strategic Product Requirements Documents
  ✓ docs/specs/    - Implementation Specifications  
  ✓ PROMETH.md     - Framework status and tracking

🎯 Recommended Next Steps:

[Context-specific recommendations based on project state]
```

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

Found PRDs in docs/prds/:
• [List existing PRD files]

Next Steps:
1. /prometh-spec --from-prd [prd-file.md]
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

## Instructions

1. **Always validate CLAUDE.md first** - This is the foundation requirement
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

The command should work in any directory where the user wants to set up Prometh Context Framework, requiring only that Claude Code has already been initialized (CLAUDE.md exists) or that the user creates CLAUDE.local.md for local overrides.