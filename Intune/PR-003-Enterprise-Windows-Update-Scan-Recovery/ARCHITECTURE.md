# ARCHITECTURE.md

# PR-003 – Enterprise Windows Update Scan Recovery

## Solution Architecture

This document describes the enterprise architecture used to recover Windows Update scan failures using Microsoft Intune Proactive Remediation.

---

# Business Scenario

Monthly Windows Update for Business reports identified approximately **800 devices** reporting:

**Quality Update Status = Device not scanned**

Although the devices remained Microsoft Intune managed and online, Windows Update scan telemetry had become stale, preventing accurate compliance reporting.

A lightweight staged remediation solution was implemented to restore Windows Update scan health while minimizing impact to end users.

---

# High-Level Architecture

```text
                           Microsoft Intune
                                  │
                                  ▼
                    Proactive Remediation Assignment
                                  │
                                  ▼
                     Detection.ps1 Executes on Device
                                  │
              ┌───────────────────┴───────────────────┐
              │                                       │
              ▼                                       ▼
      Windows Update Healthy                Windows Update Issue
              │                                       │
              ▼                                       ▼
          Exit Code 0                          Exit Code 1
                                                      │
                                                      ▼
                                           Remediation.ps1 Executes
                                                      │
                                                      ▼
                                    Check Pending Reboot Status
                                                      │
                                   ┌──────────────────┴──────────────────┐
                                   │                                     │
                                   ▼                                     ▼
                            Reboot Pending                     No Reboot Pending
                                   │                                     │
                                   ▼                                     ▼
                            Exit Gracefully                     Validate Core Services
                                                                      │
                                                                      ▼
                                            Validate wuauserv / BITS / UsoSvc /
                                                  Windows Update Medic Service
                                                                      │
                                                                      ▼
                                                     Correct Service Configuration
                                                                      │
                                                                      ▼
                                                   Refresh Windows Update Settings
                                                                      │
                                                                      ▼
                                                     Trigger Windows Update Scan
                                                                      │
                                                                      ▼
                                                   Trigger Microsoft Intune Sync
                                                                      │
                                                                      ▼
                                              Validate Windows Update Event Logs
                                                                      │
                                                                      ▼
                                                     Write Remediation Log File
                                                                      │
                                                                      ▼
                                                      Windows Update Reporting
                                                                      │
                                                                      ▼
                                           Windows Update for Business Dashboard
                                                                      │
                                                                      ▼
                                          Device Successfully Reporting Scan Status
```

---

# Detection Workflow

The detection script validates the following components before remediation is initiated:

* Windows Update Operational Event Log
* Windows Update scan freshness
* Windows Update service health
* Background Intelligent Transfer Service (BITS)
* Update Orchestrator Service (UsoSvc)

If any validation fails, Microsoft Intune receives **Exit Code 1** and automatically starts remediation.

---

# Remediation Workflow

The remediation performs staged recovery in the following order:

1. Check for pending reboot
2. Validate Windows Update services
3. Correct disabled startup types
4. Start required services
5. Refresh Windows Update settings
6. Trigger Windows Update scan
7. Trigger Microsoft Intune synchronization
8. Validate Windows Update event creation
9. Write remediation log

This staged approach minimizes disruption while restoring Windows Update scan health.

---

# Logging

The remediation records activity to:

```text
C:\Windows\Temp\PR003-WindowsUpdateScanRecovery.log
```

The log contains:

* Service validation
* Service recovery actions
* Windows Update scan execution
* Intune synchronization
* Windows Update event validation
* Execution timestamps

---

# Enterprise Benefits

* Lightweight remediation
* No SoftwareDistribution reset
* No Catroot2 reset
* Safe for enterprise deployment
* Minimal end-user disruption
* Optimized for Windows Update for Business
* Optimized for Microsoft Intune Proactive Remediation

---

# Business Outcome

| Metric                                 | Before | After |
| -------------------------------------- | -----: | ----: |
| Devices reporting "Device not scanned" |   ~800 |  ~150 |
| Enterprise Patch Compliance            |    91% |   97% |

The solution became part of the monthly Windows servicing process and significantly improved Windows Update reporting accuracy across the enterprise.
