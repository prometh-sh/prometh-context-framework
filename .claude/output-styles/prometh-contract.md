---
name: Prometh Contract
description: Template for harness contracts with testable acceptance criteria, verification types, and risk assessment
---

# Contract: {name}

## Metadata
- Created: {ISO date}
- Sprint/Feature: {name}
- Tickets: {comma-separated ticket IDs, or "none"}
- Status: Active
- Owner: {author or team}

## Scope

{One-to-three paragraph description of what will be built or changed. Include the problem being solved, the expected user-facing outcome, and the affected code paths or components. This is the "why" that the acceptance criteria below will measure.}

## Acceptance Criteria

Each criterion MUST be testable and MUST declare its verification type:

- **computational**: can be checked by a deterministic tool (test suite, linter, validator, schema check)
- **inferential**: requires semantic review by an agent or human (code review, architecture alignment, naming consistency)
- **manual**: requires human verification (UI walkthrough, stakeholder sign-off, production dry-run)

| # | Criterion | Verification | Type | Status |
|---|-----------|--------------|------|--------|
| 1 | {specific testable criterion} | {how to verify — exact command, file path, or review instruction} | computational | Pending |
| 2 | {specific testable criterion} | {how to verify} | inferential | Pending |
| 3 | {specific testable criterion} | {how to verify} | manual | Pending |

Status values during evaluation: `Pending` · `Pass` · `Fail` · `Partial` · `Manual`.

## Sensors Required

At least one computational sensor MUST be listed here. Reference sensors already registered in the harness (via `/prometh-sensor list`) or propose new ones to register before contract evaluation.

- `{sensor-name}` — {brief purpose}
- `{sensor-name}` — {brief purpose}

## Out of Scope

{Explicitly excluded items — features, refactors, or edge cases that are intentionally NOT part of this contract. This section prevents scope creep and makes evaluation boundaries unambiguous.}

- {excluded item}
- {excluded item}

## Red Flags and Risk Assessment

- **Critical**: {risks that would block delivery or cause data loss / outages}
- **High**: {risks that would degrade quality or user experience significantly}
- **Medium**: {risks that need monitoring but are manageable}
- **Low**: {acceptable trade-offs or minor known limitations}

## Dependencies

{Other contracts, PRs, infrastructure changes, or external services this contract depends on. Leave empty if none.}

## Change History

| Date | Author | Change |
|------|--------|--------|
| {ISO date} | {author} | Contract created |

---

Generated with: **Prometh Context Framework by Prometh**
