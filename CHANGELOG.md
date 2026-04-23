# Changelog

All notable changes to the Prometh Context Framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.6.0] - 2026-04-23

### Added
- Claude Code Agent Skill `prometh-planner` for creating Pixel Planner project plans with interactive Gantt timelines. Generates `PLN-YYYYMMDD-<slug>.md` files with phase tracking, milestone tables, and auto-integrated timeline visualization using `pixel-planner init` CLI. Supports multiple invocation modes: interactive, project name argument, `--spec <file>`, and `--description <text>`. Uses directory and tracking file resolution with precedence (`prometh-docs.local` > `prometh-docs`, `PROMETH.local.md` > `PROMETH.md`). Reads `METADATA_TEMPLATE` from tracking file for frontmatter injection. Auto-runs `pixel-planner timeline` CLI after creation and updates tracking file with new `## Plans` section.
- OpenCode Agent Skill `prometh-planner` for creating Pixel Planner project plans with interactive Gantt timelines. Generates `PLN-YYYYMMDD-<slug>.md` files with phase tracking, milestone tables, and auto-integrated timeline visualization. Supports multiple invocation modes: interactive, project name argument, `--spec <file>`, and `--description <text>`. Auto-runs `pixel-planner timeline` CLI after creation and updates tracking file with new `## Plans` section.
- Creation of `prometh-docs/plans/` subdirectory during `/prometh-init` for storing all generated project plan files
- `## Plans` section in tracking file template (`PROMETH.md` / `PROMETH.local.md`) for document inventory of all project plans with status tracking

### Changed
- Refactored `prometh-planner` skills (both Claude Code and OpenCode) to use `pixel-planner init` CLI for file creation instead of embedded template. Removes ~300 lines of duplicate template code and delegates file generation to the CLI tool. Skills now only inject YAML frontmatter metadata when configured and skip all other content modification.
- Removed all emoji usage from prometh-planner skill output for plaintext-only display on terminals
- Updated `/prometh-init` (both `.claude/` and `.opencode/`) to create `prometh-docs/plans/` directory and add Plans section to tracking file template
- Updated `/prometh-progress`, `/prometh-sensor`, and `/prometh-status` to remove outdated references and streamline output
- Migrated `prometh-planner` from slash command (`.claude/commands/prometh-planner.md`) to self-contained Claude Code Agent Skill (`.claude/skills/prometh-planner/SKILL.md`)

### Removed
- `/prometh-build` command removed from both Claude Code (`.claude/commands/`) and OpenCode (`.opencode/commands/`). The Harness Protocol in `CLAUDE.md` / `AGENTS.md` handles session initialization, contract context, and progress bridging automatically without need for an explicit build command.
- Claude Code command `prometh-planner.md` (replaced by `.claude/skills/prometh-planner/SKILL.md`)
- `.claude/commands/prometh-build.md` (removed)
- `.opencode/commands/prometh-build.md` (removed)

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
