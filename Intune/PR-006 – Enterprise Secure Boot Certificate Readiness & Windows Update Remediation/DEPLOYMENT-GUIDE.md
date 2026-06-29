# DEPLOYMENT GUIDE – PR-006 Enterprise Secure Boot Certificate Readiness & Windows Update Remediation

# Purpose

This document describes the deployment approach used to prepare enterprise Windows devices for the Microsoft Secure Boot Certificate update using Microsoft Intune Proactive Remediation.

---

# Deployment Architecture

The solution consisted of two Microsoft Intune Proactive Remediation packages:

## 1. Windows Secure Boot Certificate Readiness – Audit (2026)

Purpose:

* Assess Secure Boot certificate readiness
* Detect certificate status
* Identify devices requiring remediation
* Generate compliance reporting

Deployment Type:

* Detection only (Audit)

---

## 2. PR_SecureBoot_Cert_Enablement_Fix

Purpose:

* Configure Microsoft-recommended Windows Update registry settings
* Prepare eligible devices for Secure Boot certificate delivery
* Support automated certificate deployment through Windows Update

Deployment Type:

* Detection + Remediation

---

# Target Devices

Target Collection:

Enterprise Windows devices managed by Microsoft Intune.

Supported operating systems:

* Windows 10
* Windows 11

Prerequisites:

* Microsoft Intune enrolled
* Windows Update for Business enabled
* Secure Boot enabled (for automated remediation)
* Internet connectivity

---

# Deployment Schedule

The remediation package was deployed using Microsoft Intune Proactive Remediation.

Typical execution:

* Detection script runs first.
* Non-compliant devices trigger remediation.
* Registry configuration is applied.
* Devices receive updated Secure Boot certificates during subsequent Windows Update servicing.

---

# Validation Process

Deployment success was validated through:

* Microsoft Intune Proactive Remediation reports
* Secure Boot certificate dashboards
* Windows Update servicing results
* Enterprise compliance reporting

Key validation checks:

* Detection script reports compliance.
* Required registry values are present.
* Secure Boot certificate status improves after monthly updates.
* Devices report as "Up to date" in the Secure Boot dashboard.

---

# Deployment Results

The implementation achieved:

* Enterprise-wide assessment across approximately 3,800 devices.
* Automated remediation for 2,547 eligible devices.
* Significant improvement in Secure Boot certificate compliance.
* Reduced manual remediation effort.
* Alignment with Microsoft's recommended Option 2 guidance.

---

# Operational Notes

* Devices with Secure Boot disabled were excluded from automated remediation.
* Those devices require Secure Boot to be enabled manually in UEFI/BIOS before certificate updates can be applied.
* Registry configuration alone does not enable Secure Boot.

---

# Rollback

If required, the remediation can be reversed by:

* Removing the configured registry values.
* Redeploying the updated Proactive Remediation package.
* Reassessing device compliance through the audit package.

No operating system components or Secure Boot certificates are modified directly by this remediation.

