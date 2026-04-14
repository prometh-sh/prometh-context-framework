---
description: View, update, or reset the harness progress file that bridges context windows across agent sessions
argument-hint: "[update|reset]"
allowed-tools: ["Read", "Write", "Edit", "Bash"]
---

# Prometh Progress Command

View or update the progress file that persists state across agent sessions. The progress file is the most important "memory" artifact in the harness — it is what a fresh agent reads at session start to understand where the previous session left off.

## Progress File Location

The progress file is **always** `PROMETH-PROGRESS.local.md` at the project root, regardless of whether the project uses committed (`prometh-docs/`) or local (`prometh-docs.local/`) documentation mode.

**Why at root, always `.local`:**

- Progress is ephemeral per-worktree session state, not project documentation.
- Placing it inside `prometh-docs/` would cause merge conflicts on every branch.
- Placing it inside `prometh-docs.local/` would collide when users symlink the local docs directory across worktrees.
- The `.local.` infix guarantees it is never committed (matches industry convention: `.env.local`, `settings.local.json`).
- Each git worktree gets its own `PROMETH-PROGRESS.local.md` — no sharing, no conflicts.

## Preconditions

1. `CLAUDE.md` or `CLAUDE.local.md` exists in project root. If neither is present, exit with an error directing the user to run `/prometh-init`.
2. Documentation directory exists (resolve for reading the harness manifest):
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
3. `PROMETH-PROGRESS.local.md` exists at project root. If missing (new worktree or first run), auto-create it using the initial template from the `reset` branch below, then continue with the requested action.

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
5. If a contract is active, append or update a subsection titled `### Contract: {name}` under `## Current State` listing which criteria are now met vs. still pending.
6. Write the updated content back to `PROMETH-PROGRESS.local.md`, preserving the top-level markdown structure (headings, ordering).
7. Report a short summary of what changed in the file to the user.

### Argument `reset`: rewrite to initial template

1. Ask the user to confirm: "This will replace `PROMETH-PROGRESS.local.md` with a fresh initial template. Continue? (y/N)"
2. If confirmed, overwrite the file with:
   ```markdown
   # Progress

   ## Current State
   - Status: Initialized
   - Branch: [current git branch]
   - Last updated: [current ISO date]

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
- Always preserve the markdown structure — do not reorder top-level headings.
- Never invent commit hashes — only record hashes that actually appear in `git log`.
- When moving items between sections, do not drop context (keep the original phrasing).
- If the working tree is clean and there are no new commits since the last update, say so and make no changes.
- On branch drift (progress file `Branch:` ≠ current git branch), always warn and recommend `update`.

## Example Usage

```bash
# Display current progress
/prometh-progress

# Update progress with session results
/prometh-progress update

# Reset progress to initial template
/prometh-progress reset
```
