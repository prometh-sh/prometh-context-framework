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

[![Prometh Context Framework Demo](https://img.youtube.com/vi/TdOTGgLPWuk/maxresdefault.jpg)](https://youtu.be/TdOTGgLPWuk)

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
Five reusable templates referenced by skills:
- `prometh-prd` — Unified PRD template (14 sections)
- `prometh-spec` — Unified SPEC template with 3-phase workflow
- `prometh-doc-readme` — Comprehensive README template
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
│   └── output-styles/         # 5 output templates (referenced by skills)
│       ├── prometh-prd.md
│       ├── prometh-spec.md
│       ├── prometh-doc-readme.md
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

## Document Lifecycle

**PRD status**: `Draft` → `Under Review` → `Approved` → `Active` → `Completed` → `Deprecated`

**SPEC status**: `Draft` → `Under Review` → `Approved` → `In Progress` → `Testing` → `Completed`

**SPEC types**: `Feature` · `Bug Fix` · `Enhancement` · `Technical Task`

**Filename conventions:**
- PRDs: `[kebab-name]-prd.md`
- SPECs: `[feature|fix|enhance|task]-[kebab-name]-spec.md`

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
