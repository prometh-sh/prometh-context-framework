#!/bin/bash

# Prometh Context Framework Setup Script
# Safely installs Claude Code commands and output styles without overwriting existing configs

set -e  # Exit on any error

echo "🔥 Prometh Context Framework Setup"
echo "Installing Claude Code commands and output styles..."
echo

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get user's home directory
CLAUDE_DIR="$HOME/.claude"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Repository:${NC} $REPO_DIR"
echo -e "${BLUE}Claude Config:${NC} $CLAUDE_DIR"
echo

# Create Claude directories if they don't exist
echo -e "${YELLOW}Creating Claude directories...${NC}"
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/output-styles"

# Function to safely copy files
safe_copy() {
    local src="$1"
    local dest="$2"
    local type="$3"
    
    if [ -f "$dest" ]; then
        echo -e "  ${YELLOW}⚠️  $type already exists:${NC} $(basename "$dest")"
        read -p "  Overwrite? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            cp "$src" "$dest"
            echo -e "  ${GREEN}✅ Replaced:${NC} $(basename "$dest")"
        else
            echo -e "  ${BLUE}⏭️  Skipped:${NC} $(basename "$dest")"
        fi
    else
        cp "$src" "$dest"
        echo -e "  ${GREEN}✅ Installed:${NC} $(basename "$dest")"
    fi
}

# Install commands
echo -e "${YELLOW}Installing commands...${NC}"
if [ -d "$REPO_DIR/.claude/commands" ]; then
    for cmd_file in "$REPO_DIR/.claude/commands"/*.md; do
        if [ -f "$cmd_file" ]; then
            cmd_name=$(basename "$cmd_file")
            safe_copy "$cmd_file" "$CLAUDE_DIR/commands/$cmd_name" "Command"
        fi
    done
else
    echo -e "  ${YELLOW}⚠️  No commands directory found in repository${NC}"
fi

echo

# Install output styles
echo -e "${YELLOW}Installing output styles...${NC}"
if [ -d "$REPO_DIR/.claude/output-styles" ]; then
    for style_file in "$REPO_DIR/.claude/output-styles"/*.md; do
        if [ -f "$style_file" ]; then
            style_name=$(basename "$style_file")
            safe_copy "$style_file" "$CLAUDE_DIR/output-styles/$style_name" "Output style"
        fi
    done
else
    echo -e "  ${YELLOW}⚠️  No output-styles directory found in repository${NC}"
fi

echo

# Verify installation
echo -e "${YELLOW}Verification:${NC}"
echo -e "Commands installed in: ${BLUE}$CLAUDE_DIR/commands/${NC}"
ls -la "$CLAUDE_DIR/commands/" 2>/dev/null | grep -E "\.md$" | awk '{print "  - " $9}' || echo "  (none found)"

echo -e "Output styles installed in: ${BLUE}$CLAUDE_DIR/output-styles/${NC}"
ls -la "$CLAUDE_DIR/output-styles/" 2>/dev/null | grep -E "\.md$" | awk '{print "  - " $9}' || echo "  (none found)"

echo
echo -e "${GREEN}🎉 Setup complete!${NC}"
echo
echo -e "${BLUE}Available commands:${NC}"
echo "  /prometh-init                        - Initialize framework in any project"
echo "  /prometh-prd [description|filename]  - Create or normalize strategic PRDs"
echo "  /prometh-spec [description|filename] - Create or normalize implementation SPECs" 
echo "  /prometh-doc [readme|runbook]        - Generate technical documentation"
echo "  /prometh-status                      - Display project documentation status dashboard"
echo
echo -e "${BLUE}Available output styles:${NC}"
echo "  Strategic Documentation:"
echo "    prometh-prd                    - Unified PRD template for all strategic scenarios"
echo "  Implementation Documentation:"
echo "    prometh-spec                   - Unified SPEC template with 3-phase workflow"
echo "  Technical Documentation:"
echo "    prometh-doc-readme             - Unified README template for project documentation"
echo "    prometh-doc-runbook            - Specialized runbook template for operations"
echo
echo -e "${BLUE}Key Features:${NC}"
echo "  ✅ Project Initialization - /prometh-init sets up tracking and directory structure"
echo "  ✅ Status Dashboard - /prometh-status shows comprehensive project documentation overview"
echo "  ✅ Document Tracking - PROMETH.md tracks all documents and provides traceability"
echo "  ✅ Unified Templates - Single template per command type for consistency"
echo "  ✅ Smart Classification - Automatic PRD vs SPEC detection"  
echo "  ✅ 3-Phase Workflow - SPECs include structured implementation phases"
echo "  ✅ File & Text Input - Commands handle both file paths and direct text input"
echo
echo -e "${BLUE}Usage Examples:${NC}"
echo "  Strategic Planning (PRDs):"
echo "    Interactive: /prometh-prd"
echo "    From file: /prometh-prd strategic-plan.pdf" 
echo "    Output: docs/prds/[name]-prd.md"
echo
echo "  Implementation Planning (SPECs):"
echo "    Interactive: /prometh-spec"
echo "    From file: /prometh-spec user-story.md"
echo "    Output: docs/specs/[type]-[name]-spec.md"
echo
echo "  Documentation Generation:"
echo "    README: /prometh-doc readme"
echo "    Runbook: /prometh-doc runbook"
echo "    Output: Current directory or specified path"
echo
echo "  Status Dashboard:"
echo "    Overview: /prometh-status"
echo "    Brief: /prometh-status --brief"
echo "    Health check: /prometh-status --health"
echo
echo -e "${YELLOW}Getting Started:${NC}"
echo "1. Navigate to your project directory"
echo "2. Run '/prometh-init' to set up Prometh framework"
echo "3. Start creating PRDs and SPECs with full tracking support!"
echo "4. Use '/prometh-status' to monitor your documentation progress"
echo
echo -e "${GREEN}Ready to ignite high-quality, predictable output! 🔥${NC}"