---
name: prometh-spec
description: Create or normalize implementation SPECs with tracking file updates. Supports interactive mode, file normalization, PRD-to-SPEC workflow, and 3-phase implementation structure. Use this skill when asked to create a SPEC, write a technical specification, convert an implementation description into structured SPEC format, or derive a SPEC from an existing PRD.
---

# SPEC Creation and Normalization Skill

You are tasked with creating new Specification (SPEC) documents or normalizing existing documents into standardized SPEC format for implementation tasks.

## Directory and Tracking File Resolution

**MANDATORY FIRST STEP**: Resolve the documentation directory and tracking file:

**Directory Resolution:**
```bash
if [ -d "prometh-docs.local" ]; then
  DOCS_DIR="prometh-docs.local"
elif [ -d "prometh-docs" ]; then
  DOCS_DIR="prometh-docs"
else
  echo "❌ Error: Neither prometh-docs/ nor prometh-docs.local/ found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Tracking File Resolution:**
```bash
if [ -f "PROMETH.local.md" ]; then
  TRACKING_FILE="PROMETH.local.md"
elif [ -f "PROMETH.md" ]; then
  TRACKING_FILE="PROMETH.md"
else
  echo "❌ Error: Neither PROMETH.md nor PROMETH.local.md found."
  echo "Please run '/prometh-init' to initialize the framework."
  exit 1
fi
```

**Priority Rules:**
- `prometh-docs.local/` takes precedence over `prometh-docs/`
- `PROMETH.local.md` takes precedence over `PROMETH.md`
- Use resolved variables (`$DOCS_DIR` and `$TRACKING_FILE`) for all file operations

## Processing Logic

### Input Handling

1. **PRD-to-SPEC Mode**: If the conversation references `--from-prd [prd-file.md]`, create SPEC(s) from that existing PRD
2. **File Path Argument**: If a file path is mentioned, read and normalize that file
3. **Text Input**: If no file path, process the text content provided in the conversation
4. **Interactive Mode**: If no content provided, prompt user for implementation description

### Document Processing

1. Content analysis and implementation type classification
2. Apply unified SPEC template with 3-phase workflow
3. Ensure `${DOCS_DIR}/specs/` directory exists
4. Generate comprehensive SPEC with implementation workflow
5. Create descriptive filename from content analysis
6. Update tracking file with new SPEC information and traceability

## Implementation Type Classification

- **Feature**: "new feature", "add", "create", "implement", "build"
- **Bug Fix**: "fix", "bug", "issue", "error", "broken"
- **Enhancement**: "improve", "enhance", "upgrade", "optimize", "better"
- **Technical Task**: "setup", "configure", "migrate", "refactor", "maintenance"

## Filename Generation

Patterns by type:

- **Features**: `feature-[name]-spec.md`
- **Bugs**: `fix-[issue]-spec.md`
- **Enhancements**: `enhance-[name]-spec.md`
- **Tasks**: `task-[name]-spec.md`

## Tracking File Management

After creating or normalizing a SPEC:

### SPEC Entry Format

```
| [filename].md | [Current Date] | [Type] | [Linked PRD] | Draft | [Description] | [Current Date] |
```

**Type Options**: Feature, Bug Fix, Enhancement, Technical Task

**Status Options**: Draft, Under Review, Approved, In Progress, Testing, Completed

### Update Tracking File

- Add SPEC to inventory table
- Update traceability matrix if PRD-linked
- Add to recent activity
- Update "Last Updated" timestamp

## Privacy Note

When updating the tracking file:

- Use relative paths only (`${DOCS_DIR}/specs/filename.md`)
- Never include user home directories or private paths
- Keep all content shareable with team members

## Error Handling

- **No tracking file found**: Suggest `/prometh-init`
- **File not found**: Report access issues
- **Directory creation failures**: Report permission issues
- **Tracking file issues**: Continue with SPEC creation, warn about updates

---

## SPEC Template

You are an expert technical specification writer. Transform the input content into a comprehensive, implementation-ready SPEC following modern development best practices. Always output in proper SPEC format with the following structure:

# [Feature/Task Name] - Technical Specification

## Document Information

- **Version**: 1.0
- **Date**: [Current Date]
- **Status**: Draft
- **Type**: [Feature/Bug Fix/Enhancement/Task]
- **Priority**: [Critical/High/Medium/Low]
- **Assignee**: [Developer/Team]
- **Epic/Story ID**: [Reference if applicable]

## 1. Overview

### 1.1 Purpose

[Clear description of what needs to be implemented and why]

### 1.2 Scope

- **In Scope**: [What will be implemented]
- **Out of Scope**: [What will NOT be implemented]

### 1.3 User Story

**As a** [user type]
**I want** [functionality]
**So that** [benefit/value]

## 2. Requirements Analysis

### 2.1 Functional Requirements

- **FR1**: [Specific functional requirement with clear behavior]
- **FR2**: [Additional functional requirement with measurable outcome]

### 2.2 Non-Functional Requirements

- **Performance**: [Response time, throughput requirements]
- **Security**: [Authentication, authorization, data protection]
- **Reliability**: [Error handling, recovery, uptime requirements]
- **Usability**: [User experience, accessibility standards]

### 2.3 Acceptance Criteria

```gherkin
Given [initial context/state]
When [action or event occurs]
Then [expected outcome/behavior]

Given [additional scenario context]
When [different action occurs]
Then [different expected outcome]
```

## 3. Implementation Workflow

### Phase 1: Planning

**Objective**: Complete requirements analysis and technical design

**Tasks:**

- [ ] **Requirements Clarification**
  - Validate requirements with stakeholders
  - Define edge cases and error scenarios
  - Document assumptions and constraints
- [ ] **Technical Design**
  - Create system architecture and component design
  - Define data models and API contracts
  - Plan integration points and dependencies
- [ ] **Resource Planning**
  - Estimate development effort and timeline
  - Identify required skills and team members
  - Plan testing strategy and QA approach

**Deliverables:**

- [ ] Technical design document
- [ ] Data model specifications
- [ ] API contract definitions
- [ ] Test plan outline

### Phase 2: Task Breakdown

**Objective**: Create detailed development tasks with clear acceptance criteria

**Tasks:**

- [ ] **Development Task Creation**
  - Break down implementation into manageable tasks
  - Define clear acceptance criteria for each task
  - Prioritize tasks by dependency and risk
- [ ] **Dependency Mapping**
  - Identify technical dependencies between tasks
  - Map external service and API dependencies
  - Document team coordination requirements
- [ ] **Risk Assessment**
  - Identify potential technical risks and blockers
  - Plan mitigation strategies for high-risk items
  - Define fallback approaches for critical path items

**Deliverables:**

- [ ] Detailed task breakdown with estimates
- [ ] Dependency map and critical path analysis
- [ ] Risk assessment and mitigation plans
- [ ] Team coordination and communication plan

### Phase 3: Implementation

**Objective**: Execute development tasks with quality assurance and validation

**Tasks:**

- [ ] **Core Development**
  - Implement features according to technical design
  - Write unit tests for all new functionality
  - Follow established coding standards and practices
- [ ] **Integration & Testing**
  - Integrate with existing systems and services
  - Execute comprehensive testing strategy
  - Perform code reviews and quality assurance
- [ ] **Deployment & Validation**
  - Deploy to staging/test environment
  - Validate against acceptance criteria
  - Perform user acceptance testing if applicable

**Deliverables:**

- [ ] Implemented feature/functionality
- [ ] Comprehensive test suite with >80% coverage
- [ ] Documentation updates
- [ ] Production deployment plan

## 4. Technical Design

### 4.1 System Architecture

[High-level architecture diagram and component relationships]

### 4.2 Data Model

```sql
-- Database schema changes
[Table definitions, relationships, indexes]
```

### 4.3 API Design

```yaml
# API endpoint specifications
[OpenAPI/Swagger definitions or similar]
```

### 4.4 Component Specifications

| Component | Responsibility | Dependencies | Interface |
|-----------|----------------|--------------|-----------|
| [Component 1] | [Purpose] | [Dependencies] | [Interface] |
| [Component 2] | [Purpose] | [Dependencies] | [Interface] |

## 5. Implementation Details

### 5.1 Core Logic

```[language]
// Pseudo-code or algorithm description
[Key implementation logic and algorithms]
```

### 5.2 File Structure

```
[project-structure]
├── [directory/]
│   ├── [file.ext]
│   └── [file.ext]
└── [directory/]
    ├── [file.ext]
    └── [file.ext]
```

### 5.3 Configuration Changes

- [Configuration parameter changes]
- [Environment variable additions]
- [Feature flag implementations]

## 6. User Interface & Experience

### 6.1 UI Requirements

- [Visual design specifications]
- [Component behavior and interactions]
- [Responsive design considerations]

### 6.2 User Flow

1. [Step 1: User action and system response]
2. [Step 2: Subsequent user action and system response]
3. [Step 3: Final outcome and confirmation]

### 6.3 Error Handling & Validation

- [Input validation requirements]
- [Error message specifications]
- [Fallback behavior definitions]

## 7. Testing Strategy

### 7.1 Unit Testing

- Test coverage requirements: >80%
- Critical functions and edge cases to test
- Mock and stub requirements

### 7.2 Integration Testing

- API endpoint testing requirements
- Database integration testing
- External service integration testing

### 7.3 User Acceptance Testing

- UAT scenarios and test cases
- User validation requirements
- Success metrics and acceptance thresholds

## 8. Security Considerations

### 8.1 Authentication & Authorization

- [Authentication mechanism]
- [Authorization and role-based access]
- [Session management]

### 8.2 Data Protection

- [Data encryption requirements]
- [Sensitive data handling]
- [Compliance requirements (GDPR, HIPAA, etc.)]

### 8.3 Security Testing

- [Security vulnerability testing]
- [Penetration testing requirements]
- [Security review checklist]

## 9. Performance & Monitoring

### 9.1 Performance Requirements

- [Response time targets]
- [Throughput requirements]
- [Scalability targets]

### 9.2 Monitoring & Alerting

- [Key metrics to monitor]
- [Alert thresholds and conditions]
- [Logging and debugging strategy]

### 9.3 Optimization Strategies

- [Caching strategies]
- [Database optimization]
- [Frontend optimization]

## 10. Deployment & Operations

### 10.1 Deployment Strategy

- [Deployment approach (rolling, blue-green, canary)]
- [Environment promotion path]
- [Deployment checklist and verification]

### 10.2 Rollback Plan

- [Rollback conditions and decision criteria]
- [Rollback procedures]
- [Data migration rollback if applicable]

### 10.3 Post-Deployment Validation

- [Smoke tests]
- [User acceptance validation]
- [Performance validation]

## 11. Documentation

### 11.1 Developer Documentation

- [API documentation]
- [Code comments and inline documentation]
- [Architecture decision records]

### 11.2 User Documentation

- [User guides and tutorials]
- [FAQ and troubleshooting]
- [Release notes]

### 11.3 Operational Documentation

- [Runbook for operations team]
- [Monitoring and alerting guide]
- [Incident response procedures]

## 12. Dependencies & Assumptions

### 12.1 Technical Dependencies

- [External services and APIs]
- [Library and framework versions]
- [Infrastructure requirements]

### 12.2 Key Assumptions

- [Technical assumptions]
- [Timeline assumptions]
- [Resource assumptions]

### 12.3 Constraints

- [Budget constraints]
- [Timeline constraints]
- [Technical constraints]

## 13. Success Criteria & Definition of Done

### 13.1 Success Criteria

- All acceptance criteria met and tested
- >80% code coverage achieved
- Performance requirements validated
- Security review completed

### 13.2 Definition of Done

- [ ] All development tasks complete
- [ ] All tests passing
- [ ] Code review approved
- [ ] Documentation updated
- [ ] Deployment ready
- [ ] Stakeholder acceptance obtained

## 14. Document Change History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | [Date] | [Author] | Initial SPEC creation |

---

**Instructions for transformation:**

- Analyze input and classify as Feature/Bug Fix/Enhancement/Task
- Extract key technical information
- Focus on implementation readiness with 3-phase workflow
- Include comprehensive acceptance criteria in Gherkin format
- Ensure all sections properly formatted
- Fill gaps with reasonable assumptions
- Maintain technical documentation standards
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

## Output Format

After successful SPEC creation:

```
✅ SPEC Created Successfully

File: ${DOCS_DIR}/specs/[filename]-spec.md
Type: [Feature/Bug Fix/Enhancement/Task]
Status: Draft
Linked PRD: [PRD name if applicable]
Tracking: Added to tracking file inventory

The SPEC has been saved and is ready for development.

💡 Next Steps:
- Execute SPEC with guided implementation: /prometh-build ${DOCS_DIR}/specs/[filename]-spec.md
- Generate project documentation: load prometh-doc skill
- View project status: /prometh-status
```

Start by resolving the documentation directory and tracking file, then process the input according to type, classify implementation type, generate meaningful filenames, apply the unified SPEC template with 3-phase workflow in the resolved directory.
