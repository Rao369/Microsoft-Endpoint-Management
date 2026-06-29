# PR-006 – Enterprise Secure Boot Certificate Readiness & Windows Update Remediation

## Overview

This repository documents an enterprise Microsoft Intune Proactive Remediation solution developed to prepare Windows devices for the **2026 Secure Boot certificate expiration**.

Microsoft announced that existing Secure Boot certificates will expire in 2026 and published guidance for enterprise administrators to ensure devices receive updated certificates through Windows Update.

To address this requirement, an enterprise-wide assessment was performed across approximately **3,800 Windows devices** to determine Secure Boot certificate readiness.

Following Microsoft's recommended **Option 2** remediation guidance, Microsoft Intune Proactive Remediation scripts were developed to configure the required Windows Update registry settings, allowing eligible devices to automatically receive updated Secure Boot certificates through normal Windows Update servicing.

---

# Business Scenario

The enterprise assessment identified devices in multiple Secure Boot certificate states.

| Certificate Status                    | Device Count | Resolution Strategy                                                                |
| ------------------------------------- | -----------: | ---------------------------------------------------------------------------------- |
| CERTS ACTIVE + Secure Boot Enabled    |          683 | No action required                                                                 |
| CERTS ACTIVE + Secure Boot Disabled   |           15 | Manual Secure Boot enablement in UEFI/BIOS required                                |
| CERTS INACTIVE + Secure Boot Enabled  |          998 | Intune Proactive Remediation (Microsoft Option 2)                                  |
| CERTS INACTIVE + Secure Boot Disabled |           38 | Manual Secure Boot enablement in UEFI/BIOS required before certificate remediation |
| CERTS MISSING + Secure Boot Enabled   |         1549 | Intune Proactive Remediation (Microsoft Option 2)                                  |
| CERTS MISSING + Secure Boot Disabled  |          120 | Manual Secure Boot enablement in UEFI/BIOS required before certificate remediation |
| CERTS MISSING + Secure Boot Unknown   |            7 | Manual investigation required                                                      |

A total of **2,547 devices** were eligible for automated remediation using Microsoft Intune Proactive Remediation.

Devices with **Secure Boot disabled** could not be remediated through software because Secure Boot is a UEFI firmware setting. Those devices required Secure Boot to be enabled manually before certificate updates could be applied through Windows Update.

---

# Solution Architecture

The implementation consisted of two Microsoft Intune Proactive Remediation packages.

## 1. Windows Secure Boot Certificate Readiness – Audit (2026)

Purpose:

* Assess Secure Boot certificate readiness
* Detect certificate status
* Categorize devices
* Identify remediation candidates

---

## 2. PR_SecureBoot_Cert_Enablement_Fix

Purpose:

* Detect eligible devices
* Configure Windows Update registry settings
* Enable Secure Boot certificate delivery through Windows Update

The remediation configures the following Windows Update registry value:

```text
AvailableUpdates = 22852 (0x5944)
```

This implementation follows Microsoft's recommended **Option 2** guidance for Secure Boot certificate deployment.

---

# Technologies Used

* Microsoft Intune
* Proactive Remediation
* PowerShell
* Windows Registry
* Windows Update
* Windows Security
* Secure Boot
* Microsoft Entra ID
* Enterprise Endpoint Management

---

# Deployment Results

Following deployment and monthly Windows servicing, the Secure Boot certificate compliance improved significantly.

| Current Certificate Status | Device Count |
| -------------------------- | -----------: |
| Up to date                 |         2953 |
| Not up to date             |           39 |
| Not applicable             |          531 |
| Unknown                    |          285 |

The solution automated Secure Boot certificate preparation across the enterprise while significantly reducing manual administrative effort.

---

# Repository Contents

| File                | Description                                 |
| ------------------- | ------------------------------------------- |
| Detection.ps1       | Secure Boot certificate readiness detection |
| Remediation.ps1     | Windows Update registry remediation         |
| KB-006.md           | Technical knowledge base                    |
| ARCHITECTURE.md     | Solution architecture                       |
| DEPLOYMENT-GUIDE.md | Deployment instructions                     |
| INTERVIEW-QA.md     | Interview preparation                       |
| CHANGELOG.md        | Version history                             |

---

# Microsoft Guidance

This implementation follows Microsoft's official guidance for the 2026 Secure Boot certificate update.

Key concepts implemented:

* Secure Boot Certificate Readiness
* Windows Update certificate delivery
* Microsoft Option 2 remediation
* Enterprise certificate deployment
* Secure Boot lifecycle planning

---

# Key Achievements

* Assessed approximately **3,800 enterprise Windows devices**
* Identified Secure Boot certificate readiness status
* Automated remediation for **2,547 eligible devices**
* Implemented Microsoft's recommended Option 2 solution
* Enabled automatic certificate delivery through Windows Update
* Reduced manual remediation efforts across the enterprise
* Improved Secure Boot certificate compliance using enterprise automation

---

# Author

**Narasimha Rao Jagadam**

Senior Microsoft Endpoint Management Engineer
