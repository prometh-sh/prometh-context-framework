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

A documentation-first AI tooling framework that provides structured **slash commands** and **agent skills** for creating strategic PRDs, implementation SPECs, and technical documentation — delivering predictable, high-quality output for software development teams.

## See It In Action

https://github.com/user-attachments/assets/bd6d5bbf-948e-4eb7-96b3-1a4077994633

## Architecture Overview

The framework follows the same structure on both platforms: **4 slash commands** for workflow operations, **3 skills** for document creation.

| Type | Claude Code | OpenCode | What it does |
|------|-------------|----------|--------------|
| **Slash commands** | `.claude/commands/` | `.opencode/commands/` | `init`, `build`, `status`, `help` |
| **Skills** | `.claude/skills/*/SKILL.md` | `.opencode/skills/*/SKILL.md` | `prd`, `spec`, `doc` |

**Skills** can be invoked explicitly by name or automatically — just describe what you need in conversation and the agent loads the right skill contextually.

## Features

### Slash Commands (all platforms)
- **`/prometh-init`** — Initialize the framework in any project
- **`/prometh-build`** — Execute a SPEC with interactive 3-phase implementation tracking
- **`/prometh-status`** — Display project documentation dashboard with health metrics
- **`/prometh-help`** — Display the full command and skill reference

### Skills (invoked contextually — describe your intent in conversation)
- **`prometh-prd`** — Create or normalize strategic Product Requirements Documents
- **`prometh-spec`** — Create or normalize implementation SPECs with 3-phase workflow
- **`prometh-doc`** — Generate README, Runbook, or Concept documentation

### Output Style Templates (Claude Code)
Seven reusable templates referenced by skills:
- `prometh-prd` — Unified PRD template (14 sections)
- `prometh-spec` — Unified SPEC template with 3-phase workflow
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

# Initialize Prometh Framework
/prometh-init
```

`/prometh-init` will prompt you to choose between:
- **Committed documentation** (`prometh-docs/` + `PROMETH.md`) — tracked in git, shared with team
- **Local-only documentation** (`prometh-docs.local/` + `PROMETH.local.md`) — stays on your machine

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

### Monitoring project status

```bash
/prometh-status           # Full dashboard
/prometh-status --brief   # Condensed one-line summary
/prometh-status --counts  # Document counts only
/prometh-status --health  # Health metrics and suggestions
```

## Complete Workflow

```
Strategic Vision  →  Implementation Plan  →  Guided Execution  →  Delivery
  prometh-prd          prometh-spec           /prometh-build      Completed
     (skill)              (skill)             (slash command)
```

### Example: Feature delivery end-to-end

```bash
# 1. Define strategic requirements (skill — invoked naturally)
# "Create a PRD for our mobile platform"
# → prometh-docs/prds/mobile-platform-prd.md

# 2. Generate implementation SPEC from PRD (skill — invoked naturally)
# "Derive a SPEC from prometh-docs/prds/mobile-platform-prd.md"
# → prometh-docs/specs/feature-mobile-platform-spec.md

# 3. Execute with guided tracking (slash command)
/prometh-build prometh-docs/specs/feature-mobile-platform-spec.md

# 4. Generate documentation (skill — invoked naturally)
# "Generate a README for this project"

# 5. Monitor progress (slash command)
/prometh-status
```

## Repository Structure

```
prometh-context-framework/
├── .claude/
│   ├── commands/              # 4 slash commands
│   │   ├── prometh-init.md
│   │   ├── prometh-build.md
│   │   ├── prometh-status.md
│   │   └── prometh-help.md
│   ├── skills/                # 3 agent skills (each in own directory)
│   │   ├── prometh-prd/
│   │   │   └── SKILL.md
│   │   ├── prometh-spec/
│   │   │   └── SKILL.md
│   │   └── prometh-doc/
│   │       └── SKILL.md
│   └── output-styles/         # 7 output templates (referenced by skills)
│       ├── prometh-prd.md
│       ├── prometh-spec.md
│       ├── prometh-doc-readme.md
│       ├── prometh-doc-readme-getting-started.md
│       ├── prometh-doc-readme-contributing.md
│       ├── prometh-doc-runbook.md
│       └── prometh-doc-concept.md
├── .opencode/
│   ├── commands/              # 4 slash commands (self-contained)
│   │   ├── prometh-init.md
│   │   ├── prometh-build.md
│   │   ├── prometh-status.md
│   │   └── prometh-help.md
│   └── skills/                # 3 agent skills (templates embedded inline)
│       ├── prometh-prd/
│       │   └── SKILL.md
│       ├── prometh-spec/
│       │   └── SKILL.md
│       └── prometh-doc/
│           └── SKILL.md
├── setup.sh                   # Multi-platform installation script
├── CLAUDE.md                  # Claude Code configuration
├── AGENTS.md                  # OpenCode / general agent configuration
└── LICENSE                    # Apache License 2.0
```

## Platform Compatibility

| Platform | Config File | Slash Commands | Skills |
|----------|-------------|----------------|--------|
| **Claude Code** | `CLAUDE.md` / `CLAUDE.local.md` | `~/.claude/commands/` | `~/.claude/skills/` |
| **OpenCode** | `AGENTS.md` / `AGENTS.local.md` | `~/.config/opencode/commands/` | `~/.config/opencode/skills/` |

**Platform differences:**
- **Claude Code skills** reference output-style templates from `~/.claude/output-styles/` — templates live separately from skill logic
- **OpenCode skills** are fully self-contained — templates are embedded inline in each SKILL.md
- On both platforms, skills (`prometh-prd`, `prometh-spec`, `prometh-doc`) are invoked contextually by the agent or by describing your intent in conversation — not via `/` slash syntax
- **README generation** produces 3 commit-ready files: `README.md` (lean landing page), `docs/getting-started.md` (full tutorial), and `CONTRIBUTING.md` (contributor guide)

## Document Lifecycle

**PRD status**: `Draft` → `Under Review` → `Approved` → `Active` → `Completed` → `Deprecated`

**SPEC status**: `Draft` → `Under Review` → `Approved` → `In Progress` → `Testing` → `Completed`

**SPEC types**: `Feature` · `Bug Fix` · `Enhancement` · `Technical Task`

**Filename conventions** (when `## Document Configuration` is set in `PROMETH.md`):

| Document type | Default pattern | Example |
|---------------|-----------------|---------|
| PRD | `PRD-{DATE}-{NAME}.md` | `PRD-20260223-mobile-strategy.md` |
| SPEC | `SPC-{DATE}-{NAME}.md` | `SPC-20260223-user-authentication.md` |
| Concept doc | `{DATETIME}-{NAME}.md` | `202602231830-architecture-overview.md` |
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
├── prds/
├── specs/
└── concepts/
PROMETH.md
```

**Local-only** (personal, not committed):
```
prometh-docs.local/
├── prds/
├── specs/
└── concepts/
PROMETH.local.md
```

If both exist, `.local` variants always take precedence.

### Migrating from legacy `docs/` directory

Run `/prometh-init` — it detects an existing `docs/` directory and offers to migrate it automatically.

## Document Configuration

The `## Document Configuration` section in `PROMETH.md` or `PROMETH.local.md` controls two behaviours for all skills — **metadata injection** and **filename patterns**. Both sub-sections are optional; if absent, skills fall back to legacy defaults.

When you run `/prometh-init` this section is created automatically. For existing projects initialized before this feature was added, paste it manually (see [Adding to an existing PROMETH.md](#adding-to-an-existing-promethmd)).

### Metadata Template

Every new document created inside `prometh-docs/` or `prometh-docs.local/` (PRDs, SPECs, Concept docs) receives a YAML frontmatter block at the top, populated from this template plus three fields computed at creation time:

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

## Contributing

1. Branch from `main`: `git checkout -b feature/<name>` or `fix/<name>`
2. **Slash commands**: update both `.claude/commands/` and `.opencode/commands/`
3. **Skills**: update both `.claude/skills/<name>/SKILL.md` and `.opencode/skills/<name>/SKILL.md` (Claude Code skills reference output-styles; OpenCode skills embed templates inline)
4. **Output-style templates**: only `.claude/output-styles/` (OpenCode embeds inline)
5. Run `./setup.sh --all` to verify installation
6. Update `CHANGELOG.md` under `[Unreleased]`
7. Commit format: `<Category>: <description>` — e.g., `Add: prometh-doc concept output style`

## License

Apache License 2.0 — see [LICENSE](LICENSE).

## Related Projects

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — Official Claude CLI tool
- [OpenCode](https://opencode.ai) — Open source AI coding agent for the terminal
- [Agent Skills Standard](https://agentskills.io) — The open standard both platforms use for skills

---

*Ready to ignite high-quality, predictable output! 🔥*
