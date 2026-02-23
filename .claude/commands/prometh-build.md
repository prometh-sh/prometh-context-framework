---
description: Execute SPEC implementation with 3-phase workflow tracking and ${TRACKING_FILE} progress updates. Guides development through Planning, Task Breakdown, and Implementation phases.
argument-hint: "<spec-file-path>"
allowed-tools: ["Read", "Write", "Edit", "MultiEdit", "Glob", "Grep"]
---

# SPEC Implementation and Build Tracking Command

You are tasked with guiding the implementation of a specific SPEC document through its 3-phase workflow while maintaining comprehensive progress tracking in ${TRACKING_FILE}.

## Directory and Tracking File Resolution

**MANDATORY FIRST STEP**: Resolve the documentation directory and tracking file:

**Directory Resolution:**
```bash
# Check for documentation directories (local takes precedence)
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
# Check for tracking files (local takes precedence)
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

## Command Processing Logic

### Input Handling
1. **SPEC File Path Required**: Command requires a SPEC file path as argument
2. **File Validation**: Verify SPEC file exists and is readable
3. **Content Analysis**: Parse SPEC content and extract 3-phase workflow structure
4. **Current Status Check**: Determine current phase and completion status from ${TRACKING_FILE}

### Error Handling for Missing Arguments
If no SPEC file path provided, display:
```
❌ Missing SPEC File Path

Usage: /prometh-build <spec-file-path>

Examples:
• /prometh-build ${DOCS_DIR}/specs/user-authentication-spec.md
• /prometh-build ${DOCS_DIR}/specs/payment-integration-spec.md

Available SPECs:
[List available SPEC files from ${DOCS_DIR}/specs/ directory]
```

## 3-Phase Implementation Workflow

### Phase 1: Planning
**Objective**: Complete requirements analysis and technical design

**Workflow Process:**
1. **Present Planning Tasks**: Extract and display all Phase 1 tasks from SPEC
2. **Interactive Progress**: Allow user to mark individual tasks as completed
3. **Completion Validation**: Ensure all planning deliverables are ready
4. **Phase Transition**: Move to Task Breakdown when Phase 1 is complete

**Phase 1 Task Categories:**
- Requirements Clarification
- Technical Design
- Resource Planning
- Deliverables Creation

### Phase 2: Task Breakdown  
**Objective**: Create detailed development tasks with clear acceptance criteria

**Workflow Process:**
1. **Present Breakdown Tasks**: Extract and display all Phase 2 tasks from SPEC
2. **Task Refinement**: Help refine and detail development tasks
3. **Dependency Mapping**: Track task dependencies and priorities
4. **Risk Assessment**: Review and update risk mitigation strategies

**Phase 2 Task Categories:**
- Development Task Creation
- Dependency Mapping
- Risk Assessment
- Coordination Planning

### Phase 3: Implementation
**Objective**: Execute development tasks with quality assurance and validation

**Workflow Process:**
1. **Present Implementation Tasks**: Extract and display all Phase 3 tasks from SPEC
2. **Development Tracking**: Track core development progress
3. **Testing Progress**: Monitor integration and testing completion
4. **Deployment Readiness**: Validate deployment and acceptance criteria

**Phase 3 Task Categories:**
- Core Development
- Integration & Testing
- Deployment & Validation
- Documentation Updates

## ${TRACKING_FILE} Integration

### 1. SPEC Status Tracking

**Status Progression:**
- `Draft` → `Planning` → `Task Breakdown` → `Implementation` → `Testing` → `Completed`

**Status Update Format:**
```
| filename.md | Created Date | Type | Linked PRD | **[NEW STATUS]** | Description | [Updated Date] |
```

### 2. Phase Progress Tracking

**Add Phase Progress Section to ${TRACKING_FILE}:**
```markdown
## Implementation Progress

### Active SPECs in Development

#### [SPEC Name] - ${DOCS_DIR}/specs/filename.md
- **Current Phase**: [Planning/Task Breakdown/Implementation]
- **Phase Progress**: [X/Y tasks completed]
- **Started**: [Date]
- **Last Updated**: [Date]
- **Linked PRD**: [PRD filename if applicable]
- **Next Milestone**: [Next phase or completion target]

**Phase 1: Planning** ✅ Completed [Date]
- [x] Requirements Clarification
- [x] Technical Design  
- [x] Resource Planning
- [x] Deliverables Creation

**Phase 2: Task Breakdown** 🔄 In Progress (3/4 tasks completed)
- [x] Development Task Creation
- [x] Dependency Mapping
- [x] Risk Assessment
- [ ] Coordination Planning

**Phase 3: Implementation** ⏳ Pending
- [ ] Core Development
- [ ] Integration & Testing
- [ ] Deployment & Validation
- [ ] Documentation Updates
```

### 3. Recent Activity Updates

**Activity Entry Format:**
```
- **[Current Date]**: [SPEC filename] - Phase [N] [Started/Completed]: [Brief description]
- **[Current Date]**: [SPEC filename] - Status updated to [New Status]
- **[Current Date]**: [SPEC filename] - Implementation completed, linked to PRD [PRD filename]
```

## Interactive Workflow Interface

### Current Phase Display
```
🔥 Prometh Build: [SPEC Name]
📁 File: ${DOCS_DIR}/specs/filename.md
🔗 Linked PRD: [PRD name if applicable]
📊 Status: [Current Status]

════════════════════════════════════════
Phase [N]: [Phase Name] - [Status Icon] [Progress]
════════════════════════════════════════

Objective: [Phase objective from SPEC]

Tasks Progress: [X/Y completed]
┌─ [x] Task 1: Brief description
├─ [ ] Task 2: Brief description  
├─ [x] Task 3: Brief description
└─ [ ] Task 4: Brief description

Deliverables: [X/Y completed]
┌─ [x] Deliverable 1
├─ [ ] Deliverable 2
└─ [x] Deliverable 3

════════════════════════════════════════
💡 Available Actions:
• Mark task as completed
• View task details
• Update phase notes
• Move to next phase (when current complete)
• Exit build session
════════════════════════════════════════

What would you like to do next?
```

### Task Completion Interface
When user wants to mark a task completed:
```
✅ Task Marked Complete: [Task Name]

Updated Progress: Phase [N] ([X+1]/Y tasks completed)

[If phase complete]
🎉 Phase [N] Complete!
Ready to move to Phase [N+1]: [Next Phase Name]

Move to next phase? (y/n):
```

### Phase Transition Interface
```
🚀 Phase Transition: [Current Phase] → [Next Phase]

Phase [N] Summary:
✅ All tasks completed ([Date])
✅ All deliverables ready ([Date])
📝 Phase notes: [Any notes from implementation]

Starting Phase [N+1]: [Next Phase Name]
Objective: [Phase objective]
Estimated tasks: [Number of tasks]

Continue? (y/n):
```

## Command Examples

### Starting Implementation
```bash
/prometh-build ${DOCS_DIR}/specs/user-authentication-spec.md
# Displays current phase, progress, and available actions
# Updates ${TRACKING_FILE} with "In Progress" status
```

### Resuming Implementation
```bash
/prometh-build ${DOCS_DIR}/specs/user-authentication-spec.md
# Detects current phase from ${TRACKING_FILE}
# Shows progress and continues from last session
```

### Completing Implementation
```bash
/prometh-build ${DOCS_DIR}/specs/user-authentication-spec.md
# When all phases complete, marks SPEC as "Completed"
# Updates ${TRACKING_FILE} with completion date
# Links completion back to original PRD
```

## ${TRACKING_FILE} Update Process

### 1. Status Updates
**Implementation Steps:**
1. Read existing ${TRACKING_FILE}
2. Locate SPEC entry in inventory table
3. Update status column with current phase/status
4. Update last modified date
5. Add phase progress section if first time

### 2. Phase Progress Updates
**Implementation Steps:**
1. Locate or create Implementation Progress section
2. Update active SPEC progress details
3. Mark completed phases with ✅ and dates
4. Update current phase progress ([X/Y completed])
5. Add phase completion notes

### 3. Activity Log Updates
**Implementation Steps:**
1. Add phase transition entries
2. Add major milestone entries
3. Add completion entries with PRD traceability
4. Maintain chronological order

**Privacy Note**: When updating ${TRACKING_FILE}, ensure no private information is exposed:
- Use relative paths (${DOCS_DIR}/specs/filename.md) not absolute paths
- Never include user directories or private file paths
- Keep all content shareable with team members

## Success Completion Flow

### When SPEC Implementation Completes
```
🎉 SPEC Implementation Complete!

📋 SPEC: [SPEC name]
📁 File: ${DOCS_DIR}/specs/filename.md
🔗 Linked PRD: [PRD name if applicable]
📅 Started: [Start date]
📅 Completed: [Completion date]
⏱️  Duration: [Implementation duration]

✅ Phase 1: Planning - Completed [Date]
✅ Phase 2: Task Breakdown - Completed [Date] 
✅ Phase 3: Implementation - Completed [Date]

📊 Final Status: Completed
🔄 ${TRACKING_FILE} Updated: All tracking information synchronized

💡 What's Next:
• Generate project documentation: say "Generate a README for this project" (prometh-doc skill)
• View project status: /prometh-status
• Create related SPECs: say "Derive a SPEC from [PRD-file]" (prometh-spec skill)
• Review completed work in ${TRACKING_FILE}

Implementation session complete! 🚀
```

## Error Handling

### File Access Errors
- **SPEC not found**: List available SPECs and provide correct usage
- **SPEC not readable**: Report file permissions and suggest solutions
- **${TRACKING_FILE} locked**: Continue with session but warn about tracking updates

### Workflow Errors
- **Invalid phase transition**: Warn user about incomplete tasks
- **Corrupted SPEC format**: Report parsing issues and suggest manual review
- **${TRACKING_FILE} sync issues**: Report discrepancies and offer sync resolution

### Recovery Options
```
⚠️  Implementation Session Recovery

The build session encountered an error but your progress is saved.

Last successful update: [Timestamp]
Current phase: [Phase name]
Completed tasks: [Number]

Recovery options:
• Resume session: /prometh-build [same-spec-file]
• Check status: /prometh-status
• Manual review: Open ${TRACKING_FILE} for current state
```

## Instructions

1. **Always validate ${TRACKING_FILE} existence first** - Exit with error if not found
2. **Require SPEC file path argument** - Display usage help if missing
3. **Parse SPEC structure completely** - Extract all 3-phase tasks and deliverables
4. **Maintain interactive session** - Guide user through implementation phases
5. **Update tracking continuously** - Sync all progress to ${TRACKING_FILE}
6. **Provide clear status displays** - Show current phase, progress, and next steps
7. **Handle phase transitions** - Validate completion before allowing progression
8. **Link to PRD when applicable** - Maintain traceability from strategic to tactical
9. **Complete with summary** - Provide completion report and suggest next steps

## Output Format

After successful build session completion:
```
✅ SPEC Build Session Complete

File: ${DOCS_DIR}/specs/[filename].md
Status: [Final Status]
Implementation Duration: [Duration]
Phases Completed: 3/3
${TRACKING_FILE}: Updated with full progress tracking

The SPEC implementation has been successfully tracked and completed.

💡 Next Steps:
- Review implementation in ${TRACKING_FILE}
- Update related PRD status if applicable  
- Generate updated project documentation
- Plan next SPEC implementation

Build session ended successfully! 🚀
```

Start by validating ${TRACKING_FILE} existence, then verify the SPEC file path argument. Parse the SPEC structure, determine current implementation phase, and begin the interactive implementation tracking workflow.