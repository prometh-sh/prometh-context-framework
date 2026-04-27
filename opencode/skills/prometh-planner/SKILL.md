---
name: prometh-planner
description: Create interactive project plans from Pixel Planner template. Generates PLN-YYYYMMDD-<slug>.md plan files with Gantt timelines, phases, and milestone tracking. Integrates with pixel-planner CLI for timeline generation and updates.
---

# Pixel Planner Project Planning Skill

Create and manage project plans using the Pixel Planner framework. Generate dated plan files with Gantt-like timelines, phases, and milestone tracking.

## Directory and Tracking File Resolution

**MANDATORY FIRST STEP**: Resolve the documentation directory and tracking file:

**Directory Resolution:**

```bash
# Check for documentation directories (local takes precedence)
if [ -d "prometh-docs.local" ]; then
  DOCS_DIR="prometh-docs.local"
elif [ -d "prometh-docs" ]; then
  DOCS_DIR="prometh-docs"
else
  echo "Error: Neither prometh-docs/ nor prometh-docs.local/ found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Tracking File Resolution:**

```bash
# Check for tracking files (local takes precedence)
if [ -f "PROMETH.local.md" ]; then
  TRACKING_FILE="PROMETH.local.md"
elif [ -f "PROMETH.md" ]; then
  TRACKING_FILE="PROMETH.md"
else
  echo "Error: Neither PROMETH.md nor PROMETH.local.md found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Priority Rules:**

- `prometh-docs.local/` takes precedence over `prometh-docs/`
- `PROMETH.local.md` takes precedence over `PROMETH.md`
- Use resolved variables (`$DOCS_DIR` and `$TRACKING_FILE`) for all file operations

## Configuration Resolution

**After resolving the tracking file**, read the `## Document Configuration` section:

```
1. Open ${TRACKING_FILE} and locate the ## Document Configuration section
2. Extract the YAML block under ### Metadata Template
   → Store as METADATA_TEMPLATE (set to nil if section or block is absent/empty)
3. Extract the YAML block under ### Filename Patterns
   → Store as FILENAME_CONFIG (set to nil if section or block is absent/empty)
```

These two variables govern filename generation and metadata injection for all
documents created in this session.

## Invocation Modes

### Mode 1: Interactive (no arguments)

```
Pixel Planner — New Project Plan

What would you like to do?
1. Create a new plan
2. View existing plans
3. Get help

Choose (1-3):
```

If "Create a new plan" is chosen, interactively gather:

```
Project name (required):
Brief description or context (optional):
Number of phases to create (default: 2):
Start date [YYYY-MM-DD] (default: today):
```

### Mode 2: Argument-based (project name provided)

```
prometh-planner "Mobile App Redesign"
```

Auto-generate with sensible defaults:

- Number of phases: 2
- Start date: today (YYYYMMDD)

### Mode 3: From SPEC (--spec <file>)

```
prometh-planner --spec feature-user-auth-spec.md
```

- Extract project/feature name from SPEC title
- Extract context from SPEC description
- Defaults to 3 phases if SPEC has no implementation structure

### Mode 4: From free-form description (--description <text>)

```
prometh-planner --description "Migrate database from PostgreSQL to MongoDB"
```

Parse the description and extract:

- Project name (first line or leading words before first period)
- Context (remaining description)

## Workflow Steps

### Step 1: Precondition Check

**Check docs directory:**

```bash
if [ ! -d "$DOCS_DIR" ]; then
  echo "Error: Documentation directory not found: $DOCS_DIR"
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Create plans subdirectory** within `${DOCS_DIR}`:

```bash
PLANS_DIR="${DOCS_DIR}/plans"
mkdir -p "$PLANS_DIR"
```

### Step 2: Input Collection

Based on invocation mode, gather or extract:

- `PROJECT_NAME` — the plan's subject
- `DESCRIPTION` — project context (optional)
- `NUM_PHASES` — number of phases (default: 2)
- `START_DATE` — plan start date (default: today as YYYY-MM-DD)

### Step 3: Generate Filename

```bash
SLUG=$(echo "$PROJECT_NAME" | \
  tr '[:upper:]' '[:lower:]' | \
  sed -E 's/[^a-z0-9]+/-/g' | \
  sed -E 's/-+/-/g' | \
  sed 's/^-|-$//g' | \
  sed -E 's/(^|\b)(the|a|an|for|to|with|of|and|or|in|on|at|is|be)\b//g' | \
  sed 's/[[:space:]]*//g' | \
  sed 's/-*-/-/g' | \
  sed 's/^-|-$//g' | \
  cut -c 1-50)

DATE=$(date +%Y%m%d)
FILENAME="PLN-${DATE}-${SLUG}.md"
PLAN_PATH="${PLANS_DIR}/${FILENAME}"
```

Validation: If `PLAN_PATH` already exists, prompt:

```
File already exists: $PLAN_PATH

Overwrite? (y/N):
```

If "N" (or no response), abort.

### Step 4: Create Plan File with pixel-planner init

```bash
if ! command -v pixel-planner &> /dev/null; then
  echo "Error: pixel-planner CLI not found on PATH."
  echo "Install: pip install pixel-planner"
  exit 1
fi

pixel-planner init --out "${PLAN_PATH}" --project "${PROJECT_NAME}"
if [ $? -ne 0 ]; then
  echo "Error: pixel-planner init failed."
  exit 1
fi
```

After the file is created, inject YAML frontmatter metadata (if METADATA_TEMPLATE is configured):

Prepend the populated block as a YAML frontmatter fence at the very top of the document:

```
---
title: "Mobile App Platform Strategy"
created: "2026-02-23T18:30:29"
author: "Your Name"
focus: "Personal"
tags: []
project:
  - name: "Your Project Name"
    uuid: "YOUR-PROJECT-UUID"
status: "Draft"
uuid: "GENERATED-UUID-V4-PER-DOCUMENT"
related: []
---
```

Do not modify any other content in the file beyond prepending the frontmatter.

### Step 5: Fill in the tables with the previously created plan

Fill in the Phase tables with the previously created plan or with the information provided to create this plan.
Just limit yourself to filling out the tables, if necessary create more Phases.

Do not add information beyond the existing tables in the file generated by Pixel Planner.

Do not modify any other content in the file beyond prepending the frontmatter.

### Step 6: Auto-run `pixel-planner timeline`

```bash
if command -v pixel-planner &> /dev/null; then
  echo "Generating initial timeline..."
  pixel-planner timeline \
    --in "$PLAN_PATH" \
    --in-place \
    --basis current \
    --include-status
  if [ $? -eq 0 ]; then
    echo "Timeline generated."
  else
    echo "Timeline generation failed. File created, but you'll need to run pixel-planner manually."
  fi
else
  echo "pixel-planner CLI not found on PATH."
  echo "Install it (pip install pixel-planner) to auto-generate timelines."
  echo "Or run manually after editing phases/milestones:"
  echo "pixel-planner timeline --in $PLAN_PATH --in-place --basis current --include-status"
fi
```

### Step 7: Update Tracking File

If `$TRACKING_FILE` exists, check for a `## Plans` section. If it does not exist, create it:

```markdown
## Plans

| Plan | Project | Status | Created | Last Updated |
|------|---------|--------|---------|--------------|
```

Then append a new entry:

```markdown
| [PLN-YYYYMMDD-slug](${DOCS_DIR}/plans/PLN-YYYYMMDD-slug.md) | Project Name | Draft | YYYY-MM-DD | YYYY-MM-DD |
```

Also update the "Last Updated" timestamp in the document metadata/header if one exists.

### Step 8: Report Success

```
Plan created: ${DOCS_DIR}/plans/PLN-${DATE}-${SLUG}.md

Project: [Project Name]
Created: [Today's date]
Phases: [NUM_PHASES]

Next steps:
1. Open and review the plan file
2. Add milestone details to each phase
3. Refresh the timeline after editing:
   pixel-planner timeline --in ${PLAN_PATH} --in-place --basis current
```

## Pixel Planner CLI Reference

### Installation

```bash
# Via pip (Recommended)
pip install pixel-planner

# Or clone and run directly
git clone https://github.com/prometh-sh/pixel-planner.git
cd pixel-planner
python3 scripts/pixel_planner.py [command]
```

### Key Commands

**Initialize a new plan from template:**

```bash
pixel-planner init --out MyPlan.md --project "My Project"
```

**Generate/refresh timeline in-place (current basis with activity evolution):**

```bash
pixel-planner timeline --in MyPlan.md --in-place --basis current --include-status
```

**Generate using baseline dates (clean bars, no percentages):**

```bash
pixel-planner timeline --in MyPlan.md --in-place --basis baseline
```

**Generate as-of a specific date (reproducible snapshot):**

```bash
pixel-planner timeline --in MyPlan.md --in-place --basis current --date 2025-03-02
```

**Output to separate file:**

```bash
pixel-planner timeline --in MyPlan.md --out MyPlan.out.md --basis current --version v1.0
```

### Milestone Status Codes

Valid `Status` values in the milestone table:

- `Backlog`
- `In Progress`
- `Ready for Review`
- `Done`

(Only `Done` marks a milestone as executed in percentage calculations.)

### Timeline Semantics

- Each `■` = one calendar week
- `|` = effective date (today, or last milestone if today is after last date)
- `[■ ■ ■]` = phase bar spanning weeks
- `X% / Y%` = (executed / total) and (planned-by-effective-date / total)
- `▲` = on or ahead of schedule; `▼` = behind schedule

---

## Tracking File Format: Plans Section

When a new plan is created and `PROMETH.md` / `PROMETH.local.md` exists, a `## Plans` section is added (if not present) with entries:

```markdown
## Plans

| Plan | Project | Status | Created | Last Updated |
|------|---------|--------|---------|--------------|
| [PLN-20260422-mobile-redesign](prometh-docs/plans/PLN-20260422-mobile-redesign.md) | Mobile App Redesign | Draft | 2026-04-22 | 2026-04-22 |
| [PLN-20260415-infra-migration](prometh-docs/plans/PLN-20260415-infra-migration.md) | Infrastructure Migration | In Progress | 2026-04-15 | 2026-04-20 |
```

Status values: `Draft`, `In Progress`, `Approved`, `Active`, `Completed`

---

## Error Handling

| Error | Message | Action |
|-------|---------|--------|
| No AGENTS.md | `Error: Agent configuration not found` | Exit, suggest `/prometh-init` |
| No docs directory | `Error: Documentation directory not found: $DOCS_DIR` | Exit, suggest `/prometh-init` |
| File exists | `File already exists: $PLAN_PATH — Overwrite? (y/N):` | Prompt, abort if N |
| pixel-planner not on PATH (init) | `Error: pixel-planner CLI not found on PATH` | Hard fail (init step is required) |
| pixel-planner not on PATH (timeline) | `pixel-planner CLI not found on PATH` | Warn, continue without timeline |
| Timeline generation fails | `Timeline generation failed` | Warn, file still created, show manual command |
| Invalid date format | `Error: Invalid date format. Use YYYY-MM-DD.` | Re-prompt or use today's date |

---

## Processing Instructions

1. **Resolve preconditions** — check `prometh-docs`/`prometh-docs.local` and `PROMETH.md`/`PROMETH.local.md`
2. **Resolve configuration** — read Document Configuration section (Metadata Template, Filename Patterns)
3. **Create plans subdirectory** — ensure `${DOCS_DIR}/plans/` exists
4. **Determine invocation mode** — interactive, project name, --spec, or --description
5. **Collect inputs** — project name, description, phases, start date (prompts or extraction)
6. **Generate filename** — `PLN-YYYYMMDD-<slug>.md` with proper slugification
7. **Create plan file with pixel-planner init** — call `pixel-planner init --out "${PLAN_PATH}" --project "${PROJECT_NAME}"` (hard fail if CLI missing)
8. **Inject metadata** — prepend YAML frontmatter only if METADATA_TEMPLATE is configured
9. **Auto-run timeline** — `pixel-planner timeline --in-place --basis current --include-status` (graceful if CLI missing)
10. **Update tracking** — add `## Plans` section if needed, append new entry
11. **Report success** — show file path and next steps

---

Generated with: **Prometh Context Framework by Prometh**
