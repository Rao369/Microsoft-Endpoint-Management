# Deployment Guide

## Purpose

Deploy PR-001 using Microsoft Intune Proactive Remediation.

---

# Prerequisites

- Microsoft Intune Administrator permissions
- Windows Enterprise devices
- Intune Management Extension installed

---

# Step 1

Open

Microsoft Intune Admin Center

---

# Step 2

Navigate to

Devices

↓

Scripts and Remediations

↓

Proactive Remediations

---

# Step 3

Create a new remediation package.

Name

PR-001 – SCCM Client Cleanup

Description

Removes legacy MECM/SCCM client after Intune migration.

---

# Step 4

Upload

Detection.ps1

Remediation.ps1

---

# Step 5

Script Settings

Run this script using logged-on credentials

No

Run in 64-bit PowerShell

Yes

Enforce signature check

No

---

# Step 6

Assign

Pilot Device Group

↓

Production Device Group

---

# Step 7

Schedule

Daily

or

Hourly

depending on organizational requirements.

---

# Step 8

Monitor

Devices

↓

Scripts and Remediations

↓

Device Status

↓

Remediation Status

---

# Success Validation

Confirm:

✔ SCCM Client removed

✔ CCM Folder removed

✔ CCMExec service removed

✔ Detection returns Exit Code 0

✔ Device remains Intune managed

---

# Rollback

If required:

Reinstall Configuration Manager Client

OR

Redeploy MECM Client Package
