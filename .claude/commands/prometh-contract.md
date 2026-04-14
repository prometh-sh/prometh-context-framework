---
description: Generate a sprint or feature contract with testable acceptance criteria, verification types, and risk assessment
argument-hint: "<contract-name>"
allowed-tools: ["Read", "Write", "Edit", "Glob", "Grep", "Bash"]
---

# Prometh Contract Command

Generate a sprint or feature contract that codifies what "done" means for a chunk of work. A contract is the feedback loop counterpart to a PRD: PRDs describe strategic intent, contracts describe verifiable completion criteria. `/prometh-eval` later runs these criteria against the codebase.

## Preconditions

1. `CLAUDE.md` or `CLAUDE.local.md` exists in project root. If missing, instruct the user to run `/prometh-init`.
2. Resolve the documentation directory and manifest:
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
3. `${DOCS_DIR}/contracts/` exists. If missing, create it together with `contracts/archive/`.
4. A contract name was provided as the command argument. If missing, prompt the user for one (kebab-case, e.g. `sprint-7` or `auth-rewrite`).

## Process

### 1. Gather scope

Ask the user for:
- **Ticket IDs** (optional, comma-separated, e.g. `KC-4044, KNF-0330`)
- **Feature description or sprint goal** — what is being built or changed, and why
- **Relevant code paths or components** — which files, modules, or services are in scope

If the user already provided this in the initial invocation text, reuse it and skip the prompt.

### 2. Analyze codebase context

Before drafting criteria, gather grounding context so the criteria are specific and testable:

- Read any existing concept docs under `${DOCS_DIR}/concepts/` that touch the scope
- Read any related PRDs under `${DOCS_DIR}/prds/` and SPECs under `${DOCS_DIR}/specs/`
- Use `Glob` and `Grep` to locate relevant source files, existing tests, and current architecture
- Read current test structure to propose realistic computational verification commands
- Check the active contract (if any) so a new contract does not duplicate or contradict it

### 3. Draft the contract

Use the template at `.claude/output-styles/prometh-contract.md` as the structural guide. Write the contract to `${DOCS_DIR}/contracts/{name}.md`.

Required sections (in this order):

1. `# Contract: {name}`
2. `## Metadata` — Created, Sprint/Feature, Tickets, Status: Active, Owner
3. `## Scope` — one-to-three paragraph description grounded in the Step 2 analysis
4. `## Acceptance Criteria` — a markdown table with columns `# | Criterion | Verification | Type | Status`
5. `## Sensors Required` — at least one computational sensor referenced
6. `## Out of Scope`
7. `## Red Flags and Risk Assessment` — Critical / High / Medium / Low
8. `## Dependencies`
9. `## Change History`

### 4. Register as active contract

Update the `### Contracts` section of the manifest:

```markdown
### Contracts
- Active: ${DOCS_DIR}/contracts/{name}.md
- Directory: ${DOCS_DIR}/contracts/
- Archive: ${DOCS_DIR}/contracts/archive/
```

If a different contract was previously marked Active, move that contract's Status from `Active` to `Superseded` inside its own file (do not delete it), and replace the `Active:` line in the manifest with the new contract.

### 5. Report

Confirm to the user:
- Contract file path
- Number of criteria by type (computational / inferential / manual)
- Sensors referenced in the contract — warn if any are not yet registered in the harness (suggest `/prometh-sensor add` for each)

## Rules

- Every criterion MUST be testable. Reject vague statements like "code quality is good" or "performance is acceptable" — rewrite them as measurable conditions (e.g., "p95 latency under 200ms measured via `mise run bench`").
- Every criterion MUST declare exactly one verification type: `computational`, `inferential`, or `manual`.
- Every criterion MUST include a concrete verification method (exact command, file path to inspect, or review instruction).
- At least one computational sensor MUST appear in `## Sensors Required`. A contract with only inferential and manual checks is not acceptable — there must be something the harness can deterministically verify.
- The `## Red Flags and Risk Assessment` section is mandatory and must have entries across at least Critical and High (use "none" if truly absent).
- Do not use emojis, bold in headings, or heading levels deeper than `####` — follow PCF markdown conventions.
- Do not register a contract whose name collides with an existing file in `${DOCS_DIR}/contracts/` without first asking the user whether to overwrite.

## Example Usage

```bash
# Generate a contract for sprint 7
/prometh-contract sprint-7

# Generate a contract for a feature
/prometh-contract auth-rewrite
```
