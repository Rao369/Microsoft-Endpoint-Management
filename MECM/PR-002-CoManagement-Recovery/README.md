# PR-002 – Enterprise Co-management Recovery Automation

## Overview

This repository documents an enterprise recovery solution developed during a large-scale Microsoft Endpoint Configuration Manager (MECM) to Microsoft Intune migration.

Approximately 580 Windows devices remained in a Co-managed state instead of transitioning to full Microsoft Intune management.

Although affected devices reported **Microsoft Entra ID Joined = Yes**, the transition did not complete successfully.

A recovery workflow was designed, validated through pilot testing, packaged using PSAppDeployToolkit, and deployed through MECM Application Deployment.

The recovery consisted of:

- Microsoft Entra Leave
- Microsoft Entra Join
- Configuration Manager Client Reinstallation
- Device Restart
- Validation of Intune Management State

Following successful testing on pilot devices, the solution was deployed to affected production devices.

---

## Technologies Used

- Microsoft Intune
- MECM / SCCM
- Microsoft Entra ID
- PSAppDeployToolkit
- PowerShell
- Batch Scripting
- Windows Scheduled Tasks

---

## Business Scenario

During cloud migration, approximately 580 devices remained in a Co-managed state.

Observed condition:

- Microsoft Entra ID Joined = Yes
- Device remained Co-managed
- Expected transition to Intune management did not occur

Recovery testing demonstrated that the following workflow consistently restored the expected management state.

---

## Recovery Workflow

1. Verify Microsoft Entra status using dsregcmd /status

2. Execute Microsoft Entra Leave

3. Execute Microsoft Entra Join

4. Reinstall Configuration Manager Client

5. Restart Device

6. Validate successful Intune management

---

## Repository Contents

| File | Description |
|------|-------------|
| Deploy-Application.ps1 | PSAppDeployToolkit deployment |
| Dsregcmd.cmd | Microsoft Entra recovery commands |
| Validate-CoManagement.ps1 | Validation script |
| SCCM-Reinstall.ps1 | SCCM client reinstall |
| KB-002.md | Technical knowledge base |
| DEPLOYMENT-GUIDE.md | Deployment instructions |
| ARCHITECTURE.md | Solution architecture |
| INTERVIEW-QA.md | Interview preparation |
| CHANGELOG.md | Version history |

---

## Author

Narasimha Rao Jagadam

Senior Microsoft Endpoint Management Engineer
