---
description: Register, list, or remove feedback sensors in the Prometh harness (computational pre-commit, pipeline, inferential pre-PR)
argument-hint: "add <name> <cmd> --type <t> --when <w> | list | remove <name>"
allowed-tools: ["Read", "Write", "Edit", "Bash"]
---

# Prometh Sensor Command

Register, list, and remove feedback sensors for the harness. Sensors are checks that run AFTER the agent acts to enable self-correction. This command dual-writes: the full registry lives in `PROMETH.md` / `PROMETH.local.md`, while the executable short list of computational pre-commit sensors is mirrored into the `## Prometh Harness Protocol` section of `CLAUDE.md` / `AGENTS.md` so the agent reads them automatically every session.

## Preconditions

1. `CLAUDE.md` or `CLAUDE.local.md` exists in project root. If missing, instruct the user to run `/prometh-init`.
2. Resolve the documentation directory and tracking file:
   ```bash
   if [ -d "prometh-docs.local" ]; then
     DOCS_DIR="prometh-docs.local"
   elif [ -d "prometh-docs" ]; then
     DOCS_DIR="prometh-docs"
   else
     echo "❌ Prometh not initialized. Run /prometh-init first."
     exit 1
   fi

   # Manifest may live inside DOCS_DIR (local mode) or at project root (committed mode)
   if [ -f "${DOCS_DIR}/PROMETH.local.md" ]; then
     MANIFEST="${DOCS_DIR}/PROMETH.local.md"
   elif [ -f "PROMETH.local.md" ]; then
     MANIFEST="PROMETH.local.md"
   elif [ -f "PROMETH.md" ]; then
     MANIFEST="PROMETH.md"
   else
     echo "❌ Harness manifest not found. Run /prometh-init to create it."
     exit 1
   fi
   ```
3. Detect the agent instruction file (CLAUDE.md preferred for Claude Code).

## Subcommands

### `add {name} {command} --type {computational|inferential} --when {pre-commit|pipeline|pre-pr}`

Register a new sensor.

**Arguments:**
- `name`: short identifier, unique within the harness (e.g., `terraform-validate`, `tflint`, `architecture-review`)
- `command`: the executable command or description
  - For `computational`: a shell command, preferably in `mise run {task}` format for tool-version and env-var consistency
  - For `inferential`: a short description of the review to perform
- `--type`: `computational` (deterministic, tool-based) or `inferential` (semantic, AI-based)
- `--when`: `pre-commit` (run before every commit), `pipeline` (run in CI only), or `pre-pr` (run before creating a PR)

**Validation:**
- Both `--type` and `--when` are required. Reject the command with a helpful usage message if either is missing.
- Reject `inferential` with `pre-commit` or `pipeline` — inferential sensors run at `pre-pr`. Reject `computational` with `pre-pr` — computational belongs in pre-commit or pipeline.
- Check for a duplicate sensor name in any of the three tables. If found, warn the user and ask: "A sensor named `{name}` already exists. Replace it? (y/N)". On no, abort.

**Registry update (always):**

Open the manifest and locate the `## Harness Configuration` → `### Sensors (Feedback)` subsection. Add a row to the matching table:

| `--type` | `--when` | Target table heading |
|----------|----------|----------------------|
| computational | pre-commit | `#### Computational (run before commit)` |
| computational | pipeline | `#### Computational (run in pipeline)` |
| inferential | pre-pr | `#### Inferential (run on PR)` |

Computational table columns: `| {name} | \`{command}\` | {ISO date} |`.
Inferential table columns: `| {name} | {description} | {ISO date} |`.

If the target table still contains the `*No sensors registered yet*` placeholder row, remove that row as part of the insert.

**Agent file update (only for computational + pre-commit):**

Locate the `## Prometh Harness Protocol` → `### Sensors` block in the agent file. Inside that block:

1. If the placeholder line `- *No sensors registered yet - use \`/prometh-sensor add\` to register*` exists, replace it with `` - `{command}` ``.
2. Otherwise, append `` - `{command}` `` as a new bullet at the end of the existing list, before the `For the full sensor registry...` line.

Do not touch any other section of the agent file.

**Confirmation:**
Report both writes to the user:
```
✅ Sensor `{name}` registered
  • Registry: {MANIFEST}
  • Agent file: {AGENT_FILE} (only for pre-commit computational sensors)
```

### `list`

Display all registered sensors grouped by timing.

Process:
1. Read the three tables from the manifest's `### Sensors (Feedback)` section.
2. Render grouped output:
   ```
   Pre-commit (computational): N
     - terraform-validate: mise run terraform:validate (added 2026-04-13)
     - tflint:             mise run terraform:lint      (added 2026-04-13)

   Pipeline (computational): N
     - terratest: mise run terraform:test (added 2026-04-13)

   Pre-PR (inferential): N
     - architecture-review: Review changes against concept doc (added 2026-04-13)
   ```
3. Include the count per group; print `(none)` when a group is empty.

### `remove {name}`

Remove a sensor from the harness.

Process:
1. Scan all three tables in the manifest for a row whose first column matches `{name}`.
2. If not found, report and exit.
3. Record whether the matched row was in the `Computational (run before commit)` table — this determines whether the agent file also needs updating.
4. Remove the row from the manifest table. If removing that row leaves the table with zero data rows, re-insert the `*No sensors registered yet*` placeholder row.
5. If the sensor was computational pre-commit: open the agent file, find the corresponding `` - `{command}` `` bullet inside the `### Sensors` block, and remove it. If removing that bullet leaves the block with zero bullets, restore the placeholder line `- *No sensors registered yet - use \`/prometh-sensor add\` to register*`.
6. Confirm the removal and report both file locations that were updated.

## Rules

- Sensor names must be unique within the harness across all three tables.
- Prefer `mise run {task}` format for computational sensors — it handles PATH, env vars, and tool versions consistently.
- The agent file (CLAUDE.md / AGENTS.md) only gets computational pre-commit sensors inline. Pipeline and inferential sensors stay in the manifest only — the agent does not need to run those during a normal coding session.
- Always keep the manifest and agent file in sync: every `add` and `remove` that touches a pre-commit computational sensor must update both.
- Do not inject emojis or bold text into the generated tables or agent file content — follow PCF markdown conventions.
- Preserve the existing manifest structure; never reorder top-level headings.

## Example Usage

```bash
# Register a pre-commit computational sensor
/prometh-sensor add terraform-validate "mise run terraform:validate" --type computational --when pre-commit

# Register a CI pipeline sensor (manifest only)
/prometh-sensor add terratest "mise run terraform:test" --type computational --when pipeline

# Register an inferential pre-PR review
/prometh-sensor add architecture-review "Review changes against concept doc" --type inferential --when pre-pr

# List all sensors
/prometh-sensor list

# Remove a sensor
/prometh-sensor remove terraform-validate
```
