---
description: Display comprehensive project documentation status dashboard with inventory summary, recent activity, traceability matrix, and health metrics. Supports --brief, --counts, --health, --harness, and --include-archive options.
---

# Status Dashboard Command

Display a comprehensive overview of project documentation status, recent activities, and traceability information from the Prometh Context Framework.

## Directory and Tracking File Resolution

**MANDATORY FIRST STEP**: Resolve the documentation directory and tracking file:

**Directory Resolution:**
```bash
# Check for documentation directories (local takes precedence)
if [ -d "prometh-docs.local" ]; then
  DOCS_DIR="prometh-docs.local"
  DOCS_TYPE="local-only"
elif [ -d "prometh-docs" ]; then
  DOCS_DIR="prometh-docs"
  DOCS_TYPE="committed"
else
  echo "❌ Error: Neither prometh-docs/ nor prometh-docs.local/ found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Tracking File Resolution:**
```bash
# Check for tracking files (local takes precedence)
if [ -f "PROMETH.local.md" ]; then
  TRACKING_FILE="PROMETH.local.md"
  TRACKING_TYPE="local-only"
elif [ -f "PROMETH.md" ]; then
  TRACKING_FILE="PROMETH.md"
  TRACKING_TYPE="committed"
else
  echo "❌ Error: Neither PROMETH.md nor PROMETH.local.md found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Priority Rules:**
- `prometh-docs.local/` takes precedence over `prometh-docs/`
- `PROMETH.local.md` takes precedence over `PROMETH.md`
- Use resolved variables (`$DOCS_DIR`, `$TRACKING_FILE`, `$DOCS_TYPE`, `$TRACKING_TYPE`) for all operations
- Display the active variant type in the dashboard output

## Dashboard Components

### 1. Project Overview
- **Project Path**: Current working directory
- **Framework Status**: Initialization date and health check
- **Directory Structure**: Show active directory (`${DOCS_DIR}/` - ${DOCS_TYPE})
- **Tracking File**: Show active tracking file (`${TRACKING_FILE}` - ${TRACKING_TYPE})
- **Last Updated**: Timestamp from ${TRACKING_FILE}

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

### 6. Harness Status Panel

Feedback loop health from the Prometh harness engineering extension. This panel is hidden under `--brief`; it is shown by default and under `--health`.

- **Active Contract**: name, total criteria count, last evaluation pass/fail/partial/manual split, and `Overall` result if an `## Evaluation Summary` block is present
- **Progress Summary**: value of `## Current State` → `Status`, `Branch`, and `Last updated` from `PROMETH-PROGRESS.local.md` (project root). If the file's `Branch:` differs from the current git branch, flag as `BRANCH DRIFT` so the user knows to run `/prometh-progress update`.
- **Sensors Registered**: counts grouped by timing
  - Pre-commit (computational)
  - Pipeline (computational)
  - Pre-PR (inferential)
- **Harness Health**: presence of required harness artifacts
  - `PROMETH-PROGRESS.local.md` exists at project root?
  - `.gitignore` excludes `PROMETH-PROGRESS.local.md`?
  - `${TRACKING_FILE}` contains a `## Harness Configuration` section?
  - If the manifest references an active contract, does the contract file exist?
- **Agent File Sync**: compares the `` - `<cmd>` `` bullets inside the `## Prometh Harness Protocol` → `### Sensors` block of `AGENTS.md` (or `CLAUDE.md`) against the rows in the `#### Computational (run before commit)` table of the manifest
  - `IN SYNC` when the set of commands matches exactly
  - `DRIFT` otherwise — list the missing and extra entries so the user can re-run `/prometh-sensor` to fix

### 6b. Harness Readiness Scorecard

Full audit of harness engineering prerequisites. Rendered in full under `--harness`
and under `--health` (when the project is harness-adopted). Under the default run,
only a single one-line summary is appended at the end of the Harness Status Panel.
Hidden entirely under `--brief` and `--counts`.

**Harness Adoption Detection.** A project is **harness-adopted** when any of:

1. `${TRACKING_FILE}` contains a `## Harness Configuration` section with at least
   one non-placeholder row in any sensor table, OR
2. `PROMETH-PROGRESS.local.md` exists at project root, OR
3. The manifest's `Contracts → Active:` is a real path (not `none`) and the
   referenced contract file exists on disk.

Otherwise the project is **docs-only**. When docs-only:

- Under `--harness`: render only the dormant line
  `Harness: not adopted — run /prometh-sensor add or /prometh-contract {name} to enable`
  and exit. Do **not** run any check.
- Under `--health`: show doc health as normal and append the same dormant line
  in place of the scorecard.
- Under default: omit the harness summary line entirely.

**Checks (13 total).** Reuse data already collected in section 6 wherever possible;
only new reads are called out explicitly.

Guides (Feedforward):

- **G1** Agent instruction file exists (`AGENTS.md` or `CLAUDE.md` at project root).
  **NEW read.**
- **G2** `## Prometh Harness Protocol` section present in the G1 file. **NEW read.**
- **G3** At least one `.md` file under `${DOCS_DIR}/concepts/`. **NEW read.**

Sensors (Feedback):

- **S1** At least one non-placeholder row in the `#### Computational (run before commit)`
  table of `${TRACKING_FILE}`. **Reuse section 6 parse.**
- **S2** The `## Prometh Harness Protocol → ### Sensors` block in the G1 file
  contains at least one `` - `<cmd>` `` bullet that is not the literal
  placeholder `` - `<command>` ``. **NEW read.**
- **S3** Agent bullets match registry commands exactly — reuses the existing
  `IN SYNC`/`DRIFT` result from section 6. Skip (mark n/a) when S1 fails.

Contracts:

- **C1** `${DOCS_DIR}/contracts/` directory exists. **NEW read.**
- **C2** Manifest `Contracts → Active:` is a path and that file exists.
  Warning (not failure) when `Active: none`. **Reuse section 6 parse.**

Progress:

- **P1** `PROMETH-PROGRESS.local.md` exists at project root AND `.gitignore`
  excludes it. Both halves required. **Reuse existing reads from section 6;
  add explicit `.gitignore` check if not already performed.**
- **P2** Parse `Last updated:` from the progress file. Pass if within 7 days,
  warning if 7–30 days, fail if >30 days. **Reuse section 6 read; grade here.**

Codebase:

- **R1** `.git/` directory exists at project root. **NEW read.**
- **R2** Heuristic: at least one sensor row in any manifest sensor table whose
  `Name` or `Command` column contains the substring `test` (case-insensitive).
  Fix hint explicitly notes this is a heuristic. **NEW scan over existing data.**
- **R3** CI config present — any of `.github/workflows/*.yml`, `.gitlab-ci.yml`,
  `.azure-pipelines.yml`, or `Jenkinsfile` at project root. Warning only — not
  every project uses repo-local CI. **NEW read.**

**Result line.** Render `Result: X/13 passing · Y warnings · Z gaps`.

**Priority fixes.** Surface up to 3 items ordered by:

1. Fails before warnings.
2. Within each tier: Guides > Sensors > Contracts > Progress > Codebase.

If all 13 checks pass, replace the priority block with
`✅ Harness ready for autonomous agent work`.

**Legend:** `[x]` pass · `[!]` warning · `[ ]` fail.

## Processing Logic

### 1. ${TRACKING_FILE} Analysis
```
1. Read and parse ${TRACKING_FILE} content
2. Extract all document inventories (PRDs, SPECs, Technical Docs)
3. Parse recent activity log
4. Analyze traceability matrix relationships
5. Calculate status distributions and metrics
6. Identify project health indicators
```

### 2. File System Validation
```
1. Verify ${DOCS_DIR}/prds/ and ${DOCS_DIR}/specs/ directories exist
2. Cross-reference ${TRACKING_FILE} entries with actual files
3. Identify orphaned files not tracked in ${TRACKING_FILE}
4. Check for missing files referenced in tracking
5. Validate directory structure integrity
6. By default, EXCLUDE ${DOCS_DIR}/prds/archive/ and ${DOCS_DIR}/specs/archive/
   from inventory counts, traceability, and recent-activity sections.
   When --include-archive is passed, include them and label the archived
   rows as "(archived)" in the dashboard output.
```

### Archive Handling

Archived PRDs and SPECs live under `${DOCS_DIR}/prds/archive/` and `${DOCS_DIR}/specs/archive/`. They represent `Completed` or `Deprecated` documents retained for traceability but removed from the active workspace.

- **Default behavior**: archive subdirectories are skipped when walking the filesystem and when rendering the Document Inventory, Traceability Matrix, Recent Activity, and Workflow Distribution panels.
- **With `--include-archive`**: walk archive subdirectories as well; display archived entries alongside active ones with an `(archived)` suffix; add an "Archived" row to the inventory totals.
- **Counts panel**: `--counts` respects `--include-archive` — archived docs are shown on a separate line when included.
- **Health panel**: staleness detection never flags archived docs (they are expected to be stale).

### 2b. Harness Panel Collection

Skip this collection step entirely when the user passed `--brief` or `--counts`.

```
1. Read PROMETH-PROGRESS.local.md at project root
   - Extract Current State -> Status
   - Extract Current State -> Branch
   - Extract Current State -> Last updated
   - Compare Branch against `git rev-parse --abbrev-ref HEAD` → flag BRANCH DRIFT if different
2. Read ${TRACKING_FILE} -> ## Harness Configuration -> ### Contracts -> Active:
   - If a contract path is listed, read that file
   - Extract total criteria count from ## Acceptance Criteria
   - Extract ## Evaluation Summary counts and Overall if present
3. Read ${TRACKING_FILE} -> ## Harness Configuration -> ### Sensors (Feedback)
   - Count rows in each of the three tables (skip placeholder rows)
4. Harness Health checks:
   - PROMETH-PROGRESS.local.md exists at project root
   - .gitignore excludes PROMETH-PROGRESS.local.md
   - Harness Configuration section present in tracking file
   - If an Active contract path is set, verify the file exists
5. Agent file sync check:
   - Detect AGENTS.md (preferred) or CLAUDE.md in project root
   - Parse bullets inside ## Prometh Harness Protocol -> ### Sensors
     (lines of the form `- ` + backtick-wrapped command + backtick)
   - Parse the Command column of the #### Computational (run before commit) table
   - Diff the two sets:
       agent_only = bullets not in registry
       registry_only = registry commands not in bullets
   - IN SYNC when both sets are empty, else DRIFT with lists
6. Harness Readiness Scorecard collection (only when --harness or --health
   is active AND the project is harness-adopted per section 6b detection):
   - G1: detect AGENTS.md or CLAUDE.md at project root
   - G2: grep the G1 file for the literal string "## Prometh Harness Protocol"
   - G3: count `.md` files under ${DOCS_DIR}/concepts/ (directory may not exist)
   - S2: parse the ### Sensors block of the G1 file; count bullets of the form
         `- ` + backtick-wrapped command; exclude the literal placeholder
         `- `<command>``
   - P1 (gitignore half): grep .gitignore for a line matching
         PROMETH-PROGRESS.local.md
   - P2 (grading): compute age in days from Last updated; <=7 pass,
         8..30 warn, >30 fail
   - R1: check for .git/ at project root
   - R2: case-insensitive substring search for "test" in the Name or Command
         columns of any sensor table in the manifest
   - R3: check for any of:
         .github/workflows/*.yml, .gitlab-ci.yml, .azure-pipelines.yml,
         Jenkinsfile
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
Directory Status: ✓ ${DOCS_DIR}/prds/ ✓ ${DOCS_DIR}/specs/

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

🛡️  HARNESS READINESS            (--harness or --health, harness-adopted only)
─────────────────────
Guides (Feedforward)
  [x] G1 Agent instruction file (AGENTS.md)
  [x] G2 Harness Protocol section injected
  [ ] G3 No concept docs — run /prometh-doc concept

Sensors (Feedback)
  [x] S1 3 computational pre-commit sensors registered
  [x] S2 Agent file has real sensor commands
  [!] S3 Agent/registry DRIFT — missing: `mise run lint`; run /prometh-sensor to resync

Contracts
  [x] C1 Contracts directory exists
  [!] C2 No active contract — run /prometh-contract {name}

Progress
  [x] P1 PROMETH-PROGRESS.local.md present and gitignored
  [!] P2 Last updated 9 days ago — run /prometh-progress update

Codebase
  [x] R1 Git initialized
  [x] R2 Test sensor discoverable (heuristic: `mise run terraform:test`)
  [!] R3 No CI config found (warning)

Result: 9/13 passing · 3 warnings · 1 gap
Priority:
  1. G3 Add a concept doc (/prometh-doc concept)
  2. S3 Resync sensors (/prometh-sensor)
  3. P2 Update progress (/prometh-progress update)

💡 SUGGESTED NEXT ACTIONS
─────────────────────────
[Context-aware suggestions based on current project state]

════════════════════════════════════════════════════════════════
Generated with: Prometh Context Framework by Prometh
```

When all 13 checks pass, replace the `Priority:` block with
`✅ Harness ready for autonomous agent work`.

When the project is docs-only (no harness adoption), replace the entire
`🛡️  HARNESS READINESS` block with the dormant line:

```
🛡️  HARNESS: not adopted — run /prometh-sensor add or /prometh-contract {name} to enable
```

## Context-Aware Suggestions

### Based on Project State:

**No Documents Yet:**
```
🚀 Getting Started:
1. Create your first strategic initiative:
   → say "Create a PRD for [your initiative]" (prometh-prd skill)
2. Or jump to implementation:
   → say "Create a SPEC for [your task]" (prometh-spec skill)
3. Generate project documentation:
   → say "Generate a README for this project" (prometh-doc skill)
```

**PRDs but No SPECs:**
```
⚡ Ready for Implementation:
1. Derive SPECs from existing PRDs:
   → say "Derive a SPEC from [prd-file.md]" (prometh-spec skill)
2. Create additional implementation tasks:
   → say "Create a SPEC for [task]" (prometh-spec skill)
```

**Many Draft Documents:**
```
📝 Review and Progress:
1. Review draft PRDs and update status in ${TRACKING_FILE}
2. Advance SPECs from planning to implementation phase
3. Update document statuses to reflect current state
```

**Missing Documentation:**
```
📚 Documentation Gap:
1. Generate project README:
   → say "Generate a README for this project" (prometh-doc skill)
2. Create operational runbook:
   → say "Write an operational runbook" (prometh-doc skill)
3. Document architecture decisions:
   → say "Write concept documentation for this project" (prometh-doc skill)
```

## Error Handling

- **No ${TRACKING_FILE} found**: Display error message and exit immediately
- **Corrupted ${TRACKING_FILE}**: Report parsing issues and suggest `/prometh-init` to reset
- **Missing directories**: Report directory issues and suggest `/prometh-init` to repair
- **File sync issues**: Report discrepancies between ${TRACKING_FILE} and file system
- **Empty project**: Display welcome message with getting started guidance
- **Harness adoption undetected**: Under `--harness` and `--health`, render only
  the dormant "not adopted" line. Never fail scorecard checks on a docs-only project.

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

1. **Always validate ${TRACKING_FILE} existence first** - Exit with error if not found
2. **Parse ${TRACKING_FILE} completely** - Extract all sections and validate structure
3. **Cross-reference with file system** - Verify actual files match tracking
4. **Calculate comprehensive metrics** - Provide actionable insights
5. **Generate context-aware suggestions** - Help users understand next steps
6. **Format output professionally** - Use clear visual hierarchy and indicators
7. **Handle edge cases gracefully** - Provide helpful messages for empty or corrupted states

## Advanced Features

### Quick Stats Display:
```bash
/prometh-status --brief            # Condensed one-line summary
/prometh-status --counts           # Just the document counts
/prometh-status --health           # Health metrics + harness readiness scorecard
/prometh-status --harness          # Harness readiness scorecard only (skip inventory)
/prometh-status --include-archive  # Also walk prds/archive/ and specs/archive/
                                    # (combinable with the flags above)

Flag interactions:
- `--harness --brief` collapses the scorecard to a single line:
  `Harness: X/13 · Y warnings · Z gaps`
- `--harness --counts` — `--harness` wins, `--counts` is ignored.
- `--brief` and `--counts` on their own skip the harness section entirely.
```

### Integration Points:
- **Git Integration**: Show document changes relative to git commits
- **File Watching**: Detect changes since last status check
- **Export Options**: Generate status reports in different formats

The status dashboard provides project teams with instant visibility into their documentation ecosystem, helping maintain documentation quality and identify areas needing attention.
