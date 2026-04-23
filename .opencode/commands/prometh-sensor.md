---
description: Register, list, or remove feedback sensors in the Prometh harness (computational pre-commit, pipeline, inferential pre-PR)
---

# Prometh Sensor Command

Register, list, and remove feedback sensors for the harness. Sensors are checks that run AFTER the agent acts to enable self-correction. The full registry lives in `PROMETH.md` / `PROMETH.local.md`, which the agent reads at session start.

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

**Confirmation:**
Report the write to the user:
```
✅ Sensor `{name}` registered
  • Registry: PROMETH.md (or PROMETH.local.md)
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
3. Remove the row from the manifest table. If removing that row leaves the table with zero data rows, re-insert the `*No sensors registered yet*` placeholder row.
4. Confirm the removal and report that the manifest was updated.

## Rules

- Sensor names must be unique within the harness across all three tables.
- Prefer `mise run {task}` format for computational sensors — it handles PATH, env vars, and tool versions consistently.
- The agent reads the full sensor registry from the manifest (`PROMETH.md` / `PROMETH.local.md`) at session start.
- Do not inject emojis or bold text into the generated tables — follow PCF markdown conventions.
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
