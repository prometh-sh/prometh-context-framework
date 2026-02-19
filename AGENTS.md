# Prometh Context Framework — Agent Guide

This file provides guidance to agentic coding assistants (OpenCode, Claude Code, Copilot, etc.) working in this repository.

## Project Overview

A documentation-first AI tooling framework providing slash commands and output-style templates for creating PRDs, implementation SPECs, and technical documentation. There is **no compiled application** — the repository consists entirely of Markdown files and a Bash setup script.

Primary artifacts:
- `.claude/commands/` — Claude Code slash command definitions (Markdown)
- `.claude/output-styles/` — Claude Code output style templates (Markdown)
- `.opencode/commands/` — OpenCode slash command definitions (4 workflow commands)
- `.opencode/skills/` — OpenCode Agent Skills (3 document-creation skills, self-contained)
- `setup.sh` — Multi-platform Bash installation script

---

## Build / Lint / Test Commands

This project has no build pipeline, test runner, or package manager at the root level. The only executable artifact is `setup.sh`.

### Install the framework locally (interactive)
```bash
./setup.sh
```

### Install for a specific platform (non-interactive)
```bash
./setup.sh --claude      # Claude Code only  (~/.claude/commands/ and ~/.claude/output-styles/)
./setup.sh --opencode    # OpenCode only     (~/.config/opencode/commands/)
./setup.sh --all         # Both platforms
```

### Verify installation
```bash
ls ~/.claude/commands/prometh-*
ls ~/.claude/output-styles/prometh-*
ls ~/.config/opencode/commands/prometh-*
ls ~/.config/opencode/skills/prometh-*/SKILL.md
```

### Validate a single command or skill file (manual review)
There is no automated test runner. To validate a command or skill file:
1. Read the file and verify the YAML frontmatter is valid.
2. Check that all template variables (e.g., `${DOCS_DIR}`, `${TRACKING_FILE}`) are consistently used.
3. Run `./setup.sh` and exercise the installed command or skill in Claude Code or OpenCode.

### Lint shell script
```bash
bash -n setup.sh        # Syntax check only
shellcheck setup.sh     # Full static analysis (requires shellcheck)
```

---

## Repository Structure

```
prometh-context-framework/
├── .claude/
│   ├── commands/           # Claude Code slash commands (7 files)
│   └── output-styles/      # Claude Code output templates (5 files)
├── .opencode/
│   ├── commands/           # OpenCode slash commands (4 workflow commands)
│   └── skills/             # OpenCode Agent Skills (3 document-creation skills)
│       ├── prometh-prd/SKILL.md
│       ├── prometh-spec/SKILL.md
│       └── prometh-doc/SKILL.md
├── setup.sh                # Installation script
├── CLAUDE.md               # Claude Code project instructions
├── AGENTS.md               # This file (OpenCode / general agent instructions)
├── README.md
├── CONTRIBUTING.md
├── CHANGELOG.md
└── LICENSE                 # Apache 2.0
```

### Local vs. committed documentation (created by `/prometh-init`)

| Variant | Directory | Tracking file | Git-tracked |
|---------|-----------|---------------|-------------|
| Team | `prometh-docs/` | `PROMETH.md` | Yes |
| Personal | `prometh-docs.local/` | `PROMETH.local.md` | No |

**Priority rule**: `.local` variants always take precedence when both exist.

---

## Command File Conventions

### Frontmatter (YAML)
Every command file begins with a YAML frontmatter block:

**Claude Code commands** (`.claude/commands/`):
```yaml
---
description: One-line summary for the command picker
argument-hint: "[optional|required argument syntax]"
allowed-tools: ["Read", "Write", "Edit", "Glob", "Bash"]
---
```

**OpenCode commands** (`.opencode/commands/`):
```yaml
---
description: One-line summary for the command picker
---
```

**OpenCode skills** (`.opencode/skills/<name>/SKILL.md`):
```yaml
---
name: prometh-<name>
description: Specific description (1–1024 chars) that helps the agent choose this skill correctly
---
```

OpenCode commands do **not** use `allowed-tools` or `argument-hint` — these are Claude Code-specific fields.
OpenCode skills support only `name`, `description`, `license`, `compatibility`, and `metadata` frontmatter fields.
The `name` field must be 1–64 chars, lowercase alphanumeric with single hyphens, no leading/trailing hyphens, and must exactly match the directory name.

### Template variables
Commands use shell-style variable references in prose and code blocks:

| Variable | Resolved to |
|----------|-------------|
| `${DOCS_DIR}` | `prometh-docs` or `prometh-docs.local` |
| `${TRACKING_FILE}` | `PROMETH.md` or `PROMETH.local.md` |

Resolution order: local variant first, then committed variant.

### Output style templates (`.claude/output-styles/`)
Each file begins with a name/description frontmatter:
```yaml
---
name: Prometh SPEC
description: Short description of what this template produces
---
```
Then the full template body with instructional text for the AI. Templates end with the attribution line:
```
Generated with: **Prometh Context Framework by Prometh**
```

---

## Code Style Guidelines

### Markdown files

- Use ATX-style headings (`#`, `##`, `###`), never Setext (`===` / `---`).
- Blank line before and after every heading, list, code block, and table.
- Code blocks must specify a language tag: `bash`, `markdown`, `yaml`, `sql`, `gherkin`, `javascript`, etc. Use plain ` ``` ` only when no language applies.
- Tables: align pipes, include a header separator row, and keep columns concise.
- Numbered lists for sequential steps; bullet lists for unordered items.
- Checkboxes (`- [ ]` / `- [x]`) for task lists and deliverable checklists.
- One sentence per line is acceptable inside block quotes but not required elsewhere.
- Keep lines under ~120 characters where practical.
- No trailing whitespace.

### Bash (`setup.sh` and inline code blocks in commands)

- `set -e` at the top of every standalone script (exit on error).
- Quote all variable expansions: `"$var"`, `"${BASH_SOURCE[0]}"`.
- Use `[[ ... ]]` for conditionals, not `[ ... ]`.
- Use `local` for all function-scoped variables.
- Prefer `mkdir -p` over checking existence manually.
- Function names: `snake_case`.
- Constants / environment variables: `UPPER_SNAKE_CASE`.
- Emit user-facing messages through `echo -e` with ANSI color codes defined at the top of the file (GREEN, YELLOW, BLUE, NC).
- Always provide a `show_help()` function and handle `-h`/`--help`.

### Naming conventions

| Artifact type | Convention | Example |
|---------------|-----------|---------|
| Command files | `prometh-<verb>.md` | `prometh-spec.md` |
| Skill directories | `prometh-<noun>/` | `prometh-prd/` |
| Skill files | `SKILL.md` (always uppercase) | `prometh-prd/SKILL.md` |
| Output style files | `prometh-<noun>.md` or `prometh-<noun>-<type>.md` | `prometh-doc-runbook.md` |
| Generated PRD files | `<kebab-name>-prd.md` | `mobile-strategy-prd.md` |
| Generated SPEC files | `<type>-<kebab-name>-spec.md` | `feature-user-auth-spec.md` |
| Tracking files | `PROMETH.md` / `PROMETH.local.md` | — |
| Config files | `CLAUDE.md`, `AGENTS.md`, `CLAUDE.local.md`, `AGENTS.local.md` | — |

SPEC filename type prefixes: `feature-`, `fix-`, `enhance-`, `task-`.

### Error handling in commands

Commands must follow this pattern for required preconditions:

1. **Check AGENTS.md / CLAUDE.md** — exit with a clear message if missing.
2. **Check `${DOCS_DIR}` and `${TRACKING_FILE}`** — exit with a message and suggest `/prometh-init` if absent.
3. **Check arguments** — display usage and list available files if required args are omitted.
4. **Degrade gracefully** — tracking file write failures must warn but never block the primary action.

Error messages use emoji prefixes for scannability: `❌` fatal, `⚠️` warning, `ℹ️` info, `✅` success.

---

## Document Lifecycle and Status Values

### SPEC status progression
`Draft` → `Under Review` → `Approved` → `In Progress` → `Testing` → `Completed`

### PRD status values
`Draft`, `Under Review`, `Approved`, `Active`, `Completed`, `Deprecated`

---

## Platform Differences

| Feature | Claude Code | OpenCode |
|---------|-------------|----------|
| Config file | `CLAUDE.md` / `CLAUDE.local.md` | `AGENTS.md` / `AGENTS.local.md` |
| Commands dir | `~/.claude/commands/` | `~/.config/opencode/commands/` |
| Skills dir | N/A | `~/.config/opencode/skills/` |
| Output styles | `~/.claude/output-styles/` | Embedded directly in skill files |
| Frontmatter | `allowed-tools`, `argument-hint` supported | `description` only (commands); `name` + `description` (skills) |

When adding a new workflow command, create it in **both** `.claude/commands/` and `.opencode/commands/`. When adding a document-creation feature (PRD, SPEC, doc), create a Claude Code command in `.claude/commands/` **and** an OpenCode skill in `.opencode/skills/<name>/SKILL.md`. Skills must embed output templates inline.

---

## Contributing Workflow

1. Branch from `main`: `git checkout -b feature/<name>` or `fix/<name>`.
2. Make changes in both `.claude/` and `.opencode/` when applicable.
3. Run `./setup.sh --all` on a clean machine to verify installation.
4. Manually exercise changed commands in Claude Code and/or OpenCode.
5. Update `CHANGELOG.md` under `[Unreleased]` using Keep a Changelog categories: `Added`, `Changed`, `Fixed`, `Removed`.
6. Commit message format: `<Category>: <concise imperative description>` — e.g., `Add: /prometh-build phase resume support`.
7. Open a PR with a clear description and reference any related issues.

---

*Generated with: **Prometh Context Framework by Prometh***
