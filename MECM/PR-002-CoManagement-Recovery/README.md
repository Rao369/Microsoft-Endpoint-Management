# PR-002 – Enterprise Co-management Recovery Automation

## Overview

This repository documents an enterprise recovery solution developed during a large-scale Microsoft Endpoint Configuration Manager (MECM) and Microsoft Intune co-management implementation.

During the implementation, approximately **580 Windows devices** remained **Configuration Manager (ConfigMgr) managed** and did not transition to a **Co-managed** state, even though the devices were successfully **Microsoft Entra ID Joined**.

A recovery workflow was designed, validated through pilot testing, packaged using **PSAppDeployToolkit**, and deployed using **Microsoft Endpoint Configuration Manager (MECM)** Application Deployment.

The recovery process consisted of:

- Validating Microsoft Entra ID status
- Performing Microsoft Entra Leave and Join
- Reinstalling the Configuration Manager (SCCM) client
- Restarting the device
- Validating successful transition to a Co-managed state

Following successful pilot testing, the solution was deployed to the affected production devices.

---

# Technologies Used

- Microsoft Intune
- Microsoft Endpoint Configuration Manager (MECM / SCCM)
- Microsoft Entra ID
- PSAppDeployToolkit
- PowerShell
- Batch Scripting
- Windows Scheduled Tasks

---

# Business Scenario

During the enterprise co-management implementation, approximately **580 Windows devices** failed to transition from **Configuration Manager managed** to **Co-managed**.

## Observed Behaviour

- Microsoft Entra ID Joined = **Yes**
- Configuration Manager Client = **Healthy**
- **Co-managed = No** in the MECM console
- Devices remained managed only by Configuration Manager
- Expected transition to Co-management did not occur

Recovery testing demonstrated that the following workflow consistently restored the expected co-management state.

---

# Recovery Workflow

1. Validate Microsoft Entra ID status using:

   ```cmd
   dsregcmd /status
   ```

2. Execute Microsoft Entra Leave

3. Execute Microsoft Entra Join

4. Reinstall the Configuration Manager (SCCM) Client

5. Restart the device

6. Validate that the device successfully transitions to **Co-managed**

---

# Repository Contents

| File | Description |
|------|-------------|
| Deploy-Application.ps1 | PSAppDeployToolkit deployment package |
| Dsregcmd.cmd | Microsoft Entra ID recovery commands |
| Validate-CoManagement.ps1 | Co-management validation script |
| SCCM-Reinstall.ps1 | Configuration Manager client reinstallation |
| KB-002.md | Technical knowledge base |
| DEPLOYMENT-GUIDE.md | Deployment instructions |
| ARCHITECTURE.md | Solution architecture |
| INTERVIEW-QA.md | Interview preparation |
| CHANGELOG.md | Version history |

---

# Author

**Narasimha Rao Jagadam**

Senior Microsoft Endpoint Management Engineer

**Technologies**

- Microsoft Intune
- Microsoft Endpoint Configuration Manager (MECM / SCCM)
- Microsoft Entra ID
- Windows 10 / Windows 11
- PowerShell
- PSAppDeployToolkit
- Enterprise Endpoint Management
