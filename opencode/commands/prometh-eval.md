---
description: Evaluate the codebase against an active contract's acceptance criteria and write pass/fail results back
---

# Prometh Eval Command

Evaluate the current codebase state against the acceptance criteria of a contract. This is the feedback sensor loop closure: the contract declares what "done" looks like, and `/prometh-eval` checks whether the current code meets each criterion, updating the contract and progress file with the results.

## Preconditions

1. `AGENTS.md` or `CLAUDE.md` exists in project root.
2. Resolve docs dir and manifest:
   ```bash
   if [ -d "prometh-docs.local" ]; then
     DOCS_DIR="prometh-docs.local"
   elif [ -d "prometh-docs" ]; then
     DOCS_DIR="prometh-docs"
   else
     echo "❌ Prometh not initialized. Run /prometh-init first."
     exit 1
   fi

   if [ -f "${DOCS_DIR}/PROMETH.local.md" ]; then
     MANIFEST="${DOCS_DIR}/PROMETH.local.md"
   elif [ -f "PROMETH.local.md" ]; then
     MANIFEST="PROMETH.local.md"
   else
     MANIFEST="PROMETH.md"
   fi
   ```

## Process

### 1. Locate the contract

- If a contract name argument was provided, read `${DOCS_DIR}/contracts/{name}.md`.
- Otherwise, read the `### Contracts` section of the manifest and find the `Active:` line. Use that path.
- If no contract can be located, exit with: `❌ No active contract found. Run /prometh-contract {name} first.`

### 2. Parse the acceptance criteria table

Parse the `## Acceptance Criteria` markdown table. For each row, extract `#`, `Criterion`, `Verification`, `Type`, and current `Status`.

### 3. Evaluate each criterion

For each criterion, run the appropriate check:

#### computational

- If the `Verification` column contains a shell-executable command (e.g. `mise run test:unit`, `npm test`, `pytest path/to/test.py`), execute it via the available shell tool.
- Capture exit code, stdout tail, and stderr tail.
- Result:
  - Exit code 0 → `Pass`
  - Non-zero exit code → `Fail` (include a one-line reason from stderr)
  - Command not found or not runnable → `Fail` (include "verification command not executable")

**GUARDRAIL**: never mark a computational criterion `Pass` without actually executing the verification command. If the command cannot be run in the current environment, mark `Fail` and explain why, never `Pass`.

#### inferential

- Read the files, configurations, or code paths referenced in the `Verification` column.
- Perform a semantic assessment against the criterion text.
- Result:
  - Clearly met → `Pass` (include a one-line justification with file:line references)
  - Clearly not met → `Fail` (include specific, actionable feedback the next session can act on)
  - Partially met → `Partial` (include what is done and what remains)

#### manual

- Mark as `Manual` with the note "Requires human verification".
- Do not attempt automated evaluation.

### 4. Update the contract file

Rewrite the `## Acceptance Criteria` table with the updated `Status` column values. Preserve all other columns exactly.

For each `Fail` or `Partial` row, add a short note directly below the table in a `### Evaluation Notes` subsection:

```markdown
### Evaluation Notes
- Criterion #2 (Fail): {specific, actionable feedback}
- Criterion #5 (Partial): {what is done} / {what remains}
```

If a previous `### Evaluation Notes` subsection exists, replace it entirely.

Append or update an `## Evaluation Summary` block at the bottom of the contract (before any trailing attribution line):

```markdown
## Evaluation Summary
- Date: {ISO date}
- Pass: X / Y
- Fail: X / Y
- Partial: X / Y
- Manual: X / Y
- Overall: {Pass | Fail | Partial}
```

`Overall` rules:
- `Pass`: zero `Fail`, zero `Partial`, and every non-manual criterion is `Pass`
- `Fail`: any `Fail` in a non-manual criterion
- `Partial`: otherwise

### 5. Update progress file

Read `PROMETH-PROGRESS.local.md` at the project root and update it:

- Add an entry to `## Codebase State` that summarizes the evaluation result: `- Contract {name}: {Pass/Fail/Partial} (X pass, Y fail, Z partial, W manual)`
- If any criteria are `Fail` or `Partial`, add their actionable feedback to `## Next` so the next session picks them up
- Update `- Last updated:` to the current ISO date

### 6. Report

Render a concise summary to the user:

```
Contract: {name}
Date: {ISO date}

Pass:    X / Y
Fail:    X / Y   (see ### Evaluation Notes in the contract)
Partial: X / Y
Manual:  X / Y

Overall: {Pass | Fail | Partial}
```

If `Overall` is `Pass` and there are unresolved `Manual` checks, note that the contract cannot close until those are verified by a human.

## Rules

- Never mark a computational criterion as `Pass` without running the actual verification command — this is the cornerstone of the feedback loop.
- For `Fail` results, always include specific, file-referenced, actionable feedback that the next agent session can act on. Vague failures defeat the purpose of the harness.
- Do not modify sections of the contract outside of `## Acceptance Criteria`, `### Evaluation Notes`, and `## Evaluation Summary`.
- Preserve the contract's header, Metadata, Scope, Sensors Required, Out of Scope, Red Flags, Dependencies, and Change History sections untouched.
- Respect both committed (`prometh-docs/`) and local (`prometh-docs.local/`) modes.

## Example Usage

```bash
# Evaluate the active contract
/prometh-eval

# Evaluate a specific contract by name
/prometh-eval sprint-7
```
