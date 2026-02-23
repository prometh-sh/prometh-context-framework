# Changelog

All notable changes to the Prometh Context Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- OpenCode Agent Skills for document creation: `prometh-prd`, `prometh-spec`, `prometh-doc` (`.opencode/skills/`)
- `install_opencode_skills()` function in `setup.sh` to copy skills to `~/.config/opencode/skills/`
- Skills verification step in `setup.sh` `verify_installations()` output
- `## Document Configuration` section in `PROMETH.md` / `PROMETH.local.md` tracking file template (created by `/prometh-init`) with two sub-sections:
  - `### Metadata Template` — YAML frontmatter block injected into every new document created inside `prometh-docs/` or `prometh-docs.local/` for RAG indexing; fields `title`, `created`, and `uuid` are computed automatically per document
  - `### Filename Patterns` — configurable filename patterns for PRDs (`PRD-{DATE}-{NAME}.md`), SPECs (`SPC-{DATE}-{NAME}.md`), and Concept docs (`{DATETIME}-{NAME}.md`) with `{DATE}`, `{DATETIME}`, and `{NAME}` token support
- `## Document Configuration` section to `README.md` with full usage guide, metadata field reference table, filename token table, customization examples, and a copy-paste migration block for existing projects

### Changed
- Migrated OpenCode `prometh-prd`, `prometh-spec`, and `prometh-doc` from slash commands to self-contained Agent Skills
- `setup.sh` `install_opencode()` now creates `~/.config/opencode/skills/` directory and installs skills alongside commands
- Updated `AGENTS.md` to document skills structure, naming conventions, frontmatter rules, and platform differences
- Updated `README.md` project structure, platform compatibility table, available commands tables, and usage examples to reflect the command/skill split
- Improved .gitignore to explicitly include .claude/settings.local.json pattern
- Updated README.md to clarify that docs/ and PROMETH.md are created by /prometh-init
- Enhanced documentation clarity for public release
- All three skills (`prometh-prd`, `prometh-spec`, `prometh-doc`) on both `.claude/` and `.opencode/` platforms now read `METADATA_TEMPLATE` and `FILENAME_CONFIG` from the tracking file before creating any document; fall back to legacy filename patterns when config is absent
- `prometh-doc` skill applies filename patterns and metadata injection to Concept docs only; README.md and RUNBOOK.md always use fixed names and are never given frontmatter
- All "next steps" guidance in commands (`prometh-init`, `prometh-build`, `prometh-status`) and skill output formats corrected to use natural-language skill invocation instead of stale `/prometh-prd`, `/prometh-spec`, `/prometh-doc` slash syntax
- `README.md` `## Document Lifecycle` filename conventions updated to reflect the new configurable pattern table
- `prometh-doc` skill `## Usage` section rewritten to describe natural-language invocation; stale `## Command Options` section removed

### Removed
- `.opencode/commands/prometh-prd.md` (replaced by `.opencode/skills/prometh-prd/SKILL.md`)
- `.opencode/commands/prometh-spec.md` (replaced by `.opencode/skills/prometh-spec/SKILL.md`)
- `.opencode/commands/prometh-doc.md` (replaced by `.opencode/skills/prometh-doc/SKILL.md`)

## [1.0.0] - 2025-10-11

### Added
- Complete implementation workflow with 6 unified commands
- `/prometh-init` - Framework initialization and project setup
- `/prometh-prd` - Strategic PRD creation & normalization (unified command)
- `/prometh-spec` - Implementation SPEC creation & normalization (unified command)
- `/prometh-build` - Guided SPEC implementation execution with progress tracking
- `/prometh-doc` - Technical documentation generation (README, runbooks)
- `/prometh-status` - Project documentation status dashboard
- `/prometh-help` - Comprehensive command reference
- 4 unified output style templates (prometh-prd, prometh-spec, prometh-doc-readme, prometh-doc-runbook)
- PROMETH.md tracking system with document inventory and traceability matrix
- 3-phase SPEC implementation workflow (Planning → Task Breakdown → Implementation)
- CLAUDE.md validation requirement for all commands
- Smart classification for PRD vs SPEC detection
- Setup script for easy installation

### Changed
- Simplified from 11 output styles to 4 unified templates
- Merged normalization commands into main commands (prd, spec)
- Enhanced SPEC workflow with structured 3-phase approach
- Improved command structure and documentation

## [0.1.0] - 2025-08-17

### Added
- Initial commit with framework structure
- Basic command templates for PRD and SPEC generation
- Output style templates for documentation
- Apache License 2.0
- README.md with project overview
- CLAUDE.md configuration for Claude Code integration
