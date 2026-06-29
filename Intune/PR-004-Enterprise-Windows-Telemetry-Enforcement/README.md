# PR-004 – Enterprise Windows Telemetry Enforcement

## Overview

This repository documents an enterprise Microsoft Intune Proactive Remediation solution developed to resolve Windows Update for Business telemetry reporting issues.

During monthly Windows Update compliance monitoring, approximately **1,800 Windows devices** reported the alert:

**DeviceDiagnosticDataNotReceived**

Although devices remained Microsoft Intune managed and successfully received Windows Updates, diagnostic telemetry required for Windows Update for Business reporting was not consistently reaching Microsoft services.

A lightweight Microsoft Intune Proactive Remediation solution was developed to validate and enforce the required Windows telemetry configuration.

The remediation standardized diagnostic data settings, refreshed device policy, and restored enterprise telemetry reporting.

Following enterprise deployment, the alert count was reduced from approximately **1,800 devices** to around **30 devices**, significantly improving Windows Update reporting accuracy.

---

# Business Problem

Windows Update for Business reports contained a high number of devices with missing diagnostic data.

This affected:

* Windows Update reporting accuracy
* Update compliance dashboards
* Enterprise reporting visibility
* Operational monitoring

---

# Solution

The Proactive Remediation performs:

* Windows Telemetry validation
* Registry enforcement
* Policy refresh
* Microsoft Intune synchronization
* Telemetry verification

---

# Technologies Used

* Microsoft Intune
* Windows Update for Business
* Microsoft Entra ID
* PowerShell
* Windows Registry
* Proactive Remediation

---

# Business Results

| Metric                          | Before | After |
| ------------------------------- | -----: | ----: |
| DeviceDiagnosticDataNotReceived |  ~1800 |   ~30 |

---

# Repository Contents

| File                | Description                             |
| ------------------- | --------------------------------------- |
| Detection.ps1       | Detects missing telemetry configuration |
| Remediation.ps1     | Enforces telemetry settings             |
| KB-004.md           | Technical Knowledge Base                |
| ARCHITECTURE.md     | Enterprise architecture                 |
| DEPLOYMENT-GUIDE.md | Deployment process                      |
| INTERVIEW-QA.md     | Interview questions                     |
| CHANGELOG.md        | Version history                         |

---

# Author

**Narasimha Rao Jagadam**

Senior Microsoft Endpoint Management Engineer
