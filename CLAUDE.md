# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

The Prometh Context Framework is a documentation-first AI tooling framework — **no compiled application exists**. The repository is entirely Markdown command/template files plus a Bash setup script.

## Installation and Verification

```bash
# Interactive install (prompts for platform choice)
./setup.sh

# Non-interactive
./setup.sh --claude      # Claude Code: ~/.claude/commands/ and ~/.claude/output-styles/
./setup.sh --opencode    # OpenCode: ~/.config/opencode/commands/
./setup.sh --all         # Both platforms

# Verify
ls ~/.claude/commands/prometh-*
ls ~/.claude/output-styles/prometh-*

# Lint setup script
bash -n setup.sh         # Syntax check
shellcheck setup.sh      # Full analysis (requires shellcheck)
```

There is no test runner. To validate a command file: check YAML frontmatter validity, verify template variables (`${DOCS_DIR}`, `${TRACKING_FILE}`) are consistently used, then exercise the installed command manually.

## Repository Structure

```
.claude/
  commands/          # 7 Claude Code slash commands (prometh-*.md)
  output-styles/     # 5 output templates referenced by commands
.opencode/
  commands/          # 7 OpenCode slash commands (self-contained, templates embedded inline)
setup.sh             # Multi-platform installation script
CLAUDE.md            # This file
AGENTS.md            # OpenCode / general agent instructions
```

## Architecture and Key Concepts

### Dual-platform design
- **Claude Code** commands in `.claude/commands/` reference separate output-style templates from `.claude/output-styles/` via frontmatter.
- **OpenCode** commands in `.opencode/commands/` are **self-contained** — output templates must be embedded inline because OpenCode has no output-styles directory.
- When adding a new command, always create it in both `.claude/commands/` and `.opencode/commands/`.

### Template variables in commands
| Variable | Resolves to |
|----------|-------------|
| `${DOCS_DIR}` | `prometh-docs` or `prometh-docs.local` |
| `${TRACKING_FILE}` | `PROMETH.md` or `PROMETH.local.md` |

Resolution is always: local variant first, then committed variant.

### Local vs. committed documentation (created in user projects by `/prometh-init`)
| Variant | Directory | Tracking file | Git-tracked |
|---------|-----------|---------------|-------------|
| Team | `prometh-docs/` | `PROMETH.md` | Yes |
| Personal | `prometh-docs.local/` | `PROMETH.local.md` | No |

`.local` variants always take precedence when both exist.

### Command precondition order
All commands must check in this order and exit clearly on failure:
1. `CLAUDE.md` or `AGENTS.md` exists in project root
2. `${DOCS_DIR}` and `${TRACKING_FILE}` exist (suggest `/prometh-init` if absent)
3. Required arguments are present (display usage + list available files if missing)
4. Tracking file write failures: warn but never block the primary action

## File Naming Conventions

| Artifact | Convention | Example |
|----------|-----------|---------|
| Command files | `prometh-<verb>.md` | `prometh-spec.md` |
| Output style files | `prometh-<noun>.md` or `prometh-<noun>-<type>.md` | `prometh-doc-runbook.md` |
| Generated PRDs | `<kebab-name>-prd.md` | `mobile-strategy-prd.md` |
| Generated SPECs | `<type>-<kebab-name>-spec.md` | `feature-user-auth-spec.md` |

SPEC filename type prefixes: `feature-`, `fix-`, `enhance-`, `task-`.

## Code Style

### Markdown
- ATX headings (`#`), never Setext.
- Blank line before/after headings, lists, code blocks, and tables.
- Code blocks must always include a language tag.
- Lines under ~120 characters. No trailing whitespace.
- Numbered lists for sequential steps; bullets for unordered items; checkboxes for task lists.

### Bash (`setup.sh` and inline code blocks)
- `set -e` at top of standalone scripts.
- Quote all variable expansions: `"$var"`.
- Use `[[ ... ]]` for conditionals.
- `local` for function-scoped variables; `UPPER_SNAKE_CASE` for constants.
- Function names: `snake_case`.
- User-facing messages via `echo -e` with ANSI color codes (GREEN, YELLOW, BLUE, NC defined at top).
- Always provide `show_help()` and handle `-h`/`--help`.

### Error message emoji prefixes
`❌` fatal · `⚠️` warning · `ℹ️` info · `✅` success

### Output style template format
```yaml
---
name: Prometh SPEC
description: Short description
---
[Template body...]
Generated with: **Prometh Context Framework by Prometh**
```

## Document Lifecycle

**SPEC status**: `Draft` → `Under Review` → `Approved` → `In Progress` → `Testing` → `Completed`

**PRD status**: `Draft` · `Under Review` · `Approved` · `Active` · `Completed` · `Deprecated`

## Contributing

1. Branch from `main`: `git checkout -b feature/<name>` or `fix/<name>`
2. Changes affecting commands go in both `.claude/` and `.opencode/`
3. Run `./setup.sh --all` to verify installation
4. Update `CHANGELOG.md` under `[Unreleased]` (Keep a Changelog format)
5. Commit format: `<Category>: <concise imperative description>` — e.g., `Add: /prometh-build phase resume support`
