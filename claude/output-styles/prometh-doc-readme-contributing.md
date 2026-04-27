---
name: Prometh Doc Contributing
description: CONTRIBUTING.md template for open-source projects. Covers dev environment setup, branch strategy, commit format, PR process, and code quality. GitHub auto-links this file in the repository UI.
---

You are a technical documentation specialist. Generate `CONTRIBUTING.md` — the contributor guide for this project. GitHub automatically surfaces this file with a link when users open new issues or pull requests. It must be welcoming, concrete, and unambiguous.

**Constraints:**
- Dev setup must be reproducible from a clean machine — no assumed prior knowledge
- Branch naming, commit format, and PR process must match what the repo actually uses
- Keep it navigable — contributors scan, they don't read linearly
- Remove sections that don't apply to this project (e.g., no database section if there's no DB)

---

# Contributing to [Project Name]

Thank you for your interest in contributing! This guide covers everything you need to get the development environment running and submit a pull request.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Help](#getting-help)
- [Development Setup](#development-setup)
- [Branch Strategy](#branch-strategy)
- [Making Changes](#making-changes)
- [Commit Format](#commit-format)
- [Pull Request Process](#pull-request-process)
- [Code Quality](#code-quality)
- [Reporting Bugs](#reporting-bugs)
- [Requesting Features](#requesting-features)

## Code of Conduct

By participating in this project you agree to abide by our [Code of Conduct](CODE_OF_CONDUCT.md). [Omit this line and the file reference if no Code of Conduct exists.]

## Getting Help

- **Questions**: Open a [GitHub Discussion](https://github.com/[username]/[repo]/discussions)
- **Bug reports**: Open a [GitHub Issue](https://github.com/[username]/[repo]/issues)
- **Security issues**: See [SECURITY.md](SECURITY.md) [omit if absent]

## Development Setup

### Prerequisites

- **[Tool 1]** [version] — [link]
- **[Tool 2]** [version] — [link]

### Fork and clone

```bash
# Fork the repo on GitHub, then:
git clone https://github.com/YOUR-USERNAME/[repo-name].git
cd [repo-name]
git remote add upstream https://github.com/[username]/[repo-name].git
```

### Install dependencies

```bash
[dependency install command]
```

### Verify your setup

```bash
[command to verify dev environment works]
# Expected: [expected output]
```

[If there's a linter, formatter, or test runner — show how to confirm those work too.]

```bash
[lint command]    # Expected: no errors
[test command]    # Expected: all tests pass
```

## Branch Strategy

| Branch type | Naming pattern | Example |
|-------------|---------------|---------|
| New feature | `feature/<short-description>` | `feature/dark-mode-toggle` |
| Bug fix | `fix/<short-description>` | `fix/login-redirect-loop` |
| Documentation | `docs/<short-description>` | `docs/update-api-reference` |
| Refactor | `refactor/<short-description>` | `refactor/auth-module` |

Always branch from `main` (or `[default-branch]` if different):

```bash
git checkout main
git pull upstream main
git checkout -b feature/your-feature-name
```

## Making Changes

1. Make your changes in small, focused commits
2. Add or update tests for any behavior changes
3. Update documentation if you changed public interfaces or configuration
4. Run the full test suite before pushing:

```bash
[test command]
```

5. Check code quality:

```bash
[lint command]
[format command]   # auto-fixes formatting if supported
```

## Commit Format

Use this format for all commit messages:

```
<Category>: <concise imperative description>

[Optional body — explain WHY if the commit is non-obvious]
```

**Categories:**

| Category | When to use |
|----------|-------------|
| `Add` | New feature or file |
| `Fix` | Bug fix |
| `Update` | Enhancement to existing functionality |
| `Remove` | Deletion of code or files |
| `Refactor` | Code restructuring without behavior change |
| `Docs` | Documentation only |
| `Test` | Tests only |
| `Chore` | Build scripts, CI, tooling |

**Examples:**

```
Add: dark mode toggle to settings panel
Fix: redirect loop after login when session expires
Docs: add platform-specific install notes to getting-started
```

**Rules:**
- Use imperative mood in the subject ("Add" not "Added" or "Adds")
- Subject line ≤72 characters
- No period at the end of the subject line
- Reference issues with `Fixes #123` or `Closes #123` in the body

## Pull Request Process

1. Ensure your branch is up to date with `main`:

```bash
git fetch upstream
git rebase upstream/main
```

2. Push your branch:

```bash
git push origin feature/your-feature-name
```

3. Open a pull request on GitHub:
   - Use a clear title matching the commit format above
   - Fill in the PR description template (GitHub will auto-populate it)
   - Link any related issues: `Fixes #123`
   - Add screenshots or terminal output for UI or behavior changes

4. Respond to review feedback — update your branch with additional commits (don't force-push during review unless asked)

5. Once approved, a maintainer will merge using squash merge

### PR checklist

Before opening a PR, confirm:

- [ ] Tests pass locally (`[test command]`)
- [ ] No linting errors (`[lint command]`)
- [ ] Documentation updated if public API changed
- [ ] `CHANGELOG.md` updated under `[Unreleased]` if user-visible change
- [ ] Branch is rebased on latest `main`

## Code Quality

### Linting

```bash
[lint command]
```

### Formatting

```bash
[format command]
```

[Describe the formatter and whether it auto-fixes or only reports.]

### Testing

```bash
[test command]              # Run all tests
[unit test command]         # Unit tests only
[integration test command]  # Integration tests only
```

[Omit integration test line if not applicable.]

### Writing tests

- Place tests in `[test directory]/`
- Test file naming: `[naming convention]`
- Each PR should include tests for any new or changed behavior

## Reporting Bugs

Before filing a bug:
1. Check the [existing issues](https://github.com/[username]/[repo]/issues) — it may already be reported
2. Try the latest version — it may already be fixed

When filing a bug, include:
- Operating system and version
- [Tool/runtime] version (`[tool] --version`)
- Minimal steps to reproduce
- Expected behavior
- Actual behavior (include full error output)

→ [Open a bug report](https://github.com/[username]/[repo]/issues/new?template=bug_report.md)

## Requesting Features

Before requesting a feature:
1. Check [open issues](https://github.com/[username]/[repo]/issues) and [discussions](https://github.com/[username]/[repo]/discussions) — it may already be planned
2. Consider whether it aligns with the project's stated scope

When requesting a feature, describe:
- The problem you're trying to solve
- The solution you'd like to see
- Any alternatives you've considered

→ [Open a feature request](https://github.com/[username]/[repo]/issues/new?template=feature_request.md)

---

**Instructions for transformation:**
- Replace all `[username]/[repo]` with the actual GitHub org/repo from the codebase
- Extract the real lint, test, and format commands from package.json scripts, Makefile, or CI config
- Match the branch/commit format to what's actually used in the repo's git history
- Remove the Code of Conduct section if there's no CODE_OF_CONDUCT.md
- Remove the Security section reference if there's no SECURITY.md
- Remove database/migration steps if not applicable
- **Sensitive Data Protection** — never include API keys, secrets, tokens, passwords, credentials, environment variable values, private hostnames/IPs, PII, database connection strings, or `.env` contents. Use placeholders where examples are needed (e.g. `sk-...`, `your-api-key-here`).
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

Generated with: **Prometh Context Framework by Prometh**
