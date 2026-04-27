---
name: Prometh Doc README
description: Lean README landing page template — 5-min read max. Links out to docs/getting-started.md and CONTRIBUTING.md for detail.
---

You are a technical documentation specialist. Generate a lean, scannable README.md that serves as the project landing page — it must be readable in under 5 minutes. Detail lives in `docs/getting-started.md` and `CONTRIBUTING.md`. Link to those files instead of duplicating content here.

**Constraints:**
- Target ≤300 lines
- No deep configuration reference, no migration guides, no full usage examples
- Every section that would grow long → replace with a link to the companion file
- Remove any template section that does not apply to this project type

---

# [Project Name]

> [One sentence: what it does and who it's for]

[![License](https://img.shields.io/badge/License-[LICENSE]-blue.svg)](LICENSE)
[![Version](https://img.shields.io/badge/version-[VERSION]-green.svg)](https://github.com/[USERNAME]/[REPO]/releases)

[Optional: embed a short demo GIF or terminal recording — `![Demo](docs/images/demo.gif)`]

## What it does

[2–4 bullet points covering the core value proposition. Focus on outcomes, not features.]

- **[Capability 1]**: [What problem it solves]
- **[Capability 2]**: [What problem it solves]
- **[Capability 3]**: [What problem it solves]

## Quick start

```bash
# Install
[install command — 1-3 lines maximum]

# First use
[the single most important command to try]
```

→ For a complete walkthrough, see [Getting Started](docs/getting-started.md).

## Installation

### Prerequisites

- [Requirement 1] [version]
- [Requirement 2] [version]

### Install

```bash
[install steps — keep to ≤10 lines; link to getting-started.md if platform-specific steps are needed]
```

### Verify

```bash
[verification command]
# Expected: [expected output]
```

## Usage

[Show the 2–3 most common invocations. Not every flag — just what gets people productive immediately.]

```bash
[primary command example]
[secondary command example]
```

[One-line description of what each does.]

→ For full usage examples and workflow guides, see [Getting Started](docs/getting-started.md).

## Key features

| Feature | Description |
|---------|-------------|
| [Feature 1] | [One-line description] |
| [Feature 2] | [One-line description] |
| [Feature 3] | [One-line description] |

## Configuration

[If configuration is minimal, show it inline. If it's complex, summarize the concept and link out.]

```[format]
[minimal config example — ≤15 lines]
```

→ Full configuration reference: [docs/getting-started.md#configuration](docs/getting-started.md#configuration)

## Documentation

| Document | Description |
|----------|-------------|
| [Getting Started](docs/getting-started.md) | Full installation walkthrough, first-use tutorial, examples |
| [Contributing](CONTRIBUTING.md) | Dev environment setup, branch strategy, PR process |
| [Changelog](CHANGELOG.md) | Version history |

## Contributing

Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for dev setup, branch naming, commit format, and PR guidelines.

## License

[License name] — see [LICENSE](LICENSE) for details.

---

**Instructions for transformation:**
- Analyze project type (CLI tool, library, framework, SaaS, etc.) from codebase
- Extract real project name, description, install commands, and primary usage
- Remove template sections that don't apply (e.g., no API reference section here — that belongs in getting-started)
- Populate badges with real values from package metadata or CI configuration
- Keep the demo/screenshot if the project has a visual component
- The goal is a README a new visitor reads in 5 minutes and decides "I want to try this"
- **Sensitive Data Protection** — never include API keys, secrets, tokens, passwords, credentials, environment variable values, private hostnames/IPs, PII, database connection strings, or `.env` contents. Use placeholders where examples are needed (e.g. `sk-...`, `your-api-key-here`).
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

Generated with: **Prometh Context Framework by Prometh**
