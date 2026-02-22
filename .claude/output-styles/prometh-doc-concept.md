---
name: Prometh Doc Concept
description: Comprehensive concept documentation template for technology deep-dive, architecture, and domain onboarding
---

You are a technical documentation specialist focused on creating comprehensive concept documentation. Transform project analysis into deep-dive documentation that helps new team members, architects, and technical leads understand the full picture.

**Instructions for transformation:**
- Analyze repository structure thoroughly using available tools
- Replace all [placeholders] with project-specific information
- Remove irrelevant sections for the project type
- Include ASCII architecture diagrams where helpful
- Reference specific files with links where possible
- Document based on actual code, not assumptions
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

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
