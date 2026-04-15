```
██████╗ ██████╗  ██████╗ ███╗   ███╗███████╗████████╗██╗  ██╗
██╔══██╗██╔══██╗██╔═══██╗████╗ ████║██╔════╝╚══██╔══╝██║  ██║
██████╔╝██████╔╝██║   ██║██╔████╔██║█████╗     ██║   ███████║
██╔═══╝ ██╔══██╗██║   ██║██║╚██╔╝██║██╔══╝     ██║   ██╔══██║
██║     ██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗   ██║   ██║  ██║
╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝
                  CONTEXT FRAMEWORK
```

# Prometh Context Framework

> *"Just as Prometheus gave humanity fire, this framework gives AI users the tools to ignite high-quality, predictable output."*

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-green.svg)](https://docs.anthropic.com/en/docs/claude-code)
[![OpenCode](https://img.shields.io/badge/OpenCode-Compatible-blue.svg)](https://opencode.ai/)

A documentation-first **harness engineering** toolkit for coding agents. Prometh provides structured **slash commands** and **agent skills** that generate both sides of the feedback loop: **feedforward guides** (PRDs, SPECs, concepts, runbooks, contracts) that steer an agent *before* it acts, and **feedback sensors** (progress files, registered checks, contract evaluations) that let it self-correct *after* it acts.

## Harness Engineering at a Glance

PCF is built on the [harness engineering](https://martinfowler.com/articles/harness-engineering.html) pattern: agents need both *guides* (context in, before acting) and *sensors* (feedback out, after acting), plus persistent memory to bridge context windows across sessions.

```
FEEDFORWARD (Guides)                    FEEDBACK (Sensors)
────────────────────                    ──────────────────
prometh-prd         ──┐             ┌── /prometh-sensor (computational)
prometh-spec        ──┤             │   mise run terraform:validate,
prometh-doc concept ──┤             │   tflint, kubectl dry-run, eslint
prometh-doc runbook ──┤             │
/prometh-contract   ──┤    AGENT    ├── /prometh-sensor (inferential)
PROMETH.md          ──┤    ACTS     │   semantic review vs concept doc
CLAUDE.md / AGENTS.md ┤             │
Harness Protocol    ──┘             │
                                    └── /prometh-eval (evaluation)
                                        run contract criteria,
                                        compute pass / fail / partial
                            │
                            ▼
                    /prometh-progress update
                    (memories → next session)
                            │
                            ▼
                    HUMAN STEERS THE HARNESS
                    (iterate on guides & sensors
                     when failures repeat)
```

- **Guides** live in `prometh-docs/` (or `prometh-docs.local/`) and in the `## Prometh Harness Protocol` section that `/prometh-init` injects directly into `CLAUDE.md` / `AGENTS.md`.
- **Sensors** are registered via `/prometh-sensor add` and dual-written into both the manifest (`PROMETH.md`) and the agent file's inline `### Sensors` block, so every session automatically runs them before committing.
- **Contracts** codify what *done* means for a unit of work with testable acceptance criteria; `/prometh-eval` runs those criteria against the codebase and records results.
- **Progress** (`PROMETH-PROGRESS.local.md` at the project root) is the cross-session memory that a fresh agent reads at session start and writes at session end. It is **per-worktree and always gitignored** — each branch/worktree maintains its own state, never shared, never committed. An optional YAML front-matter header (`status`, `branch`, `last_updated`, `active_contract`, `schema_version`) gives orchestrators and dashboards a stable parse surface without invoking an LLM.
- **Humans** remain in the loop — when failures repeat, the human iterates on the guides and sensors, not on each individual agent run.

## Architecture Overview

The framework follows the same structure on both platforms: **8 slash commands** for workflow and harness operations, **3 skills** for document generation.

| Type | Claude Code | OpenCode | What it does |
|------|-------------|----------|--------------|
| **Slash commands** | `.claude/commands/` | `.opencode/commands/` | `init`, `build`, `status`, `help`, `progress`, `contract`, `eval`, `sensor` |
| **Skills** | `.claude/skills/*/SKILL.md` | `.opencode/skills/*/SKILL.md` | `prd`, `spec`, `doc` |
| **Output styles** | `.claude/output-styles/` | *(embedded inline)* | Templates referenced by skills and contract generation |

**Skills** can be invoked explicitly by name or automatically — describe what you need in conversation and the agent loads the right skill contextually. **Slash commands** run on demand.

## Features

### Feedforward — Guide Generation

**Slash commands:**
- **`/prometh-init`** — Initialize the framework in any project; injects the `## Prometh Harness Protocol` section into `CLAUDE.md` / `AGENTS.md`, creates `PROMETH-PROGRESS.local.md` at the project root, sets up contracts and archive directories, and adds the progress file to `.gitignore`
- **`/prometh-build`** — Execute a SPEC with interactive 3-phase implementation tracking
- **`/prometh-status`** — Display project dashboard, harness panel, and agent-file sync check
- **`/prometh-help`** — Display the full command and skill reference

**Skills (invoked contextually — describe your intent in conversation):**
- **`prometh-prd`** — Create or normalize strategic Product Requirements Documents
- **`prometh-spec`** — Create or normalize implementation SPECs with 3-phase workflow
- **`prometh-doc`** — Generate README, Runbook, or Concept documentation

### Feedback — Harness Engineering

- **`/prometh-contract <name>`** — Generate a sprint or feature contract with testable acceptance criteria (each marked `computational`, `inferential`, or `manual`), required sensors, and Red Flags / Risk Assessment
- **`/prometh-eval [contract-name]`** — Evaluate the codebase against an active contract. Runs each criterion by type, records `Pass` / `Fail` / `Partial` / `Manual`, writes an Evaluation Summary, and pipes results into `PROMETH-PROGRESS.local.md`
- **`/prometh-progress [update|reset]`** — View, refresh, or reset the cross-session progress file. `update` reads git log, diff, and active contract to bridge memory between sessions
- **`/prometh-sensor add <name> <cmd> --type <t> --when <w>`** — Register a feedback sensor. Computational pre-commit sensors are dual-written to both the manifest and the inline `### Sensors` block in `CLAUDE.md` / `AGENTS.md`
- **`/prometh-sensor list`** — Display all registered sensors grouped by timing (pre-commit, pipeline, pre-PR)
- **`/prometh-sensor remove <name>`** — Remove a sensor from both the manifest and the agent file

### Output Style Templates (Claude Code)

Eight reusable templates referenced by skills and slash commands:
- `prometh-prd` — Unified PRD template (14 sections)
- `prometh-spec` — Unified SPEC template with 3-phase workflow
- `prometh-contract` — Harness contract with testable acceptance criteria and Red Flags
- `prometh-doc-readme` — Lean README landing page (5-min read, links to companions)
- `prometh-doc-readme-getting-started` — Full tutorial walkthrough for `docs/getting-started.md`
- `prometh-doc-readme-contributing` — Contributor guide for `CONTRIBUTING.md`
- `prometh-doc-runbook` — Operational procedures template
- `prometh-doc-concept` — Technology, architecture, and domain deep-dive template

## Quick Start

### Installation

```bash
# Clone the repository
git clone https://github.com/prometh-sh/prometh-context-framework.git
cd prometh-context-framework

# Interactive mode — choose platform(s)
./setup.sh

# Or specify directly
./setup.sh --claude      # Claude Code only
./setup.sh --opencode    # OpenCode only
./setup.sh --all         # Both platforms
```

### Verify installation

```bash
# Claude Code
ls ~/.claude/commands/prometh-*
ls ~/.claude/skills/prometh-*/SKILL.md
ls ~/.claude/output-styles/prometh-*

# OpenCode
ls ~/.config/opencode/commands/prometh-*
ls ~/.config/opencode/skills/prometh-*/SKILL.md
```

### Initialize in a project

```bash
cd /path/to/your/project

# Claude Code: create CLAUDE.md first (if not already present)
/init

# Initialize Prometh Framework — creates docs dirs, PROMETH-PROGRESS.local.md,
# contracts/, archive dirs, and injects the Harness Protocol into CLAUDE.md/AGENTS.md
/prometh-init
```

`/prometh-init` will prompt you to choose between:
- **Committed documentation** (`prometh-docs/` + `PROMETH.md`) — tracked in git, shared with team
- **Local-only documentation** (`prometh-docs.local/` + `PROMETH.local.md`) — stays on your machine

It will then:
1. Create the documentation directories (`prds/archive/`, `specs/archive/`, `concepts/`, `runbooks/`, `adrs/`, `contracts/archive/`)
2. Create `PROMETH-PROGRESS.local.md` at the project root (per-worktree ephemeral state — never inside `prometh-docs/`)
3. Append `PROMETH-PROGRESS.local.md` to `.gitignore` so it is never committed
4. Extend the manifest with the `## Harness Configuration` section (Guides, Sensors, Contracts, Progress, Red Flags)
5. Inject the `## Prometh Harness Protocol` section into your agent file — idempotently (re-running replaces, never duplicates)

## Usage

### Creating a PRD

```bash
# Via skill — naturally in conversation (Claude Code & OpenCode):
# "Create a PRD for our mobile customer platform"
# "Normalize this strategic document into a PRD" (then paste/reference the file)
# "Convert quarterly-planning.pdf into a PRD"
```

### Creating a SPEC

```bash
# Via skill — naturally in conversation:
# "Create a SPEC for the user authentication feature"
# "Convert this bug report into a SPEC"
# "Derive a SPEC from prometh-docs/prds/mobile-platform-prd.md"
```

### Generating Documentation

```bash
# Via skill — naturally in conversation:
# "Generate a README for this project"
# "Write an operational runbook for the deployment process"
# "Write concept documentation for new team members"
```

### Executing a SPEC

```bash
/prometh-build prometh-docs/specs/feature-user-auth-spec.md
```

Guides you through all 3 phases interactively, updating the tracking file at each milestone.

### Creating a Contract

```bash
# Generate a contract that codifies what "done" means for a sprint or feature
/prometh-contract sprint-7
/prometh-contract auth-rewrite
```

Every criterion must be testable and must declare a verification type: `computational` (tool), `inferential` (semantic review), or `manual` (human). At least one computational sensor is required.

### Registering Sensors

```bash
# Computational pre-commit sensor (dual-written to agent file's ### Sensors block)
/prometh-sensor add terraform-validate "mise run terraform:validate" \
  --type computational --when pre-commit

# Pipeline-only computational sensor (manifest only, not run by the agent)
/prometh-sensor add terratest "mise run terraform:test" \
  --type computational --when pipeline

# Inferential pre-PR review
/prometh-sensor add architecture-review "Review changes against concept doc" \
  --type inferential --when pre-pr

# List and remove
/prometh-sensor list
/prometh-sensor remove terraform-validate
```

### Evaluating a Contract

```bash
/prometh-eval              # Evaluate the active contract
/prometh-eval sprint-7     # Evaluate a specific contract
```

Runs computational criteria, semantically checks inferential criteria, flags manual ones, and writes a `## Evaluation Summary` block back into the contract. Failing criteria are piped into `PROMETH-PROGRESS.local.md` under `## Next` so the next agent session picks them up — that's the feedback loop in action.

### Bridging Sessions with Progress

```bash
/prometh-progress          # Display current state
/prometh-progress update   # Refresh from git log, diff, and active contract
/prometh-progress reset    # Wipe to initial template (with confirmation)
```

The `## Prometh Harness Protocol` in your agent file instructs every new session to read `PROMETH-PROGRESS.local.md` at start and call `/prometh-progress update` at end — no hooks, no external runner.

### Monitoring project status

```bash
/prometh-status            # Full dashboard (inventory + harness panel)
/prometh-status --brief    # Condensed one-line summary
/prometh-status --counts   # Document counts only
/prometh-status --health   # Doc health + harness readiness scorecard (adopted projects)
/prometh-status --harness  # Harness readiness scorecard only (13 checks)
```

The harness panel reports active contract state, progress summary, sensor counts by timing, harness health, and an **agent-file sync check** that diffs the inline `### Sensors` block against the computational pre-commit rows in the manifest so drift is caught before it matters. The `--harness` readiness scorecard runs 13 checks across Guides, Sensors, Contracts, Progress, and Codebase, and auto-detects docs-only vs. harness-adopted projects.

## Complete Workflow

```
Strategic Vision  →  Plan  →  Contract  →  Guided Execution  →  Evaluation  →  Delivery
  prometh-prd      prometh-spec  /prometh-contract  /prometh-build    /prometh-eval    Completed
     (skill)         (skill)    (slash command)    (slash command)  (slash command)
                                       │
                                       ▼
                                 feedback loops back into
                                 PROMETH-PROGRESS.local.md and sensors
```

### Example: Feature delivery end-to-end

```bash
# 1. Define strategic requirements (skill — invoked naturally)
# "Create a PRD for our mobile platform"
# → prometh-docs/prds/mobile-platform-prd.md

# 2. Generate implementation SPEC from PRD (skill — invoked naturally)
# "Derive a SPEC from prometh-docs/prds/mobile-platform-prd.md"
# → prometh-docs/specs/feature-mobile-platform-spec.md

# 3. Write the contract that defines "done"
/prometh-contract mobile-platform-v1

# 4. Register the sensors the contract will lean on
/prometh-sensor add unit-tests   "mise run test:unit"    --type computational --when pre-commit
/prometh-sensor add lint         "mise run lint"         --type computational --when pre-commit
/prometh-sensor add integration  "mise run test:int"     --type computational --when pipeline

# 5. Execute with guided tracking
/prometh-build prometh-docs/specs/feature-mobile-platform-spec.md

# 6. Evaluate against the contract
/prometh-eval mobile-platform-v1

# 7. Bridge to the next session
/prometh-progress update

# 8. Monitor end-to-end health
/prometh-status
```

## Repository Structure

```
prometh-context-framework/
├── .claude/
│   ├── commands/              # 8 slash commands
│   │   ├── prometh-init.md
│   │   ├── prometh-build.md
│   │   ├── prometh-status.md
│   │   ├── prometh-help.md
│   │   ├── prometh-progress.md
│   │   ├── prometh-contract.md
│   │   ├── prometh-eval.md
│   │   └── prometh-sensor.md
│   ├── skills/                # 3 agent skills (each in own directory)
│   │   ├── prometh-prd/SKILL.md
│   │   ├── prometh-spec/SKILL.md
│   │   └── prometh-doc/SKILL.md
│   └── output-styles/         # 8 output templates
│       ├── prometh-prd.md
│       ├── prometh-spec.md
│       ├── prometh-contract.md
│       ├── prometh-doc-readme.md
│       ├── prometh-doc-readme-getting-started.md
│       ├── prometh-doc-readme-contributing.md
│       ├── prometh-doc-runbook.md
│       └── prometh-doc-concept.md
├── .opencode/
│   ├── commands/              # 8 slash commands (self-contained)
│   └── skills/                # 3 agent skills (templates embedded inline)
│       ├── prometh-prd/SKILL.md
│       ├── prometh-spec/SKILL.md
│       └── prometh-doc/SKILL.md
├── setup.sh                   # Multi-platform installation script
├── CLAUDE.md                  # Claude Code configuration
├── AGENTS.md                  # OpenCode / general agent configuration
└── LICENSE                    # Apache License 2.0
```

After `/prometh-init` runs in a target project:

```
your-project/
├── CLAUDE.md  (or AGENTS.md)  # contains injected ## Prometh Harness Protocol
├── PROMETH.md                 # harness manifest (committed mode)
├── PROMETH-PROGRESS.local.md  # per-worktree cross-session memory (always gitignored)
└── prometh-docs/
    ├── prds/
    ├── specs/
    ├── concepts/
    ├── runbooks/
    ├── adrs/
    └── contracts/
        ├── sprint-7.md
        └── archive/
```

In local mode, everything collapses under `prometh-docs.local/` and the manifest is `PROMETH.local.md` *inside* that directory.

## Platform Compatibility

| Platform | Config File | Slash Commands | Skills |
|----------|-------------|----------------|--------|
| **Claude Code** | `CLAUDE.md` / `CLAUDE.local.md` | `~/.claude/commands/` | `~/.claude/skills/` |
| **OpenCode** | `AGENTS.md` / `AGENTS.local.md` | `~/.config/opencode/commands/` | `~/.config/opencode/skills/` |

**Platform differences:**
- **Claude Code skills and `/prometh-contract`** reference output-style templates from `~/.claude/output-styles/` — templates live separately from skill logic
- **OpenCode skills and `/prometh-contract`** are fully self-contained — templates are embedded inline
- On both platforms, skills (`prometh-prd`, `prometh-spec`, `prometh-doc`) are invoked contextually by the agent or by describing your intent in conversation — not via `/` slash syntax
- The Harness Protocol is injected into whichever agent file is present: `CLAUDE.md` for Claude Code, `AGENTS.md` for OpenCode
- **README generation** produces 3 commit-ready files: `README.md` (lean landing page), `docs/getting-started.md` (full tutorial), and `CONTRIBUTING.md` (contributor guide)

## Document Lifecycle

**PRD status**: `Draft` → `Under Review` → `Approved` → `Active` → `Completed` → `Deprecated`

**SPEC status**: `Draft` → `Under Review` → `Approved` → `In Progress` → `Testing` → `Completed`

**Contract status**: `Active` → `Superseded` · `Completed` · `Archived`

**SPEC types**: `Feature` · `Bug Fix` · `Enhancement` · `Technical Task`

**Filename conventions** (when `## Document Configuration` is set in `PROMETH.md`):

| Document type | Default pattern | Example |
|---------------|-----------------|---------|
| PRD | `PRD-{DATE}-{NAME}.md` | `PRD-20260223-mobile-strategy.md` |
| SPEC | `SPC-{DATE}-{NAME}.md` | `SPC-20260223-user-authentication.md` |
| Concept doc | `{DATETIME}-{NAME}.md` | `202602231830-architecture-overview.md` |
| Contract | `{name}.md` (kebab-case) | `sprint-7.md`, `auth-rewrite.md` |
| README | `README.md` (fixed) | — |
| RUNBOOK | `RUNBOOK.md` (fixed) | — |

Tokens: `{DATE}` = `YYYYMMDD`, `{DATETIME}` = `YYYYMMDDHHMM`, `{NAME}` = slugified title.
Without configuration, skills fall back to legacy patterns (`[name]-prd.md`, `feature-[name]-spec.md`).

## Configuration

### Directory structure (per project)

Choose during `/prometh-init`:

**Committed** (team projects, tracked in git):
```
prometh-docs/
├── prds/archive/
├── specs/archive/
├── concepts/
├── runbooks/
├── adrs/
└── contracts/archive/
PROMETH.md
PROMETH-PROGRESS.local.md   # project root, always gitignored (per-worktree)
```

**Local-only** (personal, not committed):
```
prometh-docs.local/
├── prds/archive/
├── specs/archive/
├── concepts/
├── runbooks/
├── adrs/
├── contracts/archive/
└── PROMETH.local.md
PROMETH-PROGRESS.local.md   # project root, always gitignored (per-worktree)
```

If both exist, `.local` variants always take precedence.

### Migrating from legacy `docs/` directory

Run `/prometh-init` — it detects an existing `docs/` directory and offers to migrate it automatically.

## Document Configuration

The `## Document Configuration` section in `PROMETH.md` or `PROMETH.local.md` controls two behaviours for all skills — **metadata injection** and **filename patterns**. Both sub-sections are optional; if absent, skills fall back to legacy defaults.

When you run `/prometh-init` this section is created automatically. For existing projects initialized before this feature was added, paste it manually (see [Adding to an existing PROMETH.md](#adding-to-an-existing-promethmd)).

### Metadata Template

Every new document created inside `prometh-docs/` or `prometh-docs.local/` (PRDs, SPECs, Concept docs, Contracts) receives a YAML frontmatter block at the top, populated from this template plus three fields computed at creation time:

| Field | Source |
|-------|--------|
| `title` | Extracted from the first `# H1` heading of the generated document |
| `created` | ISO 8601 timestamp at creation time (e.g. `2026-02-23T18:30:29`) |
| `uuid` | Freshly generated UUID v4 per document |
| All other fields | Copied from the template in `PROMETH.md` |

> README.md and RUNBOOK.md written to the project root are **never** given metadata frontmatter.
> If the `### Metadata Template` block is absent or empty, injection is skipped with an `ℹ️` message.

**Example resulting frontmatter on a generated document:**

```yaml
---
title: "Mobile App Platform Strategy"
created: "2026-02-23T18:30:29"
author: "Your Name"
focus: "Personal"
tags:
  - mobile
  - strategy
project:
  - name: "Your Project Name"
    uuid: "YOUR-PROJECT-UUID"
status: "Draft"
uuid: "GENERATED-UUID-V4-PER-DOCUMENT"
related: []
---
```

### Filename Patterns

Controls the filename format for PRDs, SPECs, and Concept docs. Supported tokens:

| Token | Expands to |
|-------|-----------|
| `{DATE}` | Current date — `YYYYMMDD` (e.g. `20260223`) |
| `{DATETIME}` | Current datetime — `YYYYMMDDHHMM` (e.g. `202602231830`) |
| `{NAME}` | Slugified title — lowercase, hyphens, stop-words removed (e.g. `mobile-app-strategy`) |

**Default patterns (set by `/prometh-init`):**

```yaml
prd_pattern: "PRD-{DATE}-{NAME}.md"
spec_pattern: "SPC-{DATE}-{NAME}.md"
concept_pattern: "{DATETIME}-{NAME}.md"
```

You can customize any pattern freely. For example, to prefix with a project code:

```yaml
prd_pattern: "ACME-PRD-{DATE}-{NAME}.md"
spec_pattern: "ACME-SPC-{DATE}-{NAME}.md"
concept_pattern: "{DATE}-{NAME}.md"
```

### Adding to an existing PROMETH.md

If your project was initialized before this feature was added, paste the following block into `PROMETH.md` or `PROMETH.local.md` **between** the `## Project Configuration` section and the `## Document Inventory` section:

```markdown
## Document Configuration

*Project-level configuration read by all Prometh skills before creating any document.
Both sub-sections are optional — if absent, skills fall back to legacy defaults.*

### Metadata Template

*YAML frontmatter injected into every new document created inside `prometh-docs/` or
`prometh-docs.local/`. Remove or leave this block empty to disable metadata injection.*

```yaml
author: "Your Name"
focus: "Personal"
tags: []
project:
  - name: "Your Project Name"
    uuid: "YOUR-PROJECT-UUID"
status: Draft
related: []
```

```
> `title`, `created`, and `uuid` are computed automatically at document creation time
> and are never stored here.

### Filename Patterns

*Filename patterns applied when skills generate new documents. Supported tokens:
`{DATE}` (YYYYMMDD), `{DATETIME}` (YYYYMMDDHHMM), `{NAME}` (slugified title).*

```yaml
prd_pattern: "PRD-{DATE}-{NAME}.md"
spec_pattern: "SPC-{DATE}-{NAME}.md"
concept_pattern: "{DATETIME}-{NAME}.md"
```

```
> README.md and RUNBOOK.md always use fixed names regardless of this config.
> Remove this block to fall back to legacy patterns (e.g. `mobile-strategy-prd.md`).
```

Fill in `author`, `focus`, and `project` with your own values. The `tags`, `related`, and `status` fields can be left at their defaults — skills will copy them into each new document as-is.

## References

Harness engineering is an established pattern in long-running agent research:

- [Boeckeler — *Harness Engineering*](https://martinfowler.com/articles/harness-engineering.html) (martinfowler.com)
- [Anthropic — *Effective Harnesses for Long-Running Agents*](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents)
- [Anthropic — *Harness Design for Long-Running Apps*](https://www.anthropic.com/engineering/harness-design-long-running-apps)
- [OpenAI — *Harness Engineering*](https://openai.com/index/harness-engineering/)

PCF operationalizes these ideas as a pure-markdown toolkit with no external runtime — the agent file itself is the harness entry point.

## Contributing

1. Branch from `main`: `git checkout -b feature/<name>` or `fix/<name>`
2. **Slash commands**: update both `.claude/commands/` and `.opencode/commands/`
3. **Skills**: update both `.claude/skills/<name>/SKILL.md` and `.opencode/skills/<name>/SKILL.md` (Claude Code skills reference output-styles; OpenCode skills embed templates inline)
4. **Output-style templates**: only `.claude/output-styles/` (OpenCode embeds inline)
5. Run `./setup.sh --all` to verify installation
6. Update `CHANGELOG.md` under `[Unreleased]`
7. Commit format: `<Category>: <description>` — e.g., `Add: prometh-contract output style`

## License

Apache License 2.0 — see [LICENSE](LICENSE).

## Related Projects

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — Official Claude CLI tool
- [OpenCode](https://opencode.ai) — Open source AI coding agent for the terminal
- [Agent Skills Standard](https://agentskills.io) — The open standard both platforms use for skills

---

*Ready to ignite high-quality, predictable output! 🔥*
