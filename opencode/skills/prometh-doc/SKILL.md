---
name: prometh-doc
description: Generate technical documentation (README, runbooks, concept docs) by analyzing the repository structure. Auto-detects technology stack and produces comprehensive, ready-to-use documentation. Use this skill when asked to generate or write a README, runbook, operational documentation, concept documentation, or any project-level technical documentation.
---

# Technical Documentation Generation Skill

Generate comprehensive technical documentation by analyzing repository structure and system configuration. Supports three documentation types with unified templates.

## Directory and Tracking File Resolution

**MANDATORY FIRST STEP**: Resolve the documentation directory and tracking file:

**Directory Resolution:**
```bash
if [ -d "prometh-docs.local" ]; then
  DOCS_DIR="prometh-docs.local"
elif [ -d "prometh-docs" ]; then
  DOCS_DIR="prometh-docs"
else
  DOCS_DIR="."
fi
```

**Tracking File Resolution:**
```bash
if [ -f "PROMETH.local.md" ]; then
  TRACKING_FILE="PROMETH.local.md"
elif [ -f "PROMETH.md" ]; then
  TRACKING_FILE="PROMETH.md"
fi
# Tracking file is optional for doc generation — proceed even if absent
```

## Configuration Resolution

**After resolving the tracking file**, if TRACKING_FILE is set, read the
`## Document Configuration` section:

```
1. Open ${TRACKING_FILE} and locate the ## Document Configuration section
2. Extract the YAML block under ### Metadata Template
   → Store as METADATA_TEMPLATE (set to nil if section or block is absent/empty)
3. Extract the YAML block under ### Filename Patterns
   → Store as FILENAME_CONFIG (set to nil if section or block is absent/empty)
```

If TRACKING_FILE is not set, both variables default to nil — proceed without
metadata injection or configured filename patterns.

## Three Documentation Types

### 1. README

- **Output**: Three commit-ready files in one operation:
  - `README.md` — lean landing page (5-min read): value prop, demo, quick install, links
  - `docs/getting-started.md` — full guided tutorial walkthrough
  - `CONTRIBUTING.md` — contributor guide (GitHub auto-links this file)
- **Purpose**: Complete project documentation set for a new open-source or team project
- **Audience**: README → visitors; getting-started → new users; CONTRIBUTING → contributors
- **Important**: These files go to project root / `docs/` — NOT to `${DOCS_DIR}`.
  No metadata injection, no filename patterns, no tracking file entry.

### 2. Runbook

- **Output**: `RUNBOOK.md` in project root (or docs directory)
- **Purpose**: Operational procedures, incident response, maintenance
- **Audience**: DevOps, SRE, operators, on-call engineers
- **Sections**: Architecture, monitoring, incident response, recovery procedures, etc.

### 3. Concept

- **Output**: `${DOCS_DIR}/concepts/[name].md` (filename governed by `concept_pattern` — see Filename Generation)
- **Purpose**: Deep-dive technical understanding, onboarding, architecture
- **Audience**: New team members, architects, technical leads
- **Sections**: Technology stack, architecture, domain concepts, getting started, etc.
- **Metadata**: YAML frontmatter injected if METADATA_TEMPLATE is configured (see Metadata Injection)

## Processing Logic

### Step 1: Documentation Type Selection

If type not specified in the conversation, display interactive menu:

```
📚 Documentation Type Selection

1. README - Landing page + companion docs (3 files)
   README.md + docs/getting-started.md + CONTRIBUTING.md
2. Runbook - Operational procedures and incident response
3. Concept - Deep-dive technical documentation for onboarding

Which documentation type? (1-3):
```

### Step 2: Repository Analysis

Auto-analyze the repository to extract:

- **README**: Project structure, dependencies, build/run commands, configuration
- **Runbook**: Infrastructure setup, monitoring, system components, deployment
- **Concept**: Technology stack, architecture, domain concepts, code structure

### Step 3: Template Application

Apply appropriate embedded template (see below) with extracted information.

### Step 4: Content Generation

Generate comprehensive documentation based on analysis and template.

### Step 5: File Management

- **README type**: Create three files:
  - `README.md` in project root (lean landing page)
  - `docs/getting-started.md` (full tutorial; create `docs/` if needed)
  - `CONTRIBUTING.md` in project root
  - If any file exists, create a `-new` variant for review (e.g., `README-new.md`)
  - These files go to **project root / `docs/`** — NOT to `${DOCS_DIR}`
  - No metadata injection, no filename patterns, no tracking file entry
- **Runbook**: write to project root with fixed name `RUNBOOK.md`
- **Concept docs**: apply configured filename pattern or legacy name; create `${DOCS_DIR}/concepts/` directory if needed
- Filename patterns and metadata injection do **not** apply to README, CONTRIBUTING, or RUNBOOK

### Step 5b: Metadata Injection (Concept docs only)

- If METADATA_TEMPLATE is present, inject YAML frontmatter before writing (see Metadata Injection section)
- README, CONTRIBUTING, and RUNBOOK files are always excluded from metadata injection

### Step 6: Tracking File Update

If tracking file exists:

- Add entry to technical documentation table
- Update recent activity log
- Update "Last Updated" timestamp

## Supported Invocation Styles

```
readme      → Creates README.md + docs/getting-started.md + CONTRIBUTING.md
runbook     → Creates RUNBOOK.md directly
concept     → Creates concept documentation with auto-naming
(none)      → Shows interactive menu to select type
```

## Supported Options

- `--include-examples` — Include code examples from repository
- `--include-risks` — Include risk assessment sections (especially for Runbook)
- `--output [path]` — Specify custom output path/filename
- `--scope [service|environment|full-stack]` — Documentation scope

## Sensitive Data Protection

When generating documents, **never** include:
- API keys, secrets, tokens, passwords, or credentials
- Environment variable **values** (reference names only, e.g. `$DATABASE_URL`)
- Private hostnames, IP addresses, or internal URLs
- PII (personal emails, account IDs, private names)
- Database connection strings or `.env` file contents
- Absolute file paths or user home directories

Use placeholder values where examples are needed (e.g. `sk-...`, `your-api-key-here`, `https://your-domain.example.com`).

## Repository Analysis Requirements

### For README

- Detect project type (Node.js, Python, Go, etc.) from package files
- Extract build/run commands
- Identify configuration options
- Detect external dependencies

### For Runbook

- Identify infrastructure components
- Detect monitoring setup
- Map service dependencies
- Extract deployment configuration

### For Concept

- Complete technology stack analysis
- System architecture extraction
- Domain model identification
- Codebase structure understanding

## Filename Generation (Concept docs only)

README and RUNBOOK filenames are always fixed. Only Concept docs use this logic.

### Name Slug Rules (apply in all cases)

Extract a meaningful slug from the document title or topic:
- Convert to lowercase and replace spaces with hyphens
- Remove common stop-words (the, a, an, for, to, with, of, and, or, in, on, at, etc.)
- Keep 2–5 key descriptive words that capture the concept topic
- Result: `{NAME}` token (e.g. `architecture-overview`, `authentication-flow`)

### Configured Pattern (when FILENAME_CONFIG is present)

Read `concept_pattern` from FILENAME_CONFIG and substitute tokens:

| Token | Value |
|-------|-------|
| `{DATE}` | Current date as `YYYYMMDD` (e.g. `20260223`) |
| `{DATETIME}` | Current datetime as `YYYYMMDDHHMM` (e.g. `202602231830`) |
| `{NAME}` | Slugified document name (see rules above) |

**Default configured pattern:** `{DATETIME}-{NAME}.md`

Examples with default pattern:
- "Architecture Overview" → `202602231830-architecture-overview.md`
- "Authentication Flow" → `202602231830-authentication-flow.md`
- "Database Schema Design" → `202602231830-database-schema-design.md`

### Legacy Fallback (when FILENAME_CONFIG is absent)

If no `## Document Configuration` section or `concept_pattern` key is found:
- Format: `[name].md` (plain slugified name, no date prefix)

Print an info message when falling back:
```
ℹ️  No filename configuration found in ${TRACKING_FILE}. Using legacy filename format.
   To configure: add a ## Document Configuration section with a ### Filename Patterns block.
```

## Metadata Injection (Concept docs only)

README and RUNBOOK files are always excluded. Only documents written inside
`${DOCS_DIR}/concepts/` receive metadata injection.

### When to inject

- METADATA_TEMPLATE is present (non-nil, non-empty)
- **AND** the destination is `${DOCS_DIR}/concepts/`

### Injection procedure

1. Clone METADATA_TEMPLATE
2. Compute and set the following dynamic fields:
   - `title`: extracted from the first `# H1` heading of the generated document
   - `created`: current datetime as ISO 8601 (e.g. `2026-02-23T18:30:29`)
   - `uuid`: newly generated UUID v4 (e.g. `xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx`)
3. Prepend the populated block as a YAML frontmatter fence at the very top of the document:

```
---
title: "Architecture Overview"
created: "2026-02-23T18:30:29"
author: "Your Name"
focus: "Personal"
tags: []
project:
  - name: "Your Project Name"
    uuid: "YOUR-PROJECT-UUID"
status: "Draft"
uuid: "GENERATED-UUID-V4-PER-DOCUMENT"
related: []
---
```

4. Write the combined frontmatter + document body to the output file.

### When METADATA_TEMPLATE is absent

Skip injection silently for README/RUNBOOK. For Concept docs, print:
```
ℹ️  No metadata template found in ${TRACKING_FILE}. Skipping metadata injection.
   To enable: add a ## Document Configuration section with a ### Metadata Template block.
```

## Error Handling

- **No type specified**: Show interactive menu
- **Invalid type**: Display valid options and re-prompt
- **Repository analysis fails**: Continue with generic template
- **File write errors**: Report issue and suggest alternative paths

---

## Embedded Template 1: README (lean landing page)

Use this template for `README.md`. Target ≤300 lines — it is the landing page, not the manual.
Link to `docs/getting-started.md` and `CONTRIBUTING.md` for detail instead of duplicating it here.

---

# [Project Name]

> [One sentence: what it does and who it's for]

[![License](https://img.shields.io/badge/License-[LICENSE]-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-[VERSION]-green.svg)](https://github.com/[USERNAME]/[REPO]/releases)

[Optional: `![Demo](docs/images/demo.gif)` if project has a visual component]

## What it does

[2–4 bullets covering core value. Focus on outcomes, not features.]

- **[Capability 1]**: [What problem it solves]
- **[Capability 2]**: [What problem it solves]
- **[Capability 3]**: [What problem it solves]

## Quick start

```bash
# Install
[install command — ≤3 lines]

# First use
[the single most important command]
```

→ For a complete walkthrough, see [Getting Started](docs/getting-started.md).

## Installation

### Prerequisites

- [Requirement 1] [version]
- [Requirement 2] [version]

### Install

```bash
[install steps — ≤10 lines; link to getting-started.md if platform-specific detail is needed]
```

### Verify

```bash
[verification command]
# Expected: [expected output]
```

## Usage

[Show 2–3 most common invocations only.]

```bash
[primary command example]
[secondary command example]
```

→ Full usage examples: [Getting Started](docs/getting-started.md).

## Key features

| Feature | Description |
|---------|-------------|
| [Feature 1] | [One-line description] |
| [Feature 2] | [One-line description] |
| [Feature 3] | [One-line description] |

## Documentation

| Document | Description |
|----------|-------------|
| [Getting Started](docs/getting-started.md) | Full install walkthrough, tutorial, examples |
| [Contributing](CONTRIBUTING.md) | Dev setup, branch strategy, PR process |
| [Changelog](CHANGELOG.md) | Version history |

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for dev setup, branch naming, commit format, and PR guidelines.

## License

[License name] — see [LICENSE](LICENSE) for details.

---

Generated with: **Prometh Context Framework by Prometh**

---

## Embedded Template 2: Getting Started

Use this template for `docs/getting-started.md`. Task-oriented tutorial — the reader follows
steps and arrives at a working result. Not a reference document.

---

# Getting Started with [Project Name]

> From installation to [specific first milestone] in under 30 minutes.

## Prerequisites

- **[Tool 1]** [version] — [install link]
- **[Tool 2]** [version] — [install link]

Verify:

```bash
[tool-1] --version   # Expected: [version]
[tool-2] --version   # Expected: [version]
```

## Step 1: Installation

### Option A: [Primary method]

```bash
[install command]
```

### Option B: From source

```bash
git clone [repository-url]
cd [project-directory]
[build/install command]
```

### Verify installation

```bash
[verification command]
# Expected: [exact expected output]
```

## Step 2: [Initial setup]

[What the user must do before first use.]

```bash
[setup command]
```

**What this creates:**

```
[directory or file tree]
```

### Configuration

```[format]
[minimal required configuration with comments]
```

| Setting | Description | Default |
|---------|-------------|---------|
| `[setting1]` | [What it controls] | `[default]` |
| `[setting2]` | [What it controls] | `[default]` |

## Step 3: Your first [primary action]

```bash
[primary command]
```

Expected output:

```
[exact expected output]
```

[Explain what happened — 2–4 sentences.]

## Step 4: [Second key workflow]

```bash
[command]
```

[Show result and explain briefly.]

## Common workflows

### [Workflow A]

```bash
[command sequence]
```

### [Workflow B]

```bash
[command sequence]
```

## CLI reference

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--[option-1]` | `-[o]` | [What it does] | `[default]` |
| `--[option-2]` | `-[o]` | [What it does] | `[default]` |

## Environment variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `[VAR_1]` | [Purpose] | `[default]` | Yes/No |
| `[VAR_2]` | [Purpose] | `[default]` | Yes/No |

## Troubleshooting

### [Common issue 1]

**Symptom:** [What the user sees]

**Fix:**
```bash
[fix command]
```

### [Common issue 2]

**Symptom:** [What the user sees]

**Fix:** [Resolution steps]

### Getting help

- Search [existing issues](https://github.com/[username]/[repo]/issues)
- Open a [new issue](https://github.com/[username]/[repo]/issues/new)

## Next steps

- Read the [README](../README.md) for a project overview
- Contribute back → [CONTRIBUTING.md](../CONTRIBUTING.md)

---

Generated with: **Prometh Context Framework by Prometh**

---

## Embedded Template 3: Contributing

Use this template for `CONTRIBUTING.md`. GitHub auto-links this file in the repository UI.
Must be welcoming, concrete, and unambiguous.

---

# Contributing to [Project Name]

Thank you for your interest in contributing!

## Getting Help

- **Questions**: [GitHub Discussions](https://github.com/[username]/[repo]/discussions)
- **Bugs**: [GitHub Issues](https://github.com/[username]/[repo]/issues)

## Development Setup

### Prerequisites

- **[Tool 1]** [version]
- **[Tool 2]** [version]

### Fork and clone

```bash
git clone https://github.com/YOUR-USERNAME/[repo-name].git
cd [repo-name]
git remote add upstream https://github.com/[username]/[repo-name].git
```

### Install dependencies

```bash
[dependency install command]
```

### Verify setup

```bash
[test command]     # Expected: all tests pass
[lint command]     # Expected: no errors
```

## Branch Strategy

| Type | Pattern | Example |
|------|---------|---------|
| Feature | `feature/<description>` | `feature/dark-mode` |
| Bug fix | `fix/<description>` | `fix/login-redirect` |
| Docs | `docs/<description>` | `docs/update-api-ref` |

Always branch from `main`:

```bash
git checkout main
git pull upstream main
git checkout -b feature/your-feature
```

## Commit Format

```
<Category>: <imperative description>
```

| Category | When |
|----------|------|
| `Add` | New feature or file |
| `Fix` | Bug fix |
| `Update` | Enhancement to existing feature |
| `Remove` | Deletion |
| `Refactor` | Restructuring without behavior change |
| `Docs` | Documentation only |
| `Test` | Tests only |
| `Chore` | Build, CI, tooling |

Examples:
```
Add: dark mode toggle to settings panel
Fix: redirect loop after login when session expires
Docs: add platform-specific notes to getting-started
```

## Pull Request Process

1. Rebase on latest `main`:
```bash
git fetch upstream
git rebase upstream/main
```
2. Push and open a PR on GitHub
3. Fill in the PR description; link related issues with `Fixes #123`
4. Respond to review feedback; maintainer merges on approval

### PR checklist

- [ ] Tests pass: `[test command]`
- [ ] No lint errors: `[lint command]`
- [ ] Documentation updated if public API changed
- [ ] `CHANGELOG.md` updated under `[Unreleased]` for user-visible changes

## Code Quality

```bash
[lint command]     # Check for issues
[format command]   # Auto-fix formatting
[test command]     # Run all tests
```

## Reporting Bugs

Include: OS + version, [tool] version, minimal reproduction steps, expected vs actual behavior.

→ [Open a bug report](https://github.com/[username]/[repo]/issues/new)

## Requesting Features

Describe the problem you're solving, the solution you'd like, and any alternatives considered.

→ [Open a feature request](https://github.com/[username]/[repo]/issues/new)

---

Generated with: **Prometh Context Framework by Prometh**

---

## Embedded Template 2: Runbook

Use this template for operational documentation. Focus on actionable procedures and incident response:

# [System/Service Name] Runbook

## Document Information

- **Version**: 1.0
- **Last Updated**: [Current Date]
- **Owner**: [Team Name]
- **On-Call Contact**: [Contact info]
- **Review Cycle**: [Quarterly/Annually]

## Overview

### System Description

[What is this system and what does it do?]

### Scope

This runbook covers:

- [System component 1]
- [System component 2]
- [Operational procedures]

### Contact Information

- **Primary Owner**: [Name, contact]
- **Secondary Owner**: [Name, contact]
- **Escalation Contact**: [Name, contact]

## System Architecture

### High-Level Architecture

[ASCII diagram showing major components]

### Components

| Component | Responsibility | Technology |
|-----------|----------------|-----------|
| [Component 1] | [Purpose] | [Tech stack] |
| [Component 2] | [Purpose] | [Tech stack] |

### Data Flow

[Description of how data flows through the system]

### External Dependencies

- [External service 1]
- [External service 2]
- [Third-party APIs]

## Access & Authentication

### Required Access

- **Production Access**: [Type of access required]
- **Database Access**: [Details]
- **SSH Keys**: [Details]
- **API Keys**: [Details]

### Access Procedures

1. [Step 1: How to get access]
2. [Step 2: Configuration]
3. [Step 3: Verification]

### Emergency Access

[Procedure for accessing system during outages when normal access is unavailable]

## Monitoring & Alerting

### Key Metrics

| Metric | Normal Range | Alert Threshold | Dashboard Link |
|--------|-------------|-----------------|----------------|
| [Metric 1] | [Range] | [Threshold] | [Link] |
| [CPU Usage] | [Range] | [Threshold] | [Link] |

### Alert Definitions

- **Alert**: [Alert name] - [Trigger condition]
  - **Severity**: [P1/P2/P3/P4]
  - **Response Time**: [Expected time to respond]

### Monitoring Tools

- [Tool 1]: [URL and description]
- [Tool 2]: [URL and description]

## Operational Procedures

### Health Checks

```bash
# Basic health check
[command-to-check-health]

# Detailed status
[command-for-detailed-status]
```

### Routine Maintenance

- **Daily**: [Tasks]
- **Weekly**: [Tasks]
- **Monthly**: [Tasks]

### Deployment Procedures

**Pre-Deployment Checklist**:

- [ ] All tests passing
- [ ] Staging environment verified
- [ ] Database migrations tested
- [ ] Rollback plan documented
- [ ] Team notified

**Deployment Steps**:

```bash
[deployment-command-1]
[deployment-command-2]
[verification-command]
```

**Post-Deployment Validation**:

- [ ] Health checks passing
- [ ] Key metrics normal
- [ ] No errors in logs
- [ ] Users can access service

## Incident Response

### Incident Classification

| Severity | Definition | Response Time | Escalation |
|----------|-----------|---------------|-----------|
| P1 | Service completely down | 15 minutes | [Contact] |
| P2 | Significant degradation | 1 hour | [Contact] |
| P3 | Minor impact | 4 hours | [Contact] |
| P4 | Cosmetic issues | 1 day | [Contact] |

### Initial Response Checklist

- [ ] Page on-call engineer
- [ ] Create incident ticket
- [ ] Post to #incidents channel
- [ ] Gather logs and metrics
- [ ] Assess impact scope
- [ ] Begin investigation
- [ ] Update status

### Communication Templates

**Incident Open**:

```
Incident: [Service] - [Issue description]
Severity: [P1/P2/P3/P4]
Impact: [What users are affected]
Status: Investigating
ETA: [Estimated time to resolution]
```

**Status Update**:

```
Update on [Service] incident:
Current Status: [Status]
Investigation: [Findings so far]
ETA: [Updated estimate]
```

## Troubleshooting Guide

### Common Issues

**Issue**: [Service unresponsive]

- **Symptoms**: [What users report]
- **Diagnosis**:
  ```bash
  [diagnostic-command-1]
  [diagnostic-command-2]
  ```
- **Solution**:
  ```bash
  [fix-command-1]
  [fix-command-2]
  ```

**Issue**: [Performance degradation]

- **Symptoms**: [What indicates this]
- **Diagnosis**:
  ```bash
  [diagnostic-command]
  ```
- **Solution**: [Steps to resolve]

### Performance Troubleshooting

**High CPU Usage**:

```bash
# Identify processes
[command-to-identify-cpu-hogs]

# Check for slow queries if database
[database-command]
```

**High Memory Usage**:

```bash
[diagnostic-commands]
```

**Network Issues**:

```bash
[network-diagnostic-commands]
```

## Recovery Procedures

### Backup & Restore

**Taking Backups**:

```bash
[backup-command]
```

**Restore from Backup**:

```bash
[restore-command]
[verification-steps]
```

### Disaster Recovery

**Complete Service Failure**:

1. [Step 1 for recovery]
2. [Step 2 for recovery]
3. [Step 3 for recovery]
4. [Verification steps]

### Failover Procedures

[Instructions for failing over to backup systems]

## Configuration Management

### Configuration Files

| File | Purpose | Location |
|------|---------|----------|
| [config.yml] | [Description] | [Path] |
| [.env] | [Description] | [Path] |

### Environment Variables

[Description of important environment variables and how to set them]

### Making Configuration Changes

1. [Step 1: Backup current]
2. [Step 2: Make changes]
3. [Step 3: Validate]
4. [Step 4: Restart service]

## Security Procedures

### Security Incident Response

- **Data Breach**: [Procedure]
- **Unauthorized Access**: [Procedure]
- **Malware Detection**: [Procedure]

### Certificate Management

- **Renewal Process**: [Steps]
- **Certificate Expiry Monitoring**: [How monitored]

### Access Review

- **Quarterly Review**: [Schedule and process]
- **Revoke Access**: [How to remove access]

## Performance Optimization

### Performance Monitoring

- [Key metrics to watch]
- [Threshold values]
- [Escalation procedures]

### Optimization Strategies

- [Caching strategy]
- [Database optimization]
- [Code optimization areas]

## Risk Assessment

| Risk | Impact | Probability | Mitigation | Contingency |
|------|--------|-------------|-----------|-------------|
| [Database failure] | [Impact level] | [Probability] | [Prevention] | [Response] |
| [Service crash] | [Impact level] | [Probability] | [Prevention] | [Response] |

## References

### Internal Documentation

- [Link to architecture docs]
- [Link to code repository]
- [Link to wiki]

### External Resources

- [Link to vendor documentation]
- [Link to open-source projects]
- [Link to relevant standards]

---

Generated with: **Prometh Context Framework by Prometh**

---

## Embedded Template 3: Concept Documentation

Use this comprehensive template for deep-dive technical documentation:

# [Project/System Name] - Concept Documentation

*Comprehensive technical guide for team members new to [Project/System]*

## Document Information

- **Version**: 1.0
- **Last Updated**: [Current Date]
- **Target Audience**: New team members, architects, technical leads
- **Expected Time to Read**: [60-90 minutes]

## 1. Technology Stack

### Core Technologies

- **Primary Language**: [Language] [version]
- **Secondary Languages**: [List if applicable]
- **Runtime**: [Runtime/Platform]

### Development Tools

- **Build Tool**: [Tool name and version]
- **Package Manager**: [npm/yarn/pip/etc.]
- **Version Control**: [Git/etc.]
- **Testing Framework**: [Framework name]

### Infrastructure & Deployment

- **Container Platform**: [Docker/Kubernetes]
- **Cloud Provider**: [AWS/GCP/Azure]
- **CI/CD Platform**: [GitHub Actions/Jenkins/etc.]

### Key Dependencies

| Library | Version | Purpose |
|---------|---------|---------|
| [Library 1] | [Version] | [Purpose] |
| [Library 2] | [Version] | [Purpose] |

## 2. System Architecture

### High-Level Architecture

```
┌─────────────────────────────────────────┐
│         [Client/Interface]              │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│         [API/Service Layer]             │
├──────────────────┬──────────────────────┤
│ [Component 1]    │ [Component 2]        │
└──────────────────┬──────────────────────┘
                   │
┌──────────────────▼──────────────────────┐
│    [Data Store/Database]                │
└─────────────────────────────────────────┘
```

### Component Breakdown

| Component | Responsibility | Technology |
|-----------|----------------|-----------|
| [Component 1] | [What it does] | [Technology] |
| [Component 2] | [What it does] | [Technology] |

### Data Flow

[Describe how data flows through the system with an ASCII diagram]

### Design Patterns Used

- [Pattern 1]: [Brief description]
- [Pattern 2]: [Brief description]

### Architecture Decisions (ADRs)

- **ADR-001**: [Decision name] — [Why this decision was made]
- **ADR-002**: [Decision name] — [Why this decision was made]

## 3. Domain Concepts

### Core Domain Model

[Describe the main business/technical domain]

### Key Entities

| Entity | Properties | Relationships | Rules |
|--------|-----------|---------------|-------|
| [Entity 1] | [Properties] | [Relationships] | [Business rules] |
| [Entity 2] | [Properties] | [Relationships] | [Business rules] |

### Domain Terminology

- **[Term 1]**: [Definition]
- **[Term 2]**: [Definition]
- **[Term 3]**: [Definition]

### Business Workflows

1. [Workflow 1]: [Steps]
2. [Workflow 2]: [Steps]

## 4. Project Structure & Conventions

### Directory Structure

```
[project-root]/
├── src/
│   ├── components/        # Reusable components
│   ├── services/          # Business logic
│   ├── models/            # Data models
│   └── utils/             # Helper functions
├── tests/                 # Test files
├── docs/                  # Documentation
├── config/                # Configuration
└── scripts/               # Build/utility scripts
```

### Code Organization Patterns

- [Pattern 1]: [Description]
- [Pattern 2]: [Description]

### Naming Conventions

- **Files**: [Convention] (e.g., camelCase.js)
- **Classes**: [Convention] (e.g., PascalCase)
- **Functions**: [Convention] (e.g., camelCase)
- **Variables**: [Convention] (e.g., camelCase)

### Coding Standards

- [Standard 1]
- [Standard 2]
- See: [Link to detailed coding standards]

## 5. Getting Started for New Team Members

### Prerequisites

- **Knowledge**: [Required programming knowledge]
- **Tools**: [Required tools and installations]
- **Access**: [Required system access]

### Initial Setup (5 Steps)

1. **Clone Repository**
   ```bash
   git clone [repository-url]
   cd [project]
   ```

2. **Install Dependencies**
   ```bash
   npm install  # or equivalent
   ```

3. **Configure Environment**
   ```bash
   cp .env.example .env
   # Edit .env with local values
   ```

4. **Setup Database** (if applicable)
   ```bash
   npm run db:migrate
   npm run db:seed
   ```

5. **Verify Installation**
   ```bash
   npm run dev  # or equivalent
   # Verify application runs on http://localhost:[port]
   ```

### Development Workflow

1. Create feature branch: `git checkout -b feature/description`
2. Make changes and test locally
3. Commit: `git commit -m "description"`
4. Push: `git push origin feature/description`
5. Open Pull Request for review
6. Merge after approval

### Running Locally

```bash
npm run dev     # Start development server
npm test        # Run tests
npm run lint    # Check code quality
```

### Key Files to Read First

| File | Purpose |
|------|---------|
| [README.md](../README.md) | Project overview |
| [src/index.js](../src/index.js) | Application entry point |
| [src/models/](../src/models/) | Data models |
| [docs/API.md](./API.md) | API documentation |

## 6. Configuration & Environment

### Environment Variables

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| `NODE_ENV` | Environment (dev/prod) | `development` | Yes |
| `DATABASE_URL` | Database connection | `postgres://...` | Yes |
| `API_KEY` | Third-party API key | `sk-...` | No |

### Configuration Files

| File | Purpose | Location |
|------|---------|----------|
| `.env` | Local environment variables | Project root |
| `config.yml` | Application configuration | `config/` |
| `package.json` | Project metadata | Project root |

### Environment-Specific Configuration

- **Development**: [Configuration for dev environment]
- **Staging**: [Configuration for staging]
- **Production**: [Configuration for prod]

## 7. Data Management

### Data Models

[Description of key data structures and relationships]

### Key Database Schemas

```sql
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  email VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Data Migration Strategy

- [How to create migrations]
- [How to run migrations]
- [Rollback procedures]

### Backup & Recovery

- **Backup Procedure**: [Steps]
- **Restore Procedure**: [Steps]
- **Recovery RTO**: [Time objective]

## 8. Integration Points

### External APIs

| Service | Purpose | Documentation |
|---------|---------|---------------|
| [API 1] | [Purpose] | [Link] |
| [API 2] | [Purpose] | [Link] |

### Internal Service Communication

- [Service 1] communicates with [Service 2] via [Method]
- [Details of communication protocols]

### Webhooks & Events

[Description of event system and webhooks]

## 9. Security Considerations

### Authentication & Authorization

- **Method**: [OAuth/JWT/Session-based]
- **Token Format**: [Format details]
- **Scope**: [What scopes exist]

### Sensitive Data Handling

- [How passwords are hashed]
- [How sensitive data is encrypted]
- [Data retention policies]

### Security Best Practices

- Always use HTTPS in production
- Never commit secrets to version control
- Use environment variables for sensitive data
- [Other project-specific practices]

## 10. Performance Considerations

### Performance Requirements

- **Load Time**: [Target, e.g., <2s]
- **Throughput**: [Requests/second target]
- **Concurrent Users**: [Capacity target]

### Optimization Strategies

- [Caching strategy and tools]
- [Database query optimization]
- [Frontend optimization techniques]

### Monitoring & Profiling

- [Performance monitoring tools]
- [Profiling procedures]
- [Key metrics to watch]

## 11. Known Limitations & Trade-offs

### Current Limitations

- [Limitation 1]: [Why and impact]
- [Limitation 2]: [Why and impact]

### Technical Debt

| Issue | Impact | Priority | Solution |
|-------|--------|----------|----------|
| [Debt 1] | [Impact] | [Priority] | [Solution] |
| [Debt 2] | [Impact] | [Priority] | [Solution] |

### Future Considerations

- [Planned improvement 1]
- [Planned improvement 2]

## 12. Learning Resources

### Internal Documentation

- [README.md](../README.md) — Project overview
- [API.md](./API.md) — API documentation
- [Contributing.md](../CONTRIBUTING.md) — Contribution guidelines
- [Architecture.md](./Architecture.md) — System architecture

### External Resources

**Books**:

- [Book title]: [Description]

**Online Resources**:

- [Tutorial title]: [Link]
- [Documentation]: [Link]

**Community**:

- [Forum/Discord]: [Link]
- [GitHub Discussions]: [Link]

---

Generated with: **Prometh Context Framework by Prometh**

---

## Output Format

After successful documentation generation:

**README type** (3 files created):
```
✅ Documentation Generated Successfully

Type: README (landing page + companion docs)
Files:
  README.md               → project root (landing page, 5-min read)
  docs/getting-started.md → full tutorial walkthrough
  CONTRIBUTING.md         → contributor guide (GitHub auto-linked)

These files are ready to commit. No tracking file entry added.
```

**Runbook / Concept type** (1 file created):
```
✅ Documentation Generated Successfully

Type: [Runbook|Concept]
File: [path/to/file.md]
Location: [Where file was created]

The documentation has been created and is ready for review.

💡 Next Steps:
- Review generated documentation
- Add any project-specific details
- Update tracking file with new documentation
```

## Processing Instructions

1. Resolve documentation directory and tracking file
2. Determine documentation type (interactive if not provided)
3. Analyze repository thoroughly:
   - Technology stack detection
   - Code structure analysis
   - Dependency mapping
   - Configuration scanning
4. Select appropriate template from the three embedded templates above
5. Generate comprehensive documentation with extracted information
6. Create file in appropriate location (README/RUNBOOK in root, concept docs in `${DOCS_DIR}/concepts/`)
7. Update tracking file if it exists
8. Report successful completion with file path

Start by determining the documentation type, then analyze the repository structure, apply the appropriate embedded template, and generate the comprehensive documentation file.
