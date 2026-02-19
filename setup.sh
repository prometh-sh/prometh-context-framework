#!/bin/bash

# Prometh Context Framework Setup Script
# Safely installs Claude Code and/or OpenCode commands with multi-platform support

set -e  # Exit on any error

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get repository directory
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Platform directories
CLAUDE_DIR="$HOME/.claude"
OPENCODE_DIR="$HOME/.config/opencode"

# Display banner
echo "🔥 Prometh Context Framework Setup"
echo "=================================="
echo

# Initialize platform flags
INSTALL_CLAUDE=false
INSTALL_OPENCODE=false

# Function to display help
show_help() {
    cat << EOF
Usage: ./setup.sh [OPTIONS]

OPTIONS:
  --claude              Install Claude Code commands only
  --opencode            Install OpenCode commands only
  --all                 Install for both Claude Code and OpenCode
  (no args)            Interactive mode - prompts for platform selection
  -h, --help           Show this help message

EXAMPLES:
  ./setup.sh                    # Interactive - choose platform
  ./setup.sh --claude           # Install for Claude Code only
  ./setup.sh --opencode         # Install for OpenCode only
  ./setup.sh --all              # Install for both platforms

EOF
}

# Function to parse command line arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --claude)
                INSTALL_CLAUDE=true
                shift
                ;;
            --opencode)
                INSTALL_OPENCODE=true
                shift
                ;;
            --all)
                INSTALL_CLAUDE=true
                INSTALL_OPENCODE=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                echo "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
}

# Function to display interactive platform selection menu
select_platform() {
    echo -e "${BLUE}Select Installation Target${NC}"
    echo "============================"
    echo
    echo "1) Claude Code only"
    echo "2) OpenCode only"
    echo "3) Both platforms"
    echo
    read -p "Enter choice (1-3): " choice
    echo

    case $choice in
        1)
            INSTALL_CLAUDE=true
            INSTALL_OPENCODE=false
            ;;
        2)
            INSTALL_CLAUDE=false
            INSTALL_OPENCODE=true
            ;;
        3)
            INSTALL_CLAUDE=true
            INSTALL_OPENCODE=true
            ;;
        *)
            echo -e "${YELLOW}Invalid choice. Please enter 1, 2, or 3.${NC}"
            select_platform
            ;;
    esac
}

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

# Function to install Claude Code components
install_claude() {
    echo
    echo -e "${YELLOW}Installing Claude Code components...${NC}"
    echo "===================================="

    # Create Claude directories
    mkdir -p "$CLAUDE_DIR/commands"
    mkdir -p "$CLAUDE_DIR/output-styles"

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
}

# Function to install OpenCode skills
install_opencode_skills() {
    echo
    echo -e "${YELLOW}Installing skills...${NC}"
    if [ -d "$REPO_DIR/.opencode/skills" ]; then
        for skill_dir in "$REPO_DIR/.opencode/skills"/*/; do
            if [ -d "$skill_dir" ]; then
                skill_name=$(basename "$skill_dir")
                mkdir -p "$OPENCODE_DIR/skills/$skill_name"
                local skill_file="$skill_dir/SKILL.md"
                if [ -f "$skill_file" ]; then
                    local dest="$OPENCODE_DIR/skills/$skill_name/SKILL.md"
                    if [ -f "$dest" ]; then
                        echo -e "  ${YELLOW}⚠️  Skill already exists:${NC} $skill_name/SKILL.md"
                        read -p "  Overwrite? (y/N): " -n 1 -r
                        echo
                        if [[ $REPLY =~ ^[Yy]$ ]]; then
                            cp "$skill_file" "$dest"
                            echo -e "  ${GREEN}✅ Replaced:${NC} $skill_name/SKILL.md"
                        else
                            echo -e "  ${BLUE}⏭️  Skipped:${NC} $skill_name/SKILL.md"
                        fi
                    else
                        cp "$skill_file" "$dest"
                        echo -e "  ${GREEN}✅ Installed:${NC} $skill_name/SKILL.md"
                    fi
                fi
            fi
        done
    else
        echo -e "  ${YELLOW}⚠️  No .opencode/skills directory found in repository${NC}"
    fi
}

# Function to install OpenCode components
install_opencode() {
    echo
    echo -e "${YELLOW}Installing OpenCode components...${NC}"
    echo "=================================="

    # Create OpenCode directories
    mkdir -p "$OPENCODE_DIR/commands"
    mkdir -p "$OPENCODE_DIR/skills"

    echo -e "${YELLOW}Installing commands...${NC}"
    if [ -d "$REPO_DIR/.opencode/commands" ]; then
        for cmd_file in "$REPO_DIR/.opencode/commands"/*.md; do
            if [ -f "$cmd_file" ]; then
                cmd_name=$(basename "$cmd_file")
                safe_copy "$cmd_file" "$OPENCODE_DIR/commands/$cmd_name" "Command"
            fi
        done
    else
        echo -e "  ${YELLOW}⚠️  No .opencode/commands directory found in repository${NC}"
    fi

    install_opencode_skills
}

# Function to verify installations
verify_installations() {
    echo
    echo -e "${YELLOW}Verification:${NC}"
    echo "=============="

    if [ "$INSTALL_CLAUDE" = true ]; then
        echo -e "${BLUE}Claude Code:${NC}"
        echo -e "  Commands: ${CLAUDE_DIR}/commands/"
        ls -la "$CLAUDE_DIR/commands/" 2>/dev/null | grep -E "\.md$" | awk '{print "    ✓ " $9}' || echo "    (none found)"

        echo -e "  Output Styles: ${CLAUDE_DIR}/output-styles/"
        ls -la "$CLAUDE_DIR/output-styles/" 2>/dev/null | grep -E "\.md$" | awk '{print "    ✓ " $9}' || echo "    (none found)"
    fi

    if [ "$INSTALL_OPENCODE" = true ]; then
        echo
        echo -e "${BLUE}OpenCode:${NC}"
        echo -e "  Commands: ${OPENCODE_DIR}/commands/"
        ls -la "$OPENCODE_DIR/commands/" 2>/dev/null | grep -E "\.md$" | awk '{print "    ✓ " $9}' || echo "    (none found)"

        echo -e "  Skills: ${OPENCODE_DIR}/skills/"
        for skill_dir in "$OPENCODE_DIR/skills"/*/; do
            if [ -f "${skill_dir}SKILL.md" ]; then
                echo "    ✓ $(basename "$skill_dir")/SKILL.md"
            fi
        done
    fi
}

# Function to display completion message
show_completion() {
    echo
    echo -e "${GREEN}🎉 Setup complete!${NC}"
    echo
    echo -e "${BLUE}Available Commands (Claude Code & OpenCode):${NC}"
    echo "  /prometh-init      - Initialize framework in any project"
    echo "  /prometh-build     - Execute SPEC with guided implementation"
    echo "  /prometh-status    - Display project documentation dashboard"
    echo "  /prometh-help      - Display comprehensive command reference"
    echo
    echo -e "${BLUE}Available Skills (OpenCode) / Commands (Claude Code):${NC}"
    echo "  prometh-prd        - Create or normalize strategic PRDs"
    echo "  prometh-spec       - Create or normalize implementation SPECs"
    echo "  prometh-doc        - Generate technical documentation"
    echo
    echo -e "${BLUE}Getting Started:${NC}"
    echo "1. Navigate to your project directory"
    echo "2. Run '/prometh-init' to set up Prometh framework"
    echo "3. Create strategic PRDs with '/prometh-prd' (Claude Code) or prometh-prd skill (OpenCode)"
    echo "4. Generate implementation SPECs with '/prometh-spec'"
    echo "5. Execute SPECs with '/prometh-build'"
    echo "6. Monitor progress with '/prometh-status'"
    echo
    echo -e "${GREEN}Ready to ignite high-quality, predictable output! 🔥${NC}"
}

# Main execution
main() {
    # Parse arguments or show interactive menu
    if [[ $# -gt 0 ]]; then
        parse_args "$@"
    else
        # Interactive mode
        select_platform
    fi

    # Validate that at least one platform was selected
    if [ "$INSTALL_CLAUDE" = false ] && [ "$INSTALL_OPENCODE" = false ]; then
        echo -e "${YELLOW}No platform selected for installation.${NC}"
        exit 1
    fi

    # Install selected platforms
    if [ "$INSTALL_CLAUDE" = true ]; then
        install_claude
    fi

    if [ "$INSTALL_OPENCODE" = true ]; then
        install_opencode
    fi

    # Verify installations
    verify_installations

    # Show completion message
    show_completion
}

# Run main function with all arguments
main "$@"