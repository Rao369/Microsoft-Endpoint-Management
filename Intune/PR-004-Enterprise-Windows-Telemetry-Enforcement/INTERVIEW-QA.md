# INTERVIEW-QA.md

# PR-004 – Enterprise Windows Telemetry Enforcement

## Interview Questions & Answers

This document contains interview questions based on the enterprise Windows Telemetry Enforcement solution implemented using Microsoft Intune Proactive Remediation.

---

# 1. What business problem were you solving?

### Answer

During Windows Update for Business (WUfB) monitoring, approximately **1,800 devices** reported the **DeviceDiagnosticDataNotReceived** alert.

Although these devices were successfully managed by Microsoft Intune and receiving Windows Updates, the required diagnostic telemetry was not being reported consistently, reducing the accuracy of compliance reporting.

To address this, I developed a Microsoft Intune Proactive Remediation solution that validated and enforced the required telemetry configuration automatically.

---

# 2. What was the root cause?

### Answer

The required telemetry registry settings under:

```text id="nld2yq"
HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection
```

were either missing or incorrectly configured.

Without these settings, Windows Update for Business could not receive the diagnostic data required for enterprise compliance reporting.

---

# 3. Why did you use Proactive Remediation instead of a Configuration Profile?

### Answer

A Configuration Profile can deploy the required settings, but it does not automatically identify and remediate devices that are already in a non-compliant state.

Proactive Remediation continuously:

* Detects missing or incorrect registry values.
* Applies remediation only where necessary.
* Provides reporting on detection and remediation status.
* Can be scheduled to run repeatedly, ensuring ongoing compliance.

---

# 4. Which registry values were configured?

### Answer

The remediation configured the following values:

| Registry Value                  | Value |
| ------------------------------- | ----: |
| AllowTelemetry                  |     3 |
| AllowUpdateComplianceProcessing |     1 |
| AllowCommercialDataPipeline     |     1 |

These settings are required for Windows Update for Business diagnostic reporting.

---

# 5. How does the detection script work?

### Answer

The detection script:

1. Checks whether the **DataCollection** registry path exists.
2. Verifies each required registry value.
3. Returns **Exit Code 0** if all settings are correct.
4. Returns **Exit Code 1** if any value is missing or incorrect, triggering remediation.

---

# 6. What does the remediation script do?

### Answer

The remediation script:

* Creates the registry path if it does not exist.
* Configures all required telemetry registry values.
* Writes execution details to a local log file.
* Exits successfully so that Intune reports the remediation as complete.

---

# 7. Did users notice any impact?

### Answer

No.

The remediation updates registry values silently under the SYSTEM context. It does not interrupt users, close applications, or require a reboot.

---

# 8. How did you validate success?

### Answer

Validation included:

* Reviewing Intune Proactive Remediation reports.
* Confirming successful detection and remediation.
* Verifying registry values on sample devices.
* Monitoring Windows Update for Business reports over subsequent sync cycles.

---

# 9. What was the business outcome?

### Answer

The solution reduced the number of **DeviceDiagnosticDataNotReceived** alerts from approximately **1,800** to around **30** devices.

This significantly improved Windows Update for Business reporting accuracy and reduced operational effort.

---

# 10. Is the remediation safe to run multiple times?

### Answer

Yes.

The script is idempotent, meaning it can execute repeatedly without causing unwanted changes. It simply verifies and enforces the desired configuration.

---

# 11. How would you improve this solution in the future?

### Answer

Potential enhancements include:

* Validate telemetry settings after remediation.
* Trigger a Microsoft Intune device sync.
* Refresh applicable policies where required.
* Add richer logging and health reporting.
* Generate compliance metrics for operational dashboards.

---

# 12. What did you learn from this project?

### Answer

This project reinforced several key practices:

* Enterprise telemetry directly affects Windows Update reporting quality.
* Small configuration inconsistencies can impact thousands of devices.
* Microsoft Intune Proactive Remediation is an effective tool for continuous compliance.
* Automated validation and remediation reduce manual support effort and improve reporting reliability.

---

# Key Interview Takeaways

* Real enterprise production implementation.
* Microsoft Intune Proactive Remediation.
* Windows Update for Business expertise.
* PowerShell automation.
* Windows Registry management.
* Enterprise compliance reporting.
* Large-scale deployment experience.
* Measurable business improvement (1,800 → 30 devices).

---

# Project Summary

| Category                            | Details                                                                  |
| ----------------------------------- | ------------------------------------------------------------------------ |
| Platform                            | Microsoft Intune                                                         |
| Solution                            | Proactive Remediation                                                    |
| Technology                          | PowerShell                                                               |
| Issue                               | DeviceDiagnosticDataNotReceived                                          |
| Devices Impacted                    | ~1,800                                                                   |
| Devices Remaining After Remediation | ~30                                                                      |
| Business Outcome                    | Improved Windows Update for Business reporting and compliance visibility |
