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

## Three Documentation Types

### 1. README

- **Output**: `README.md` in project root
- **Purpose**: High-level project overview, quick start, installation
- **Audience**: Developers, users, contributors
- **Sections**: Features, demo, installation, usage, API reference, troubleshooting, etc.

### 2. Runbook

- **Output**: `RUNBOOK.md` in project root (or docs directory)
- **Purpose**: Operational procedures, incident response, maintenance
- **Audience**: DevOps, SRE, operators, on-call engineers
- **Sections**: Architecture, monitoring, incident response, recovery procedures, etc.

### 3. Concept

- **Output**: `${DOCS_DIR}/concepts/[name].md`
- **Purpose**: Deep-dive technical understanding, onboarding, architecture
- **Audience**: New team members, architects, technical leads
- **Sections**: Technology stack, architecture, domain concepts, getting started, etc.

## Processing Logic

### Step 1: Documentation Type Selection

If type not specified in the conversation, display interactive menu:

```
📚 Documentation Type Selection

1. README - High-level project overview and quick start
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

- Create file in appropriate location
- For Concept docs: create `${DOCS_DIR}/concepts/` directory if needed
- For README/Runbook: write to project root

### Step 6: Tracking File Update

If tracking file exists:

- Add entry to technical documentation table
- Update recent activity log
- Update "Last Updated" timestamp

## Supported Invocation Styles

```
readme      → Creates README.md directly
runbook     → Creates RUNBOOK.md directly
concept     → Creates concept documentation with auto-naming
(none)      → Shows interactive menu to select type
```

## Supported Options

- `--include-examples` — Include code examples from repository
- `--include-risks` — Include risk assessment sections (especially for Runbook)
- `--output [path]` — Specify custom output path/filename
- `--scope [service|environment|full-stack]` — Documentation scope

## Privacy Note

When updating the tracking file:

- Use relative paths only (e.g., `${DOCS_DIR}/concepts/name.md`)
- Never include absolute paths or user home directories
- Keep all content shareable with team members

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

## Error Handling

- **No type specified**: Show interactive menu
- **Invalid type**: Display valid options and re-prompt
- **Repository analysis fails**: Continue with generic template
- **File write errors**: Report issue and suggest alternative paths

---

## Embedded Template 1: README

Use this comprehensive template for README generation. Auto-populate based on repository analysis:

# [Project Name]

> [Brief, compelling description of what the project does]

[GitHub badges: license, version, build status, etc.]

## Features

- [Key capability 1]
- [Key capability 2]
- [Key capability 3]
- [Distinguishing features]

## Demo

[Link to live demo if available]

### Screenshots

[Images or animated GIFs showing project in action]

## Installation

### Prerequisites

- [Required software/language version]
- [Required tools and dependencies]
- [System requirements if applicable]

### Using Package Manager

```bash
# npm
npm install [project-name]

# yarn
yarn add [project-name]

# pip
pip install [project-name]

# Homebrew
brew install [project-name]
```

### Manual Installation

```bash
git clone [repository-url]
cd [project-directory]
[build-command]
[install-command]
```

### Verification

```bash
[command-to-verify-installation]
```

## Quick Start

1. [First step with command]
2. [Second step with command]
3. [Third step - basic usage]

## Usage

### CLI Usage

```bash
[command] [options]
[example-command-1]
[example-command-2]
```

### Programmatic Usage

```[language]
import [library] from '[package]'

// Example code
```

### Common Use Cases

- [Use case 1]: [brief description]
- [Use case 2]: [brief description]

## Configuration

### Configuration Files

- `[config-file-1]`: [description]
- `[config-file-2]`: [description]

### Environment Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `[VAR_1]` | [Description] | [Default] |
| `[VAR_2]` | [Description] | [Default] |

### CLI Options

```bash
--option1         Description of option 1
--option2 VALUE   Description of option 2
```

## API Reference

### Functions/Classes

```[language]
class/function Name
  Description and usage
  Parameters
  Returns
  Examples
```

### REST API Endpoints

```
GET /api/endpoint1          Description
POST /api/endpoint2         Description
  Request: [structure]
  Response: [structure]
```

## Examples

### Example 1: [Scenario]

```bash
# Setup
# Execution
# Expected output
```

### Example 2: [Different Scenario]

```[language]
// Code example
// Explanation
```

## Contributing

### Development Setup

```bash
git clone [repository-url]
cd [project]
npm install  # or equivalent
npm run dev  # or equivalent
```

### Development Workflow

1. Create feature branch: `git checkout -b feature/my-feature`
2. Make changes and test
3. Commit: `git commit -m "description"`
4. Push: `git push origin feature/my-feature`
5. Open Pull Request

### Code Quality Standards

- [Testing requirements]
- [Linting standards]
- [Documentation requirements]

## Testing

### Running Tests

```bash
npm test                     # Run all tests
npm run test:unit            # Unit tests
npm run test:integration     # Integration tests
```

### Test Coverage

```bash
npm run coverage
```

### Writing Tests

[Guidelines for writing tests in this project]

## Deployment

### Production Deployment

#### Docker

```bash
docker build -t [image-name] .
docker run [image-name]
```

#### Cloud Platforms

- **AWS**: [Deployment instructions]
- **GCP**: [Deployment instructions]
- **Azure**: [Deployment instructions]
- **Heroku**: [Deployment instructions]

## Troubleshooting

### Common Issues

**Issue**: [Problem description]

- **Cause**: [Root cause]
- **Solution**: [Step-by-step resolution]

**Issue**: [Another problem]

- **Solution**: [How to fix]

### Debug Mode

```bash
[debug-command-or-env-var]
```

### Getting Help

- [Link to documentation]
- [Link to issues page]
- [Support contact information]

## FAQ

**Q: [Common question 1]**
A: [Answer with details]

**Q: [Common question 2]**
A: [Answer with explanation]

## Changelog

See [CHANGELOG.md](./CHANGELOG.md) for version history.

## License

This project is licensed under the [LICENSE-TYPE] License - see [LICENSE](./LICENSE) file for details.

## Support

- [Full Documentation](./docs)
- [Report Issues](./issues)

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

```
✅ Documentation Generated Successfully

Type: [README|Runbook|Concept]
File: [path/to/file.md]
Size: [Approximate line count]
Location: [Where file was created]

The documentation has been created and is ready for review.

💡 Next Steps:
- Review generated documentation
- Add any project-specific details
- Update tracking file with new documentation
- Share with team: /prometh-status
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
