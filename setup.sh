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
echo "  /prometh-prd [description]        - Create strategic PRDs from scratch"
echo "  /prometh-prd-normalize [filename] - Convert documents to standardized PRDs"
echo "  /prometh-spec [description]       - Create implementation SPECs from scratch"
echo "  /prometh-spec-normalize [filename]- Convert documents to standardized SPECs"
echo "  /prometh-document [type]          - Generate technical documentation"
echo
echo -e "${BLUE}Available output styles:${NC}"
echo "  PRD Styles (Strategic):"
echo "    prometh-prd-standard         - General strategic requirements and Epic-level planning"
echo "    prometh-prd-bugfix           - Complex issues requiring strategic product decisions"
echo "    prometh-prd-feature          - Major feature development with market analysis"
echo "  SPEC Styles (Implementation):"
echo "    prometh-spec-feature         - New feature implementation (user stories)"
echo "    prometh-spec-bugfix          - Bug fixes and defects"
echo "    prometh-spec-enhancement     - Improvements to existing features"
echo "    prometh-spec-task            - Technical/maintenance tasks"
echo "  Documentation Styles:"
echo "    prometh-readme-standard      - Comprehensive README.md for general repos"
echo "    prometh-readme-api           - API/library documentation with examples"
echo "    prometh-readme-cli           - CLI tool documentation with installation guides"
echo "    prometh-technical-documentation - Technical documentation for DevOps workflows"
echo
echo -e "${BLUE}Usage:${NC}"
echo "  Strategic Planning (PRDs):"
echo "    Create from scratch: /prometh-prd [epic description]"
echo "    Normalize documents: /prometh-prd-normalize [filename]"
echo "    Output location: docs/prds/"
echo
echo "  Implementation Planning (SPECs):"
echo "    Create from scratch: /prometh-spec [task description]"
echo "    Normalize documents: /prometh-spec-normalize [filename]"
echo "    Output location: docs/specs/"
echo
echo "  Documentation Generation:"
echo "    Generate README: /prometh-document readme"
echo "    Other docs: /prometh-document [runbook|architecture|api|etc.]"
echo "    Auto-detects project type for appropriate templates"
echo
echo -e "${GREEN}Ready to ignite high-quality, predictable output! 🔥${NC}"