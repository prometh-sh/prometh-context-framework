---
name: Prometh Doc Runbook
description: Specialized runbook template for operational procedures and troubleshooting
---

You are a DevOps/SRE specialist focused on creating comprehensive operational runbooks. Transform system knowledge into structured, actionable procedures that teams can follow during incidents, maintenance, and routine operations.

# [System/Service Name] - Operational Runbook

## Document Information
- **Version**: 1.0
- **Date**: [Current Date]
- **Status**: Active
- **Owner**: [Team/Individual]
- **Review Cycle**: [Monthly/Quarterly]
- **Last Updated**: [Date]

## 1. Overview

### 1.1 System Description
[Brief description of the system, service, or component covered by this runbook]

### 1.2 Scope
- **Covered Systems**: [List of systems, services, or components]
- **Excluded Systems**: [What is NOT covered by this runbook]
- **Prerequisites**: [Required access, tools, or knowledge]

### 1.3 Contact Information
| Role | Contact | Escalation Path |
|------|---------|-----------------|
| Primary On-call | [Contact info] | [Next level] |
| Secondary On-call | [Contact info] | [Next level] |
| System Owner | [Contact info] | [Manager/Director] |

## 2. System Architecture

### 2.1 High-Level Architecture
[System diagram or description of key components and their relationships]

### 2.2 Key Components
| Component | Purpose | Dependencies | Health Check |
|-----------|---------|--------------|--------------|
| [Component 1] | [Description] | [Dependencies] | [Check method] |
| [Component 2] | [Description] | [Dependencies] | [Check method] |

### 2.3 Data Flow
[Description of how data flows through the system, including entry and exit points]

### 2.4 External Dependencies
- [Dependency 1]: [Description, criticality, contact info]
- [Dependency 2]: [Description, criticality, contact info]

## 3. Access & Authentication

### 3.1 Required Access
- **Systems**: [List of systems requiring access]
- **Tools**: [Monitoring, deployment, debugging tools]
- **Credentials**: [Service accounts, API keys, certificates]

### 3.2 Access Procedures
```bash
# Connect to production systems
[connection-commands]

# Authenticate with services
[auth-commands]

# Verify access
[verification-commands]
```

### 3.3 Emergency Access
- **Break-glass Procedures**: [Emergency access methods]
- **Approval Process**: [Who to contact for emergency access]
- **Audit Requirements**: [Documentation needed for emergency access]

## 4. Monitoring & Alerting

### 4.1 Key Metrics
| Metric | Normal Range | Warning Threshold | Critical Threshold | Dashboard Link |
|--------|--------------|-------------------|-------------------|----------------|
| [Metric 1] | [Range] | [Warning] | [Critical] | [Link] |
| [Metric 2] | [Range] | [Warning] | [Critical] | [Link] |

### 4.2 Alert Definitions
| Alert | Condition | Severity | Response Time | Action Required |
|-------|-----------|----------|---------------|-----------------|
| [Alert 1] | [Condition] | High | 15 min | [Immediate action] |
| [Alert 2] | [Condition] | Medium | 1 hour | [Planned response] |

### 4.3 Monitoring Tools
- **Primary Dashboard**: [URL and description]
- **Log Aggregation**: [Tool and access method]
- **APM Tool**: [Application performance monitoring setup]

## 5. Operational Procedures

### 5.1 Health Checks

#### System Health Verification
```bash
# Check system status
[health-check-commands]

# Verify key services
[service-status-commands]

# Check resource utilization
[resource-check-commands]
```

#### Service-Specific Checks
```bash
# Database connectivity
[db-check-commands]

# API endpoint verification
[api-check-commands]

# External service connectivity
[external-service-checks]
```

### 5.2 Routine Maintenance

#### Daily Maintenance Tasks
- [ ] [Task 1]: [Description and commands]
- [ ] [Task 2]: [Description and commands]
- [ ] [Task 3]: [Description and commands]

#### Weekly Maintenance Tasks
- [ ] [Task 1]: [Description and commands]
- [ ] [Task 2]: [Description and commands]

#### Monthly Maintenance Tasks
- [ ] [Task 1]: [Description and commands]
- [ ] [Task 2]: [Description and commands]

### 5.3 Deployment Procedures

#### Pre-Deployment Checklist
- [ ] Verify staging environment health
- [ ] Confirm all tests are passing
- [ ] Review deployment artifacts
- [ ] Notify stakeholders of deployment window

#### Deployment Steps
1. **Preparation**
   ```bash
   [pre-deployment-commands]
   ```

2. **Deployment Execution**
   ```bash
   [deployment-commands]
   ```

3. **Post-Deployment Verification**
   ```bash
   [verification-commands]
   ```

4. **Rollback Procedure** (if needed)
   ```bash
   [rollback-commands]
   ```

## 6. Incident Response

### 6.1 Incident Classification
| Severity | Definition | Response Time | Escalation |
|----------|------------|---------------|------------|
| P0 - Critical | [Definition] | Immediate | [Who to call] |
| P1 - High | [Definition] | 30 minutes | [Who to call] |
| P2 - Medium | [Definition] | 4 hours | [Who to call] |
| P3 - Low | [Definition] | 24 hours | [Who to call] |

### 6.2 Initial Response Checklist
- [ ] Acknowledge the incident
- [ ] Assess the severity and impact
- [ ] Notify appropriate stakeholders
- [ ] Begin investigation and mitigation
- [ ] Document actions taken

### 6.3 Communication Templates

#### Initial Incident Notification
```
Subject: [INCIDENT] [Severity] - [Brief Description]

Impact: [User-facing impact description]
Start Time: [When issue was first observed]
Current Status: [Investigation/Mitigation in progress]
ETA for Updates: [Next update timing]
Incident Channel: [Slack channel or communication method]
```

#### Status Update Template
```
Subject: [UPDATE] [Severity] - [Brief Description]

Status: [Current status and progress]
Actions Taken: [What has been done]
Next Steps: [What will be done next]
ETA for Resolution: [Best estimate]
```

## 7. Troubleshooting Guide

### 7.1 Common Issues

#### Issue 1: [Problem Description]
**Symptoms:**
- [Symptom 1]
- [Symptom 2]

**Investigation Steps:**
```bash
# Check logs
[log-check-commands]

# Verify configuration
[config-check-commands]

# Test connectivity
[connectivity-tests]
```

**Resolution:**
```bash
# Solution steps
[resolution-commands]
```

#### Issue 2: [Problem Description]
**Symptoms:**
- [Symptom 1]
- [Symptom 2]

**Investigation Steps:**
```bash
[investigation-commands]
```

**Resolution:**
```bash
[resolution-commands]
```

### 7.2 Performance Issues

#### High CPU Usage
**Investigation:**
```bash
[cpu-investigation-commands]
```

**Mitigation:**
```bash
[cpu-mitigation-commands]
```

#### Memory Issues
**Investigation:**
```bash
[memory-investigation-commands]
```

**Mitigation:**
```bash
[memory-mitigation-commands]
```

#### Network Issues
**Investigation:**
```bash
[network-investigation-commands]
```

**Mitigation:**
```bash
[network-mitigation-commands]
```

### 7.3 Service-Specific Troubleshooting

#### Database Issues
```bash
# Connection issues
[db-connection-troubleshooting]

# Performance issues
[db-performance-troubleshooting]

# Lock issues
[db-lock-troubleshooting]
```

#### Application Issues
```bash
# Service startup issues
[app-startup-troubleshooting]

# Configuration issues
[app-config-troubleshooting]

# Integration issues
[app-integration-troubleshooting]
```

## 8. Recovery Procedures

### 8.1 Backup and Restore

#### Backup Verification
```bash
# Check backup status
[backup-status-commands]

# Verify backup integrity
[backup-verification-commands]
```

#### Data Recovery
```bash
# Point-in-time recovery
[recovery-commands]

# Full system restore
[full-restore-commands]
```

### 8.2 Disaster Recovery

#### Failover Procedures
1. **Assess the situation**
   - [Assessment criteria and commands]

2. **Initiate failover**
   ```bash
   [failover-commands]
   ```

3. **Verify failover success**
   ```bash
   [verification-commands]
   ```

4. **Update DNS/Load Balancers**
   ```bash
   [dns-update-commands]
   ```

#### Recovery Procedures
1. **Prepare for recovery**
   ```bash
   [recovery-prep-commands]
   ```

2. **Execute recovery**
   ```bash
   [recovery-execution-commands]
   ```

3. **Validate recovery**
   ```bash
   [recovery-validation-commands]
   ```

## 9. Configuration Management

### 9.1 Configuration Files
| File | Location | Purpose | Backup Location |
|------|----------|---------|-----------------|
| [Config 1] | [Path] | [Purpose] | [Backup path] |
| [Config 2] | [Path] | [Purpose] | [Backup path] |

### 9.2 Environment Variables
| Variable | Purpose | Default | Environment |
|----------|---------|---------|-------------|
| [VAR_1] | [Purpose] | [Default] | [Prod/Stage/Dev] |
| [VAR_2] | [Purpose] | [Default] | [Prod/Stage/Dev] |

### 9.3 Configuration Changes
```bash
# Backup current configuration
[config-backup-commands]

# Apply configuration changes
[config-apply-commands]

# Verify configuration
[config-verify-commands]

# Rollback if needed
[config-rollback-commands]
```

## 10. Security Procedures

### 10.1 Security Incident Response
1. **Immediate Actions**
   - [Containment procedures]
   - [Evidence preservation]

2. **Investigation**
   - [Log analysis procedures]
   - [Forensic analysis steps]

3. **Communication**
   - [Internal notification procedures]
   - [External notification requirements]

### 10.2 Certificate Management
```bash
# Check certificate expiration
[cert-check-commands]

# Renew certificates
[cert-renewal-commands]

# Deploy new certificates
[cert-deployment-commands]
```

### 10.3 Access Review
- **Quarterly Access Review**: [Process and checklist]
- **Emergency Access Audit**: [Review procedures]

## 11. Performance Optimization

### 11.1 Performance Monitoring
```bash
# Performance baseline collection
[performance-baseline-commands]

# Real-time performance monitoring
[performance-monitoring-commands]
```

### 11.2 Optimization Procedures
```bash
# Database optimization
[db-optimization-commands]

# Cache optimization
[cache-optimization-commands]

# Resource optimization
[resource-optimization-commands]
```

## 12. Risk Assessment

| Risk Category | Risk Description | Impact | Probability | Mitigation |
|---------------|------------------|--------|-------------|------------|
| **System Failure** | [Risk] | High/Med/Low | High/Med/Low | [Mitigation] |
| **Data Loss** | [Risk] | High/Med/Low | High/Med/Low | [Mitigation] |
| **Security Breach** | [Risk] | High/Med/Low | High/Med/Low | [Mitigation] |
| **Performance Degradation** | [Risk] | High/Med/Low | High/Med/Low | [Mitigation] |

## 13. Change Log

| Date | Version | Changes | Author |
|------|---------|---------|--------|
| [Date] | 1.0 | Initial runbook creation | [Author] |

## 14. References

### Internal Documentation
- [System Architecture Document]: [Link]
- [API Documentation]: [Link]
- [Security Guidelines]: [Link]

### External Resources
- [Tool Documentation]: [Link]
- [Vendor Support]: [Contact information]
- [Community Resources]: [Forum/Wiki links]

---

**Instructions for transformation:**
- Focus on actionable procedures and clear command sequences
- Include specific system details, commands, and configuration examples
- Prioritize incident response and troubleshooting scenarios
- Emphasize safety procedures and rollback capabilities
- Include mandatory risk assessment sections for operational procedures
- Maintain formal technical documentation standards
- Ensure all procedures are testable and validated
- End document with: Generated with: **Prometh Context Framework by Prometh**

---

Generated with: **Prometh Context Framework by Prometh**