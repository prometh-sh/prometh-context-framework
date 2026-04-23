---
description: View, update, or reset the harness progress file scoped to a specific contract
argument-hint: "--contract <file> [update|reset]"
allowed-tools: ["Read", "Write", "Edit", "Bash"]
---

# Prometh Progress Command

View or update the progress file that persists state across agent sessions and is scoped to a specific contract. The progress file is the most important "memory" artifact in the harness — it is what a fresh agent reads at session start to understand where the previous session left off.

## Progress File Location

The progress file is **always** `PROMETH-PROGRESS.local.md` at the project root. There is exactly one progress file at any time, and it is scoped to the currently active contract. This ensures no merge conflicts, no per-worktree collisions, and a clear single source of truth.

**Why at root, always `.local`, and always one per contract:**

- Progress is ephemeral per-contract state, not project documentation.
- The `.local` infix guarantees it is never committed (matches industry convention: `.env.local`, `settings.local.json`).
- Exactly one contract is active at a time; switching contracts requires completing or resetting the previous one.
- Each git worktree can have its own active contract, and each contract session is tracked independently by the `active_contract` field in the header.

## Preconditions

1. `--contract <file>` argument is required. If absent, exit immediately with:
   ```
   ❌ Missing required argument: --contract <file>
   Usage: /prometh-progress --contract <path/to/contract.md> [update|reset]

   The progress file is scoped to a specific contract. You must specify which contract to track.
   ```
   If provided, verify the contract file exists. If it does not, exit with:
   ```
   ❌ Contract file not found: <path>
   Ensure the path is correct and the file exists.
   ```

2. Active contract guard: If `PROMETH-PROGRESS.local.md` already exists at project root, read its `active_contract:` field from the YAML front matter:
   - If `active_contract` ≠ the `--contract` argument path, block with:
     ```
     ❌ A progress session for a different contract is already active.
        Active contract:    prometh-docs.local/contracts/001.md
        Requested contract: prometh-docs.local/contracts/002.md

     Complete or reset the active session before starting a new one:
       /prometh-progress --contract prometh-docs.local/contracts/001.md
       /prometh-progress --contract prometh-docs.local/contracts/001.md reset
     ```
   - If `active_contract` matches the `--contract` argument, proceed normally.
   - If no file exists, proceed to auto-create (first run for this contract).

3. `CLAUDE.md` or `CLAUDE.local.md` exists in project root. If neither is present, exit with an error directing the user to run `/prometh-init`.

4. Documentation directory exists (resolve for reading the harness manifest):
   ```bash
   if [ -d "prometh-docs.local" ]; then
     DOCS_DIR="prometh-docs.local"
   elif [ -d "prometh-docs" ]; then
     DOCS_DIR="prometh-docs"
   else
     echo "❌ Prometh not initialized. Run /prometh-init first."
     exit 1
   fi
   ```

5. On first run for this contract (no progress file exists), auto-create `PROMETH-PROGRESS.local.md` at project root using the initial template from the `reset` branch below, with `active_contract` pre-populated from the `--contract` argument path.

## Argument Handling

The command accepts zero or one argument: `update`, `reset`, or none.

### No argument: display current progress

Read `PROMETH-PROGRESS.local.md` from project root and render a concise summary to the user containing:

- Current State (status, branch, last updated)
- Completed items (bulleted list)
- In Progress items
- Next items
- Blockers (highlighted if non-empty)
- Codebase State (tests / build / known issues)

Do not paraphrase — faithfully reproduce the content so the user can trust the display.

**Branch drift check:** compare the `- Branch:` field in the progress file against `git rev-parse --abbrev-ref HEAD`. If they differ, warn the user that the progress state is from a different branch and suggest running `/prometh-progress update` to rebuild.

### Argument `update`: refresh progress from session context

1. Gather session context:
   ```bash
   git log --oneline -10
   git diff --stat
   git rev-parse --abbrev-ref HEAD
   git status --short
   ```
2. Check for an active contract by reading the Contracts section of `PROMETH.md` or `PROMETH.local.md`. If an active contract is referenced, read its criteria table.
3. Read the existing `PROMETH-PROGRESS.local.md`.
4. Produce an updated version:
   - Move finished work from `## In Progress` into `## Completed` — annotate each moved item with its commit hash when one is obvious from `git log`
   - Refresh `## In Progress` with work that is clearly mid-flight (uncommitted changes, partially implemented features)
   - Update `## Next` with what the next session should pick up (derived from blockers, TODO comments, or active contract criteria that are still `Pending`)
   - Update `## Blockers` — preserve existing entries unless the user explicitly resolved them; add new blockers discovered in the session
   - Refresh `## Codebase State`:
     - Tests: run the project test command if one is known, otherwise leave as "unknown"
     - Build: same for build
     - Known issues: preserve and extend
   - Update `- Last updated:` to the current ISO date
   - Update `- Branch:` to the current branch
   - Update `- Active contract:` to the manifest's `Contracts → Active:` value (or `none`)
5. If a contract is active, append or update a subsection titled `### Contract: {name}` under `## Current State` listing which criteria are now met vs. still pending.
6. Re-derive the YAML front-matter header from the refreshed body and git/manifest state:
   - `status` ← `- Status:` bullet value
   - `branch` ← `git rev-parse --abbrev-ref HEAD`
   - `last_updated` ← current ISO date
   - `active_contract` ← manifest `Contracts → Active:` path (empty string if `none`)
   - `schema_version: 1`
   If the existing file has no header, prepend a new one. If it has one, overwrite it in place. Never preserve stale header values.
 7. Write the updated content back to `PROMETH-PROGRESS.local.md`, preserving the top-level markdown structure (headings, ordering).
 8. Report a short summary of what changed in the file to the user.
 9. **Completion check**: After writing, evaluate whether all criteria in the active contract are in a terminal state (`Pass` or `Manual`). If yes:
    - Report: `✅ All contract criteria are complete (Pass or Manual). Closing progress session.`
    - Delete `PROMETH-PROGRESS.local.md`
    - Confirm to the user that the session is closed and the file has been removed.

### Argument `reset`: rewrite to initial template

1. Ask the user to confirm: "This will replace `PROMETH-PROGRESS.local.md` with a fresh initial template for contract `--contract`. Continue? (y/N)"
2. If confirmed, overwrite the file with (header fields populated from current git branch, today's ISO date, and the `--contract` argument path):
   ```markdown
   ---
   status: Initialized
   branch: [current git branch]
   last_updated: [current ISO date]
   active_contract: [--contract argument path]
   schema_version: 1
   ---

   # Progress

   ## Current State
   - Status: Initialized
   - Branch: [current git branch]
   - Last updated: [current ISO date]
   - Active contract: [--contract argument path]

   ## Completed
   - Progress reset via /prometh-progress reset

   ## In Progress
   - *empty*

   ## Next
   - *empty*

   ## Blockers
   - *empty*

   ## Codebase State
   - Tests: unknown
   - Build: unknown
   - Known issues: none
   ```
3. Confirm the reset with the user.

## Rules

- The progress file is **always** `PROMETH-PROGRESS.local.md` at the project root. Never place it inside `prometh-docs/` or `prometh-docs.local/`.
- `--contract <file>` is mandatory on every invocation. Exit with an error if absent or if the file does not exist.
- Only one progress session is active at a time. If a progress file exists for a different contract, block with an error and name the active contract. Switching contracts requires completing or resetting the previous session.
- Always preserve the markdown structure — do not reorder top-level headings.
- Never invent commit hashes — only record hashes that actually appear in `git log`.
- When moving items between sections, do not drop context (keep the original phrasing).
- If the working tree is clean and there are no new commits since the last update, say so and make no changes.
- On branch drift (progress file `Branch:` ≠ current git branch), always warn and recommend `update`.
- Tolerate legacy progress files without a YAML front-matter header: display command prints a one-line note, and the next `update` synthesizes the header. Never fail because the header is missing.
- Treat the YAML front matter as derived output — always re-derive on `update` and `reset`, never merge stale values from an existing header.
- When all contract criteria reach `Pass` or `Manual` status, the progress file is automatically removed on the next `update`. The session is closed.

## Example Usage

```bash
# Display current progress for a contract
/prometh-progress --contract prometh-docs.local/contracts/sprint-7.md

# Update progress with session results
/prometh-progress --contract prometh-docs.local/contracts/sprint-7.md update

# Reset progress to initial template
/prometh-progress --contract prometh-docs.local/contracts/sprint-7.md reset
```
