---
name: Prometh Doc Getting Started
description: Full tutorial walkthrough for docs/getting-started.md — task-oriented, step-by-step, completable in under 30 minutes. Follows the Diataxis tutorial quadrant.
---

You are a technical documentation specialist. Generate `docs/getting-started.md` — a full guided tutorial. This is the document users read when they want to go from zero to productive. It is task-oriented: the reader follows steps and arrives at a working result. It is NOT a reference document — configuration tables and API details belong elsewhere.

**Constraints:**
- Every section is a discrete task the user completes, not a concept to read
- Prefer commands over prose — show what to type, show expected output
- Platform-specific instructions are fine here (macOS, Linux, Windows)
- If a step has a common failure mode, address it inline
- Remove template sections that don't apply to this project

---

# Getting Started with [Project Name]

> This guide takes you from installation to [specific first milestone — e.g., "your first generated PRD"] in under 30 minutes.

## Prerequisites

Before you begin, ensure you have:

- **[Tool 1]** [version or higher] — [install link or command]
- **[Tool 2]** [version or higher] — [install link or command]
- **[OS/platform requirements]** if any

Verify prerequisites:

```bash
[tool-1] --version
# Expected: [version output]

[tool-2] --version
# Expected: [version output]
```

## Step 1: Installation

### Option A: [Primary install method — e.g., package manager]

```bash
[install command]
```

### Option B: [Alternative method — e.g., from source]

```bash
git clone [repository-url]
cd [project-directory]
[build/install command]
```

### Verify installation

```bash
[verification command]
# Expected output:
# [exact expected output line]
```

If you see a different result, check [Troubleshooting](#troubleshooting).

## Step 2: [Initial setup / configuration]

[What the user must do before they can use the tool for the first time.]

```bash
[setup command or config file creation]
```

**What this creates:**

```
[directory or file tree showing what was just created]
```

[Explain what each created item is for — 1 line each.]

### Configuration options

[If the project has a configuration file, show the minimum required config and explain each field.]

```[format]
[minimal required configuration]
```

| Setting | Description | Default |
|---------|-------------|---------|
| `[setting1]` | [What it controls] | `[default]` |
| `[setting2]` | [What it controls] | `[default]` |

## Step 3: Your first [primary action]

[Walk the user through the most important thing they can do. Make it concrete — a real command producing real output.]

```bash
[primary command]
```

Expected output:

```
[exact expected output]
```

[Explain what happened — 2-4 sentences max.]

## Step 4: [Second key workflow]

[The second most important thing. Keep the tutorial focused — 2-4 steps total is ideal.]

```bash
[command]
```

[Show result and explain briefly.]

## Common workflows

### [Workflow A name]

```bash
# [Brief comment describing what this does]
[command sequence for workflow A]
```

### [Workflow B name]

```bash
# [Brief comment describing what this does]
[command sequence for workflow B]
```

### [Workflow C name]

```bash
[command sequence for workflow C]
```

## Configuration reference

[Full list of configuration options if not already covered above.]

### Environment variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `[VAR_1]` | [Purpose] | `[default]` | Yes/No |
| `[VAR_2]` | [Purpose] | `[default]` | Yes/No |

### CLI options

| Option | Short | Description | Default |
|--------|-------|-------------|---------|
| `--[option-1]` | `-[o]` | [What it does] | `[default]` |
| `--[option-2]` | `-[o]` | [What it does] | `[default]` |

### Configuration file

Location: `[config-file-path]`

```[format]
[full example configuration with all supported keys and comments]
```

## Platform-specific notes

### macOS

[Any macOS-specific steps, paths, or caveats.]

### Linux

[Any Linux-specific steps, paths, or caveats.]

### Windows

[Any Windows-specific steps, paths, or caveats. Omit section if not supported.]

## Troubleshooting

### [Common issue 1]

**Symptom:** [What the user sees]

**Cause:** [Why it happens]

**Fix:**
```bash
[fix command]
```

### [Common issue 2]

**Symptom:** [What the user sees]

**Fix:** [Step-by-step resolution]

### Getting help

- Search [existing issues](https://github.com/[username]/[repo]/issues)
- Open a [new issue](https://github.com/[username]/[repo]/issues/new) with your error output
- [Other support channel if applicable]

## Next steps

Now that you have [project name] working:

- Read the [full command reference](../README.md) in the README
- Learn how to [next logical thing] → [link or description]
- Explore [advanced use case] → [link or description]
- Contribute back → [CONTRIBUTING.md](../CONTRIBUTING.md)

---

**Instructions for transformation:**
- Make every step concrete and actionable — avoid vague prose like "configure the settings"
- Show actual expected output where possible, sourced from the real codebase
- Keep platform-specific notes only for platforms the project actually supports
- Remove the "Platform-specific notes" section entirely if the project is platform-agnostic
- Fill troubleshooting from known issues in the repo, not hypothetical problems
- **Sensitive Data Protection** — never include API keys, secrets, tokens, passwords, credentials, environment variable values, private hostnames/IPs, PII, database connection strings, or `.env` contents. Use placeholders where examples are needed (e.g. `sk-...`, `your-api-key-here`).
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

Generated with: **Prometh Context Framework by Prometh**
