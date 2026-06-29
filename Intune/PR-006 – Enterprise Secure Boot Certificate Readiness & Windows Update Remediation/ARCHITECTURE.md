# ARCHITECTURE – PR-006 Enterprise Secure Boot Certificate Readiness & Windows Update Remediation

# Solution Overview

This project was designed to prepare enterprise Windows devices for the Microsoft Secure Boot certificate expiration scheduled for **2026**.

The solution combines enterprise assessment, automated remediation, Windows Update servicing, and compliance validation using Microsoft Intune Proactive Remediation.

---

# Enterprise Architecture

```text
                        Microsoft Security Advisory
                                   │
                                   ▼
          Secure Boot Certificate Expiration (2026)
                                   │
                                   ▼
                  Enterprise Device Assessment
                                   │
                                   ▼
        Windows Secure Boot Certificate Audit (PR)
                                   │
                                   ▼
                Determine Certificate Readiness
                                   │
             ┌─────────────────────┴─────────────────────┐
             │                                           │
             ▼                                           ▼
     Secure Boot Enabled                      Secure Boot Disabled
             │                                           │
             ▼                                           ▼
   Certificate Active /                  Manual UEFI/BIOS Enablement
 Missing / Inactive                                 Required
             │                                           │
             ▼                                           ▼
 Microsoft Option 2 Registry                  Device Ready for
      Configuration PR                   Certificate Remediation
             │                                           │
             └─────────────────────┬─────────────────────┘
                                   ▼
                     Windows Update Monthly Servicing
                                   │
                                   ▼
              Secure Boot Certificate Installation
                                   │
                                   ▼
                Enterprise Compliance Validation
                                   │
                                   ▼
               Microsoft Intune Reporting Dashboard
```

---

# Solution Components

## 1. Assessment Layer

Purpose:

* Evaluate Secure Boot status.
* Determine certificate readiness.
* Identify remediation candidates.
* Classify devices by certificate state.

Output:

* Certificates Active
* Certificates Missing
* Certificates Inactive
* Secure Boot Enabled
* Secure Boot Disabled

---

## 2. Decision Layer

The assessment determines the appropriate remediation path.

### Secure Boot Enabled

Eligible for automated remediation using Microsoft Option 2.

### Secure Boot Disabled

Requires manual Secure Boot enablement in UEFI/BIOS before certificate updates can be delivered.

---

## 3. Remediation Layer

The remediation package configures the Windows Update policy required by Microsoft.

Registry path:

```text
HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection
```

Configured values:

* AllowTelemetry = 3
* AllowUpdateComplianceProcessing = 1
* AllowCommercialDataPipeline = 1

These settings prepare eligible devices to receive updated Secure Boot certificates through Windows Update.

---

## 4. Windows Update Layer

Following registry configuration, devices receive updated Secure Boot certificates during normal Windows Update servicing.

No manual installation of certificates is required for eligible devices.

---

## 5. Validation Layer

Deployment success is validated using:

* Microsoft Intune Proactive Remediation reports
* Secure Boot certificate dashboards
* Windows Update servicing results
* Enterprise compliance reporting

---

# Enterprise Design Principles

The solution was designed around the following principles:

* Microsoft-supported implementation.
* Enterprise scalability.
* Minimal user disruption.
* Automated remediation.
* Secure configuration management.
* Standard Windows Update servicing.
* Reduced operational overhead.

---

# Benefits

* Automated remediation across thousands of enterprise devices.
* Reduced manual administrative effort.
* Improved Secure Boot certificate compliance.
* Prepared devices for the 2026 certificate expiration.
* Followed Microsoft's recommended Option 2 guidance.
* Improved enterprise security posture.
* Fully integrated with Microsoft Intune management.

---

# Architecture Summary

The architecture combines assessment, automated remediation, Windows Update servicing, and compliance validation into a scalable enterprise solution.

By separating devices into automated and manual remediation paths, the implementation ensured that only supported devices received registry-based remediation while devices requiring firmware changes were correctly identified for manual action.

