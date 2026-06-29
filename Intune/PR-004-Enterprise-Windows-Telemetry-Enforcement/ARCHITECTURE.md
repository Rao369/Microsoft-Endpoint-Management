# ARCHITECTURE.md

# PR-004 – Enterprise Windows Telemetry Enforcement

## Solution Architecture

This document describes the enterprise architecture used to restore Windows diagnostic telemetry reporting using Microsoft Intune Proactive Remediation.

---

# Business Scenario

During routine Windows Update for Business (WUfB) monitoring, approximately **1,800 Windows devices** reported the following alert:

**DeviceDiagnosticDataNotReceived**

Although devices remained Microsoft Intune managed and successfully received Windows Updates, required diagnostic telemetry was not consistently reaching Microsoft cloud services.

A lightweight Microsoft Intune Proactive Remediation solution was developed to validate and enforce the required telemetry registry configuration.

---

# High-Level Architecture

```text
                    Microsoft Intune
                           │
                           ▼
            Proactive Remediation Assignment
                           │
                           ▼
                Detection.ps1 Executes
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
        ▼                                     ▼
Telemetry Configuration                Telemetry Issue
      Compliant                              Detected
        │                                     │
        ▼                                     ▼
    Exit Code 0                         Exit Code 1
                                              │
                                              ▼
                                  Remediation.ps1 Executes
                                              │
                                              ▼
                     Validate DataCollection Registry Path
                                              │
                                              ▼
                     Create Registry Path (if missing)
                                              │
                                              ▼
                      Configure AllowTelemetry = 3
                                              │
                                              ▼
         Configure AllowUpdateComplianceProcessing = 1
                                              │
                                              ▼
          Configure AllowCommercialDataPipeline = 1
                                              │
                                              ▼
                         Write Remediation Log File
                                              │
                                              ▼
                     Microsoft Intune Policy Refresh
                                              │
                                              ▼
                 Windows Diagnostic Data Collection
                                              │
                                              ▼
             Windows Update for Business Reporting
                                              │
                                              ▼
             DeviceDiagnosticDataNotReceived Cleared
```

---

# Detection Workflow

The detection script validates the required registry configuration under:

```text
HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection
```

Required values:

| Registry Value                  | Expected Value |
| ------------------------------- | -------------: |
| AllowTelemetry                  |              3 |
| AllowUpdateComplianceProcessing |              1 |
| AllowCommercialDataPipeline     |              1 |

If any value is missing or incorrect, the script returns **Exit Code 1**, triggering remediation.

---

# Remediation Workflow

The remediation performs the following sequence:

1. Verify the DataCollection registry path.
2. Create the registry path if it does not exist.
3. Configure **AllowTelemetry = 3**.
4. Configure **AllowUpdateComplianceProcessing = 1**.
5. Configure **AllowCommercialDataPipeline = 1**.
6. Record execution details in the remediation log.

This lightweight approach restores the required telemetry configuration without affecting users or requiring device reimaging.

---

# Logging

The remediation records activity in:

```text
C:\Windows\Temp\PR004-TelemetryEnforcement.log
```

The log contains:

* Registry path validation
* Registry creation
* Registry value updates
* Execution timestamps
* Completion status

---

# Enterprise Benefits

* Standardized telemetry configuration
* Automated configuration enforcement
* Lightweight remediation
* No user interaction required
* No reboot required
* Scalable through Microsoft Intune
* Improved Windows Update for Business reporting

---

# Business Outcome

| Metric                                 | Before | After |
| -------------------------------------- | -----: | ----: |
| DeviceDiagnosticDataNotReceived Alerts |  ~1800 |   ~30 |

The solution significantly improved diagnostic telemetry reporting and reduced the number of Windows Update for Business telemetry alerts across the enterprise.

---

# Design Considerations

* Uses Microsoft-supported registry policies.
* Suitable for Microsoft Entra ID joined and Microsoft Intune managed devices.
* Can be scheduled through Microsoft Intune Proactive Remediations.
* Non-destructive and safe for repeated execution.
* Easily extensible to include additional telemetry validation checks in future releases.
