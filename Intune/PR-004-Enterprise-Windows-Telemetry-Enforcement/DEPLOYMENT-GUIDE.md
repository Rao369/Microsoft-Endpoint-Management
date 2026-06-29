# DEPLOYMENT-GUIDE.md

# PR-004 – Enterprise Windows Telemetry Enforcement

## Deployment Guide

This document describes the deployment methodology used to implement the Windows Telemetry Enforcement solution through Microsoft Intune Proactive Remediation.

---

# Purpose

The objective of this deployment is to automatically identify and remediate Windows devices with missing or incorrect telemetry configuration required for Windows Update for Business (WUfB) reporting.

The solution validates the required registry settings and automatically applies corrective actions where necessary.

---

# Deployment Platform

| Item              | Value                   |
| ----------------- | ----------------------- |
| Platform          | Microsoft Intune        |
| Feature           | Proactive Remediation   |
| Deployment Type   | Detection + Remediation |
| Script Language   | PowerShell              |
| Execution Context | SYSTEM                  |
| Run Frequency     | Scheduled               |

---

# Deployment Components

The Proactive Remediation package contains:

| File            | Purpose                                       |
| --------------- | --------------------------------------------- |
| Detection.ps1   | Validates telemetry registry configuration    |
| Remediation.ps1 | Configures required telemetry registry values |

---

# Detection Logic

The detection script performs the following checks:

* Verify the registry path exists:

  * `HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection`
* Validate:

  * `AllowTelemetry = 3`
  * `AllowUpdateComplianceProcessing = 1`
  * `AllowCommercialDataPipeline = 1`

### Exit Codes

| Exit Code | Meaning                 |
| --------- | ----------------------- |
| 0         | Configuration compliant |
| 1         | Remediation required    |

---

# Remediation Actions

When the detection script returns **Exit Code 1**, the remediation script performs the following:

1. Create the **DataCollection** registry path if it does not exist.
2. Configure:

   * `AllowTelemetry = 3`
   * `AllowUpdateComplianceProcessing = 1`
   * `AllowCommercialDataPipeline = 1`
3. Record execution details in the remediation log.

The remediation is lightweight and can safely run multiple times without adverse effects.

---

# Deployment Process

1. Create a new **Proactive Remediation** package in Microsoft Intune.
2. Upload:

   * Detection.ps1
   * Remediation.ps1
3. Configure script settings:

   * Run using the logged-on credentials: **No**
   * Enforce script signature check: **No**
   * Run script in 64-bit PowerShell: **Yes**
4. Assign the remediation package to the target device group.
5. Schedule execution according to organizational requirements.
6. Monitor deployment status from the Intune portal.

---

# Validation

After deployment, confirm:

* Detection status = **Succeeded**
* Remediation status = **Succeeded** (where applicable)
* Registry values are correctly configured.
* Devices begin reporting diagnostic telemetry to Windows Update for Business.
* The **DeviceDiagnosticDataNotReceived** alert count decreases over time.

---

# Logging

The remediation script writes execution details to:

```text
C:\Windows\Temp\PR004-TelemetryEnforcement.log
```

The log includes:

* Registry path creation
* Registry value configuration
* Execution timestamps
* Completion status

---

# Production Results

| Metric                                 | Before | After |
| -------------------------------------- | -----: | ----: |
| DeviceDiagnosticDataNotReceived Alerts |  ~1800 |   ~30 |

This deployment significantly improved Windows Update for Business telemetry reporting and reduced the number of enterprise telemetry alerts.

---

# Rollback

If required, rollback can be performed by:

* Removing the Proactive Remediation assignment.
* Restoring telemetry settings through Microsoft Intune configuration profiles or Group Policy.
* Verifying device policy synchronization after changes.

---

# Best Practices

* Pilot the remediation with a small group before broad deployment.
* Monitor Intune reporting after each deployment cycle.
* Review remediation logs for any unexpected failures.
* Re-run the remediation on newly enrolled or rebuilt devices if telemetry alerts reappear.
* Track trends in Windows Update for Business reporting to measure long-term effectiveness.

---

# Conclusion

The Enterprise Windows Telemetry Enforcement solution provides a scalable and automated approach to maintaining the telemetry configuration required for Windows Update for Business.

Using Microsoft Intune Proactive Remediation, the organization was able to standardize telemetry settings across thousands of managed devices, resulting in a substantial reduction in reporting alerts and improved compliance visibility.
