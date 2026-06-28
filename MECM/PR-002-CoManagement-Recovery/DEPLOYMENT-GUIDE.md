# Deployment Guide

## Project

PR-002 – Enterprise ConfigMgr to Co-management Recovery Automation

---

# Purpose

This document describes how the recovery package can be deployed in an enterprise environment using Microsoft Endpoint Configuration Manager (MECM).

---

# Deployment Type

Microsoft Endpoint Configuration Manager (MECM) Application

---

# Installation Method

The package performs the following actions:

1. Execute Microsoft Entra ID recovery
2. Create a scheduled task for Microsoft Entra Join
3. Allow Configuration Manager client reinstallation
4. Restart the device (if required)
5. Validate successful transition to Co-Managed

---

# Package Contents

- Deploy-Application.ps1
- Dsregcmd.cmd
- PSAppDeployToolkit
- Supporting scripts

---

# Deployment Process

1. Create an Application in MECM.
2. Distribute content to Distribution Points.
3. Deploy to a pilot device collection.
4. Validate recovery.
5. Deploy to production devices.
6. Monitor deployment status.
7. Confirm devices transition to Co-Managed.

---

# Validation Checklist

- Microsoft Entra ID Joined = YES
- Configuration Manager Client installed
- Device synchronized successfully
- Device reported as Co-Managed
- No deployment errors

---

# Rollback Plan

If recovery is unsuccessful:

- Review deployment logs.
- Validate Microsoft Entra ID status.
- Validate SCCM client installation.
- Retry deployment after investigation.

---

# Best Practices

- Always test with a pilot group.
- Validate logs before production rollout.
- Monitor deployment compliance.
- Perform deployment during approved maintenance windows.
