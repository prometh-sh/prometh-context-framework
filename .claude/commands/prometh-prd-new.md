---
description: Create new PRD documents in docs/prds with templates based on project scope and development phase
allowed-tools: Write, LS, Glob, MultiEdit
---

# PRD Creation Command

You are tasked with creating new Product Requirements Documents (PRDs) from scratch in the `docs/prds/` directory using specialized templates based on project scope and development phase.

## Available Options:

### Required Parameters:
- **--name**: Name of the new PRD (used for filename and document title)

### Optional Parameters:
- **--scope**: Documentation scope (default: full-stack)
  - `service`: Single service or microservice development
  - `environment`: Infrastructure, deployment, or environment setup
  - `full-stack`: Complete application or comprehensive feature set

- **--feature**: Use when adding to existing application (lighter template)
- **--from-scratch**: Use when creating entirely new application (comprehensive template)

## Available Output Styles:
- **prometh-prd-new-feature**: For feature additions to existing applications
- **prometh-prd-new-fromscratch**: For new applications or comprehensive rewrites
- **prometh-prd-new-service**: For microservice or service-specific PRDs
- **prometh-prd-new-environment**: For infrastructure and deployment PRDs

## Processing Logic:

1. **Parse Arguments**: Extract name, scope, and development phase from `$ARGUMENTS`

2. **Determine Template**: Based on parameters:
   - If `--feature` specified → Use `prometh-prd-new-feature` style
   - If `--from-scratch` specified → Use `prometh-prd-new-fromscratch` style
   - If scope is `service` → Use `prometh-prd-new-service` style
   - If scope is `environment` → Use `prometh-prd-new-environment` style
   - Default: Use `prometh-prd-new-fromscratch` style

3. **Create Directory**: Ensure `docs/prds/` directory exists

4. **Generate PRD**: Create new PRD using appropriate template with:
   ```
   Please create a new PRD using the '[style-name]' output style with the following parameters:
   - Project Name: [name]
   - Scope: [scope]
   - Development Phase: [feature/from-scratch]
   ```

5. **Generate Filename**: Create descriptive filename:
   - Feature PRDs: `feature-[name]-prd.md`
   - Service PRDs: `service-[name]-prd.md`  
   - Environment PRDs: `environment-[name]-prd.md`
   - From-scratch PRDs: `[name]-prd.md`

6. **Save PRD**: Write to `docs/prds/` with current date and placeholder content

## Template Selection Examples:

### Feature Addition (--feature):
```bash
/prometh-prd-new --name user-profile-enhancements --feature --scope full-stack
```
- Uses: `prometh-prd-new-feature` style
- Filename: `feature-user-profile-enhancements-prd.md`
- Focus: Lighter documentation, assumes existing architecture

### New Application (--from-scratch):
```bash
/prometh-prd-new --name inventory-management-system --from-scratch --scope full-stack
```
- Uses: `prometh-prd-new-fromscratch` style  
- Filename: `inventory-management-system-prd.md`
- Focus: Comprehensive documentation, full architecture specification

### Service-Specific:
```bash
/prometh-prd-new --name payment-processing --scope service --from-scratch
```
- Uses: `prometh-prd-new-service` style
- Filename: `service-payment-processing-prd.md`
- Focus: Service architecture, APIs, data models

### Environment/Infrastructure:
```bash
/prometh-prd-new --name production-deployment --scope environment
```
- Uses: `prometh-prd-new-environment` style
- Filename: `environment-production-deployment-prd.md`
- Focus: Infrastructure, deployment, monitoring, security

## Special Handling by Template Type:

### Feature Template (--feature):
- Assumes existing application architecture
- Focuses on incremental improvements and user value
- Lighter technical specifications (references existing systems)
- Emphasis on integration with current features
- Shorter development timelines and scoped impact

### From-Scratch Template (--from-scratch):
- Complete application specification required
- Comprehensive technical architecture documentation
- Full user experience design and journey mapping
- Complete business case and market analysis
- Detailed implementation roadmap and phases

### Service Template (scope: service):
- Service-specific architecture and design patterns
- API contracts and data models
- Service dependencies and integration points
- Scalability and performance requirements
- Service monitoring and operational concerns

### Environment Template (scope: environment):
- Infrastructure requirements and specifications
- Deployment pipelines and automation
- Security and compliance requirements
- Monitoring, logging, and alerting setup
- Disaster recovery and business continuity

## Instructions:

- Always specify which output style is being used
- Generate meaningful, descriptive filenames with proper prefixes
- Add current date to document metadata
- Ensure `docs/prds/` directory exists before writing
- Report successful PRD creation with file location
- Validate that all required parameters are provided
- Use appropriate template based on scope and phase

## Error Handling:

- If `--name` is missing, prompt user for required name parameter
- If conflicting options (both `--feature` and `--from-scratch`), default to `--from-scratch`
- If invalid scope provided, default to `full-stack`
- If `docs/prds/` cannot be created, report error and exit

## Example Usage:
```bash
/prometh-prd-new --name mobile-app-redesign --feature --scope full-stack
/prometh-prd-new --name api-gateway --from-scratch --scope service  
/prometh-prd-new --name kubernetes-migration --scope environment
/prometh-prd-new --name customer-portal --from-scratch
```

Start by parsing the provided arguments, determining the appropriate template, creating the directory if needed, and generating the new PRD with the selected output style.