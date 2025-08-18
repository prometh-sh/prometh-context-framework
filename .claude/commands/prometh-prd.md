---
description: Create new PRD documents from scratch based on user descriptions for strategic product planning
allowed-tools: Write, LS, Glob, MultiEdit
---

# PRD Creation Command

You are tasked with creating new Product Requirements Documents (PRDs) from scratch in the `docs/prds/` directory based on detailed user descriptions of strategic product initiatives.

## Available Output Styles:
- **prometh-prd-standard**: For general strategic requirements and Epic-level planning
- **prometh-prd-feature**: For major feature development with market analysis
- **prometh-prd-bugfix**: For complex issues requiring strategic product decisions

## Processing Logic:

1. **Analyze User Description**: Classify the PRD type based on strategic scope:
   - **Strategic Planning**: Cross-functional initiatives, quarterly planning → `prometh-prd-standard`
   - **Major Features**: Market-driven features, competitive positioning → `prometh-prd-feature`
   - **Critical Issues**: Complex bugs requiring business analysis → `prometh-prd-bugfix`

2. **Determine Template**: Apply appropriate output style:
   - Default: Use `prometh-prd-standard` style for comprehensive strategic planning

3. **Create Directory**: Ensure `docs/prds/` directory exists

4. **Generate PRD**: Create new PRD using appropriate template with user description:
   ```
   Please create a new PRD using the '[style-name]' output style based on this strategic initiative:
   [user description content]
   ```

5. **Generate Filename**: Create descriptive filename from user description:
   - Extract 2-4 key strategic words
   - Use format: `[extracted-name]-prd.md`
   - Examples:
     - "Mobile app platform strategy" → `mobile-app-platform-strategy-prd.md`
     - "Customer onboarding experience redesign" → `customer-onboarding-experience-redesign-prd.md`

6. **Save PRD**: Write to `docs/prds/` with current date and comprehensive strategic content

## PRD Creation Examples:

### Strategic Feature Development:
```bash
/prometh-prd
User: "We need to develop a comprehensive mobile application that allows customers to manage their accounts, make payments, and access support. This should position us competitively against market leaders and support our Q2 growth targets."
```
- Uses: `prometh-prd-feature` style
- Filename: `mobile-customer-account-management-prd.md`
- Focus: Market analysis, competitive positioning, comprehensive feature specification

### Cross-Functional Initiative:
```bash
/prometh-prd
User: "Implement a customer data platform that unifies user information across all touchpoints, enables personalized marketing campaigns, and provides analytics for business intelligence."
```
- Uses: `prometh-prd-standard` style
- Filename: `customer-data-platform-prd.md`
- Focus: Strategic requirements, stakeholder alignment, business objectives

### Complex Issue Resolution:
```bash
/prometh-prd
User: "Address the scalability issues in our core payment processing system that are causing timeouts during peak hours and impacting revenue. This requires strategic product decisions about architecture redesign."
```
- Uses: `prometh-prd-bugfix` style
- Filename: `payment-processing-scalability-prd.md`
- Focus: Business impact analysis, systematic resolution approach, strategic planning

## Special Handling by PRD Type:

### Strategic Planning PRDs (prometh-prd-standard):
- Comprehensive business case and market analysis
- Cross-functional stakeholder alignment requirements
- Detailed technical architecture and implementation roadmap
- Success metrics and business impact measurement
- Resource allocation and timeline planning

### Major Feature PRDs (prometh-prd-feature):
- User value proposition and market opportunity analysis
- Competitive analysis and differentiation strategy
- Comprehensive user experience design and journey mapping
- Go-to-market strategy and adoption planning
- Feature rollout and success measurement

### Strategic Issue Resolution PRDs (prometh-prd-bugfix):
- Business impact analysis and priority justification
- Systematic problem analysis and solution approach
- Cross-team coordination and resource planning
- Risk assessment and mitigation strategies
- Success criteria and validation planning

## Instructions:

- Always prompt user for detailed strategic description if not provided
- Automatically classify PRD type based on content analysis (strategic vs. tactical)
- Generate meaningful filenames from user descriptions
- Add current date to document metadata
- Ensure `docs/prds/` directory exists before writing
- Focus on Epic-level strategic planning and cross-functional alignment
- Include comprehensive business case and market analysis
- Report successful PRD creation with file location and selected template

## Strategic Scope Validation:

- **Appropriate for PRDs**: Quarterly planning, market positioning, cross-functional initiatives, major feature launches, strategic technical decisions
- **Not appropriate for PRDs**: Simple feature additions, bug fixes, routine maintenance tasks (use SPEC framework instead)

## Error Handling:

- If user description is too tactical/implementation-focused, suggest using `/prometh-spec` instead
- If user description lacks strategic context, ask for business justification and market impact
- If `docs/prds/` cannot be created, report error and exit

## Example Usage:
```bash
/prometh-prd
```
Then provide strategic description when prompted, such as:
- "Launch a comprehensive B2B platform to capture the small business market segment with integrated payment processing, inventory management, and customer relationship tools"
- "Redesign our mobile experience to compete with industry leaders and support our expansion into the European market"
- "Implement AI-powered personalization across all customer touchpoints to increase engagement and retention rates"

Start by prompting the user for a detailed strategic description, then classify the initiative type, select appropriate template, and generate the comprehensive PRD document.