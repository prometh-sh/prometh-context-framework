---
description: Smart repository initialization - analyze codebase and generate comprehensive PRDs for projects with poor documentation
argument-hint: "[--think|--think-hard|--think-harder|--ultrathink] [path]"
allowed-tools: ["Read", "Glob", "Grep", "LS", "Write", "MultiEdit"]
---

# /prometh-init Command

Intelligent repository initialization for projects with poor or missing documentation. This command performs deep codebase analysis and generates comprehensive Product Requirements Documents (PRDs) based on discovered functionality, architecture patterns, and business context.

## Usage

```bash
/prometh-init [thinking-option] [path]
```

## Thinking Depth Options

### `--think` (Basic Analysis)
**Speed**: Fast (~2-3 minutes)  
**Scope**: Surface-level repository assessment
- Repository structure mapping and file inventory
- Technology stack identification (languages, frameworks, dependencies)
- Existing documentation assessment and gap analysis
- Basic feature inventory from obvious code patterns
- Simple dependency analysis

### `--think-hard` (Deep Analysis) 
**Speed**: Moderate (~5-8 minutes)  
**Scope**: Comprehensive code pattern analysis
- Architecture pattern recognition (MVC, microservices, etc.)
- API endpoint discovery and documentation
- Database schema mapping and data model extraction
- Security implementation review and assessment
- Configuration analysis (env vars, configs, secrets management)
- Build and deployment pipeline analysis

### `--think-harder` (Advanced Analysis)
**Speed**: Thorough (~10-15 minutes)  
**Scope**: Business logic and flow reconstruction
- User flow reconstruction from code paths
- Integration dependency mapping (external APIs, services)
- Performance bottleneck identification
- Business logic extraction and rule discovery
- Error handling and edge case analysis
- Testing coverage assessment and quality metrics

### `--ultrathink` (Comprehensive Analysis)
**Speed**: Exhaustive (~20-30 minutes)  
**Scope**: Strategic business domain modeling
- Complete domain model reconstruction
- Competitive landscape analysis based on feature set
- Technical debt quantification and prioritization
- Strategic roadmap recommendations
- Security vulnerability assessment
- Scalability and performance optimization opportunities
- Business value and ROI analysis for discovered features

## Repository Analysis Workflow

### Phase 1: Discovery & Classification
1. **Repository Structure Analysis**:
   - Scan directory tree and identify project patterns
   - Detect project type (web app, API, CLI tool, library, etc.)
   - Identify primary and secondary programming languages
   - Map configuration files and deployment artifacts

2. **Technology Stack Detection**:
   - Parse package managers (package.json, requirements.txt, Cargo.toml, etc.)
   - Identify frameworks and major dependencies
   - Detect build tools and development environments
   - Assess deployment and infrastructure patterns

### Phase 2: Code Analysis (Depth-Dependent)
1. **Basic Level (--think)**:
   - File structure and naming conventions
   - Import/export analysis for module relationships
   - Basic function and class inventory
   - Configuration and environment setup

2. **Deep Level (--think-hard)**:
   - Code flow analysis and architecture patterns
   - Database interactions and data access patterns
   - API routes and endpoint documentation
   - Authentication and authorization mechanisms

3. **Advanced Level (--think-harder)**:
   - Business rule extraction from conditional logic
   - User journey mapping from controller/view code
   - Integration points and external service dependencies
   - Error handling strategies and failure modes

4. **Comprehensive Level (--ultrathink)**:
   - Domain modeling from entity relationships
   - Business process automation discovery
   - Performance optimization opportunities
   - Security posture and vulnerability assessment

### Phase 3: Context Extraction
1. **Business Logic Discovery**:
   - Extract business rules from code logic
   - Identify core value propositions
   - Map user roles and permission systems
   - Discover workflow automation

2. **Technical Architecture Mapping**:
   - Component relationship diagrams
   - Data flow documentation
   - Integration architecture
   - Deployment and scaling patterns

### Phase 4: PRD Generation
1. **Apply Output Style**: Use `prometh-prd-codebase-analysis` style specifically designed for repository initialization
2. **Generate Comprehensive PRDs**:
   - **Current State Assessment**: What exists and how it works
   - **Feature Gap Analysis**: What's missing or incomplete
   - **Technical Architecture**: How the system is structured
   - **Roadmap Recommendations**: Strategic next steps

3. **Create Documentation Structure**:
   ```
   docs/
   ├── prds/
   │   ├── current-state-analysis-prd.md
   │   ├── feature-gap-analysis-prd.md
   │   ├── technical-architecture-prd.md
   │   └── development-roadmap-prd.md
   ├── architecture/
   │   ├── system-overview.md
   │   └── component-diagram.md
   └── analysis/
       ├── codebase-inventory.md
       ├── technical-debt-assessment.md
       └── security-analysis.md
   ```

## Special Analysis Techniques

### Code Pattern Recognition
- **MVC Pattern Detection**: Controllers, models, views separation
- **API Design Patterns**: RESTful, GraphQL, RPC identification
- **Database Patterns**: ORM usage, migration systems, schema design
- **Authentication Patterns**: JWT, sessions, OAuth implementations

### Business Logic Extraction
- **Workflow Analysis**: State machines, business process automation
- **Rule Engines**: Conditional logic that represents business rules
- **Data Validation**: Business constraints and validation rules
- **User Experience Flows**: Multi-step processes and user journeys

### Integration Discovery
- **External APIs**: Third-party service integrations
- **Internal Services**: Microservice communication patterns
- **Data Sources**: Database connections, file systems, message queues
- **Deployment Dependencies**: Infrastructure requirements and scaling needs

## Implementation Instructions

### Pre-Analysis Setup
1. **Verify Repository Access**: Ensure full read access to codebase
2. **Create Documentation Structure**: Initialize docs/ directories if needed
3. **Backup Existing Docs**: Archive any existing documentation

### Analysis Execution
1. **Start with Discovery Phase**: Always run regardless of thinking level
2. **Apply Thinking Level Logic**: Execute appropriate depth analysis
3. **Extract and Correlate**: Gather information and identify patterns
4. **Generate Contextual PRDs**: Apply `prd-codebase-analysis` output style

### Post-Analysis Actions
1. **Validate Findings**: Cross-reference discoveries for accuracy
2. **Generate Multiple PRDs**: Create specialized PRDs for different aspects
3. **Create Index Document**: Summary of all generated documentation
4. **Archive Analysis Data**: Save raw analysis results for future reference

## Output Files Generated

### Core PRDs (Always Generated)
- `current-state-analysis-prd.md`: What currently exists
- `feature-inventory-prd.md`: Discovered functionality catalog
- `technical-architecture-prd.md`: System design and structure

### Depth-Dependent PRDs
**--think**: Basic assessment PRDs
**--think-hard**: + Security analysis, API documentation PRDs  
**--think-harder**: + User journey, integration analysis PRDs
**--ultrathink**: + Strategic roadmap, competitive analysis PRDs

## Arguments and Options

### Path Specification
- **Default**: Current working directory
- **Custom Path**: `/prometh-init --think /path/to/repository`
- **Relative Paths**: Supported with proper resolution

### Combination Examples
```bash
# Basic analysis of current directory
/prometh-init --think

# Deep analysis of specific project
/prometh-init --think-hard ./my-project

# Comprehensive analysis with full strategic assessment
/prometh-init --ultrathink /path/to/complex-enterprise-app

# Advanced analysis with custom output location
/prometh-init --think-harder ./legacy-app
```

## Success Criteria

### Minimum Viable Output (--think)
- At least 3 PRDs generated covering current state, features, and architecture
- Technology stack accurately identified
- Basic documentation structure created

### Comprehensive Output (--ultrathink)
- 8+ PRDs covering all aspects of the system
- Strategic recommendations for development priorities
- Complete technical documentation foundation
- Business context and competitive positioning analysis

## Risk Assessment and Mitigation

### Analysis Risks
- **Incomplete Code Coverage**: May miss functionality in complex codebases
- **Business Context Misinterpretation**: Code patterns might not reflect actual business intent
- **Security Information Exposure**: Avoid including sensitive data in PRDs

### Mitigation Strategies
- **Multiple Analysis Passes**: Cross-validate findings across different code sections
- **Conservative Assumptions**: Flag uncertain interpretations for human review
- **Sanitization Protocols**: Scrub sensitive information before PRD generation

Start analysis immediately upon command execution. Always begin with repository discovery regardless of thinking level, then proceed with depth-appropriate analysis techniques.