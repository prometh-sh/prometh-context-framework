---
description: Display comprehensive project documentation status dashboard with inventory summary, recent activity, traceability matrix, and health metrics. Supports --brief, --counts, and --health options.
argument-hint: "[--brief|--counts|--health]"
allowed-tools: ["Read", "LS", "Bash"]
---

# Status Dashboard Command

Display a comprehensive overview of project documentation status, recent activities, and traceability information from the Prometh Context Framework.

## PROMETH.md Validation

**MANDATORY FIRST STEP**: Before any processing, check for PROMETH.md in the project root:

```bash
# Check for required framework file
ls PROMETH.md 2>/dev/null
```

If file does not exist, display this error and EXIT:
```
❌ Prometh Context Framework Error

PROMETH.md not found in project root.

Please initialize the Prometh Context Framework first:
• Run '/prometh-init' to set up framework tracking and directory structure

This file is required for Prometh commands to track documents and maintain project state.
```

## Dashboard Components

### 1. Project Overview
- **Project Path**: Current working directory
- **Framework Status**: Initialization date and health check
- **Directory Structure**: Verification of `docs/prds/` and `docs/specs/` 
- **Last Updated**: Timestamp from PROMETH.md

### 2. Document Inventory Summary
- **PRDs**: Total count, status breakdown (Draft/Under Review/Approved/In Progress/Completed)
- **SPECs**: Total count, type breakdown (Feature/Bug Fix/Enhancement/Task), status distribution
- **Technical Docs**: Total count, type breakdown (README/Runbook/Architecture/API/Deployment)

### 3. Recent Activity Feed
- **Last 10 Activities**: Chronological list of recent document creation and updates
- **Activity Types**: Color-coded indicators for different activity types
- **Quick Actions**: Suggested next steps based on current project state

### 4. Traceability Matrix Overview
- **Linked Documents**: PRD-to-SPEC relationships
- **Implementation Coverage**: Percentage of PRDs with associated SPECs
- **Orphaned Documents**: SPECs without PRD links and PRDs without SPECs

### 5. Project Health Indicators
- **Documentation Coverage**: Overall completeness assessment
- **Staleness Indicators**: Documents that haven't been updated recently
- **Workflow Status**: Distribution of documents across implementation phases

## Processing Logic

### 1. PROMETH.md Analysis
```
1. Read and parse PROMETH.md content
2. Extract all document inventories (PRDs, SPECs, Technical Docs)
3. Parse recent activity log
4. Analyze traceability matrix relationships
5. Calculate status distributions and metrics
6. Identify project health indicators
```

### 2. File System Validation
```
1. Verify docs/prds/ and docs/specs/ directories exist
2. Cross-reference PROMETH.md entries with actual files
3. Identify orphaned files not tracked in PROMETH.md
4. Check for missing files referenced in tracking
5. Validate directory structure integrity
```

### 3. Dashboard Rendering
```
1. Format project overview section
2. Generate document inventory summaries with counts
3. Display recent activity feed with timestamps
4. Render traceability matrix visualization
5. Calculate and display health metrics
6. Suggest context-aware next actions
```

## Dashboard Output Format

```
🔥 Prometh Context Framework Status Dashboard
═════════════════════════════════════════════

📊 PROJECT OVERVIEW
────────────────────
Project Path: /path/to/current/project
Framework Initialized: [Date]
Last Updated: [Timestamp]
Directory Status: ✓ docs/prds/ ✓ docs/specs/

📚 DOCUMENT INVENTORY
─────────────────────
PRDs (Strategic):           [Total: X]
  • Draft: X  • Under Review: X  • Approved: X  • In Progress: X  • Completed: X

SPECs (Implementation):     [Total: X]  
  • Feature: X  • Bug Fix: X  • Enhancement: X  • Technical Task: X
  • Draft: X  • Under Review: X  • Approved: X  • In Progress: X  • Testing: X  • Completed: X

Technical Documentation:    [Total: X]
  • README: X  • Runbook: X  • Architecture: X  • API: X  • Deployment: X

🔗 TRACEABILITY MATRIX
──────────────────────
PRD → SPEC Relationships:   [X linked, X orphaned PRDs, X standalone SPECs]
Implementation Coverage:    [X%] ([X of X PRDs have associated SPECs])

Recent Relationships:
  • [prd-file.md] → [spec-file-1.md, spec-file-2.md]
  • [prd-file-2.md] → [spec-file-3.md]

⚡ RECENT ACTIVITY
─────────────────
[Last 10 activities with timestamps and types]
  • [Date] Created PRD - strategic-initiative-prd.md
  • [Date] Created SPEC - feature-user-auth-spec.md (from PRD: strategic-initiative-prd.md)
  • [Date] Generated README documentation - README.md

📈 PROJECT HEALTH
─────────────────
Documentation Coverage: [Assessment based on document types and completeness]
Workflow Distribution:
  • Planning Phase: X documents
  • Task Breakdown Phase: X documents  
  • Implementation Phase: X documents

Staleness Indicators:
  • X documents not updated in 30+ days
  • X documents missing recent activity

💡 SUGGESTED NEXT ACTIONS
─────────────────────────
[Context-aware suggestions based on current project state]

════════════════════════════════════════════════════════════════
Generated with: Prometh Context Framework by Prometh
```

## Context-Aware Suggestions

### Based on Project State:

**No Documents Yet:**
```
🚀 Getting Started:
1. Create your first strategic initiative: /prometh-prd
2. Or jump to implementation: /prometh-spec
3. Generate project documentation: /prometh-doc readme
```

**PRDs but No SPECs:**
```
⚡ Ready for Implementation:
1. Create SPECs from existing PRDs: /prometh-spec --from-prd [prd-file.md]
2. Create additional implementation tasks: /prometh-spec
```

**Many Draft Documents:**
```
📝 Review and Progress:
1. Review draft PRDs and update status in PROMETH.md
2. Advance SPECs from planning to implementation phase
3. Update document statuses to reflect current state
```

**Missing Documentation:**
```
📚 Documentation Gap:
1. Generate project README: /prometh-doc readme
2. Create operational runbook: /prometh-doc runbook
3. Document architecture decisions: /prometh-doc architecture
```

## Error Handling

- **No PROMETH.md found**: Display error message and exit immediately
- **Corrupted PROMETH.md**: Report parsing issues and suggest `/prometh-init` to reset
- **Missing directories**: Report directory issues and suggest `/prometh-init` to repair
- **File sync issues**: Report discrepancies between PROMETH.md and file system
- **Empty project**: Display welcome message with getting started guidance

## Health Assessment Logic

### Documentation Coverage Metrics:
- **Excellent (90-100%)**: Strategic docs, implementation specs, and technical docs all present
- **Good (70-89%)**: Most document types present with good status distribution  
- **Fair (50-69%)**: Basic documentation present but gaps in coverage or status progression
- **Poor (< 50%)**: Minimal documentation, mostly draft status, missing key document types

### Staleness Detection:
- **Recent**: Updated within 7 days
- **Current**: Updated within 30 days  
- **Stale**: Updated 30-90 days ago
- **Very Stale**: Updated 90+ days ago

### Workflow Health:
- **Balanced**: Even distribution across planning, breakdown, and implementation phases
- **Planning Heavy**: Many documents in planning phase, few in implementation
- **Implementation Focused**: Most documents in implementation, good progress indicators

## Instructions

1. **Always validate PROMETH.md existence first** - Exit with error if not found
2. **Parse PROMETH.md completely** - Extract all sections and validate structure
3. **Cross-reference with file system** - Verify actual files match tracking
4. **Calculate comprehensive metrics** - Provide actionable insights
5. **Generate context-aware suggestions** - Help users understand next steps
6. **Format output professionally** - Use clear visual hierarchy and indicators
7. **Handle edge cases gracefully** - Provide helpful messages for empty or corrupted states

## Advanced Features

### Quick Stats Display:
```bash
/prometh-status --brief    # Condensed one-line summary
/prometh-status --counts   # Just the document counts
/prometh-status --health   # Only health metrics and suggestions
```

### Integration Points:
- **Git Integration**: Show document changes relative to git commits
- **File Watching**: Detect changes since last status check
- **Export Options**: Generate status reports in different formats

The status dashboard provides project teams with instant visibility into their documentation ecosystem, helping maintain documentation quality and identify areas needing attention.