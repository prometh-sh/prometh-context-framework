---
description: Generate a sprint or feature contract with testable acceptance criteria, verification types, and risk assessment
---

# Prometh Contract Command

Generate a sprint or feature contract that codifies what "done" means for a chunk of work. A contract is the feedback loop counterpart to a PRD: PRDs describe strategic intent, contracts describe verifiable completion criteria. `/prometh-eval` later runs these criteria against the codebase.

## Preconditions

1. `AGENTS.md` or `CLAUDE.md` exists in project root. If missing, instruct the user to run `/prometh-init`.
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
- Locate relevant source files, existing tests, and current architecture via grep/glob
- Read current test structure to propose realistic computational verification commands
- Check the active contract (if any) so a new contract does not duplicate or contradict it

### 3. Draft the contract

Write the contract to `${DOCS_DIR}/contracts/{name}.md` using this exact template. Substitute the bracketed placeholders with real values, keep all section headings, and preserve ordering:

```markdown
# Contract: {name}

## Metadata
- Created: {ISO date}
- Sprint/Feature: {name}
- Tickets: {comma-separated ticket IDs, or "none"}
- Status: Active
- Owner: {author or team}

## Scope

{One-to-three paragraph description of what will be built or changed. Include the problem being solved, the expected user-facing outcome, and the affected code paths or components.}

## Acceptance Criteria

Each criterion MUST be testable and MUST declare its verification type:

- **computational**: can be checked by a deterministic tool (test suite, linter, validator, schema check)
- **inferential**: requires semantic review by an agent or human (code review, architecture alignment, naming consistency)
- **manual**: requires human verification (UI walkthrough, stakeholder sign-off, production dry-run)

| # | Criterion | Verification | Type | Status |
|---|-----------|--------------|------|--------|
| 1 | {specific testable criterion} | {how to verify} | computational | Pending |
| 2 | {specific testable criterion} | {how to verify} | inferential | Pending |
| 3 | {specific testable criterion} | {how to verify} | manual | Pending |

Status values during evaluation: `Pending` · `Pass` · `Fail` · `Partial` · `Manual`.

## Sensors Required

At least one computational sensor MUST be listed here.

- `{sensor-name}` — {brief purpose}

## Out of Scope

{Explicitly excluded items.}

- {excluded item}

## Red Flags and Risk Assessment

- **Critical**: {risks that would block delivery or cause data loss / outages}
- **High**: {risks that would degrade quality or user experience significantly}
- **Medium**: {risks that need monitoring but are manageable}
- **Low**: {acceptable trade-offs or minor known limitations}

## Dependencies

{Other contracts, PRs, infrastructure changes, or external services this contract depends on.}

## Change History

| Date | Author | Change |
|------|--------|--------|
| {ISO date} | {author} | Contract created |

---

Generated with: **Prometh Context Framework by Prometh**
```

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
- At least one computational sensor MUST appear in `## Sensors Required`. A contract with only inferential and manual checks is not acceptable.
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
