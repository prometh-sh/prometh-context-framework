# Contributing to Prometh Context Framework

Thank you for your interest in contributing to the Prometh Context Framework! This document provides guidelines for contributing to the project.

## Getting Started

### Prerequisites
- Git for version control
- Claude Code CLI (optional, for testing commands)
- Basic knowledge of Markdown and Bash scripting
- Familiarity with Claude Code slash commands

### Setup

1. **Fork the repository**
   ```bash
   git clone https://github.com/ivannagy/prometh-context-framework.git
   cd prometh-context-framework
   ```

2. **Test the setup script**
   ```bash
   ./setup.sh
   ```

3. **Verify installation**
   ```bash
   ls ~/.claude/commands/prometh-*
   ls ~/.claude/output-styles/prometh-*
   ```

## How to Contribute

### Reporting Issues

- Use GitHub Issues to report bugs or request features
- Check existing issues before creating a new one
- Provide clear descriptions with steps to reproduce
- Include relevant command outputs and error messages

### Submitting Changes

1. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

2. **Make your changes**
   - Follow the unified command structure in `.claude/commands/`
   - Update output styles in `.claude/output-styles/` if needed
   - Maintain consistency with existing templates

3. **Test your changes**
   - Run the setup script to verify installation
   - Test commands in Claude Code if applicable
   - Ensure backward compatibility

4. **Update documentation**
   - Update README.md for new features
   - Add entries to CHANGELOG.md
   - Update CLAUDE.md if command behavior changes

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add: Brief description of your changes"
   ```

6. **Push and create Pull Request**
   ```bash
   git push origin feature/your-feature-name
   ```
   - Open a Pull Request on GitHub
   - Provide a clear description of changes
   - Reference any related issues

## Development Guidelines

### Command Structure

When creating or modifying commands in `.claude/commands/`:

- Use clear, descriptive frontmatter (description, allowed-tools)
- Follow the established pattern of existing commands
- Include comprehensive error handling
- Provide helpful user guidance and examples
- Validate CLAUDE.md presence where required

### Output Style Templates

When working with templates in `.claude/output-styles/`:

- Maintain consistency with unified template approach
- Use clear section headers and structure
- Include placeholders for dynamic content
- Follow professional documentation standards
- Test templates with various input scenarios

### Coding Style

- **Clarity**: Write clear, self-documenting code
- **Consistency**: Follow existing patterns and conventions
- **Comments**: Add comments for complex logic
- **Markdown**: Use proper formatting in all .md files
- **Bash**: Follow shell scripting best practices in setup.sh

### Testing

Before submitting a PR:

- Test the setup script on a clean environment
- Verify all commands work as expected
- Check that documentation is accurate
- Ensure no sensitive information is included
- Validate all markdown links and references

## Pull Request Process

1. **Update documentation** - Ensure README.md and CHANGELOG.md reflect your changes
2. **Maintain quality** - Follow coding style and testing guidelines
3. **Clear description** - Explain what changes were made and why
4. **Review feedback** - Be responsive to review comments
5. **Backward compatibility** - Ensure existing functionality remains intact

## Areas for Contribution

We welcome contributions in these areas:

### Commands & Features
- New command templates for additional workflows
- Enhancements to existing commands
- Additional output style templates
- Improved error handling and validation

### Documentation
- Improved README.md sections
- Additional usage examples
- Video tutorials or demos
- Translations (if applicable)

### Quality Improvements
- Bug fixes and error corrections
- Performance optimizations
- Code refactoring for clarity
- Enhanced user experience

### Testing & CI/CD
- Automated testing scripts
- CI/CD pipeline setup
- Installation verification tests
- Cross-platform compatibility checks

## Release Notes

When contributing features or behavior changes:

1. Update `CHANGELOG.md` with your changes
2. Follow the [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
3. Place changes in the `[Unreleased]` section
4. Use categories: Added, Changed, Deprecated, Removed, Fixed, Security

## Questions?

- Open a GitHub Issue for general questions
- Check existing documentation in README.md and CLAUDE.md
- Review SECURITY.md for security-related questions

## Code of Conduct

This project adheres to the Contributor Covenant Code of Conduct. By participating, you are expected to uphold this code. See [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for details.

## License

By contributing to Prometh Context Framework, you agree that your contributions will be licensed under the Apache License 2.0.

---

Thank you for helping make the Prometh Context Framework better!
