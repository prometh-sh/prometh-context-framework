# Security Policy

## Supported Versions

We release patches for security vulnerabilities in the following versions:

| Version | Supported          |
| ------- | ------------------ |
| 1.0.x   | :white_check_mark: |
| < 1.0   | :x:                |

The `main` branch always contains the latest stable release.

## Reporting a Vulnerability

The Prometh Context Framework team takes security seriously. If you discover a security vulnerability, please follow these steps:

### For Security Issues

**DO NOT** open a public GitHub issue for security vulnerabilities.

Instead, please report security issues via one of these methods:

1. **Email**: Send details to **786743+ivannagy@users.noreply.github.com**
2. **GitHub Security Advisories**: Use the [Security Advisory](https://github.com/ivannagy/prometh-context-framework/security/advisories/new) feature

### What to Include

When reporting a vulnerability, please include:

- **Description**: Clear explanation of the vulnerability
- **Impact**: What could an attacker accomplish?
- **Reproduction Steps**: Detailed steps to reproduce the issue
- **Affected Versions**: Which versions are vulnerable?
- **Proposed Fix**: If you have suggestions (optional)
- **Your Contact Info**: So we can follow up with questions

### What to Expect

- **Acknowledgment**: We'll acknowledge receipt within 48 hours
- **Assessment**: We'll assess the severity and impact within 5 business days
- **Updates**: We'll keep you informed of progress
- **Credit**: We'll credit you in the security advisory (if you wish)
- **Timeline**: Critical issues will be addressed immediately; others within 30 days

## Security Considerations for Users

### General Best Practices

1. **Keep Updated**: Always use the latest version from the `main` branch
2. **Review Output**: Inspect generated documents before sharing
3. **Validate Inputs**: Be cautious when processing untrusted input files
4. **Local Settings**: Keep `.claude/settings.local.json` private (it's gitignored)

### File Handling

The framework processes various file formats (PDF, Markdown, text):

- **Trusted Sources Only**: Only process files from trusted sources
- **Review Content**: Always review generated output before committing
- **Sanitize Data**: The framework attempts to sanitize private information, but review is recommended

### Command Execution

All commands are designed to:

- Validate CLAUDE.md presence before execution
- Prevent accidental exposure of sensitive information
- Create files in designated directories only

### Known Limitations

- **No Input Validation**: User-provided content is not sanitized beyond basic formatting
- **File System Access**: Commands have write access to your file system
- **Shell Execution**: Setup script executes shell commands with user permissions

## Security Updates

Security updates will be:

- Released immediately for critical vulnerabilities
- Announced via GitHub Security Advisories
- Documented in CHANGELOG.md
- Tagged with version numbers

## Disclosure Policy

- **Private Disclosure**: Security issues are disclosed privately to maintainers
- **Public Disclosure**: Only after a fix is available or 90 days (whichever comes first)
- **Coordinated Release**: Fixes released with public disclosure when possible

## Additional Resources

- [GitHub Security](https://github.com/ivannagy/prometh-context-framework/security)
- [Code of Conduct](CODE_OF_CONDUCT.md)
- [Contributing Guidelines](CONTRIBUTING.md)

---

**Thank you for helping keep Prometh Context Framework secure!**
