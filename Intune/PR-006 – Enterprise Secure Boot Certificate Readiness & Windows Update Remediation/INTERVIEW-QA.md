# INTERVIEW-QA – PR-006 Enterprise Secure Boot Certificate Readiness & Windows Update Remediation

# 1. What was the objective of this project?

The objective was to prepare enterprise Windows devices for Microsoft's 2026 Secure Boot certificate expiration by implementing Microsoft's recommended Option 2 remediation using Microsoft Intune Proactive Remediation.

The solution automated registry configuration required for Windows Update to deliver new Secure Boot certificates to eligible devices.

---

# 2. Why was this project required?

Microsoft announced that existing Secure Boot certificates would expire in 2026.

Without updating these certificates, future Windows boot trust and Secure Boot functionality could be affected.

The project ensured devices were prepared before certificate expiration.

---

# 3. How many devices were involved?

Approximately 3,800 enterprise Windows devices were assessed.

Around 2,547 devices were eligible for automated remediation.

---

# 4. What tools were used?

* Microsoft Intune
* Proactive Remediation
* PowerShell
* Windows Registry
* Windows Update
* Secure Boot Compliance Dashboard

---

# 5. What is Microsoft's Option 2?

Option 2 is Microsoft's recommended enterprise approach for preparing Windows devices to receive updated Secure Boot certificates through normal Windows Update servicing.

It uses Windows Update policy configuration rather than manual certificate installation.

---

# 6. Why did your organization choose Option 2?

Because it:

* is Microsoft supported
* scales across thousands of devices
* is fully automated
* integrates with Windows Update
* minimizes manual effort

---

# 7. What did the detection script check?

The detection script verified:

* Registry path exists.
* AllowTelemetry = 3
* AllowUpdateComplianceProcessing = 1
* AllowCommercialDataPipeline = 1

If any value was missing or incorrect, the device was marked non-compliant.

---

# 8. What did the remediation script do?

The remediation script:

* Created the registry path if necessary.
* Configured the required registry values.
* Logged remediation activity.
* Prepared eligible devices for certificate delivery through Windows Update.

---

# 9. Did the script install Secure Boot certificates?

No.

The script only configured the Windows Update policy required by Microsoft.

The certificates were delivered later through normal Windows Update servicing.

---

# 10. Did your script enable Secure Boot?

No.

Secure Boot is a UEFI firmware feature.

PowerShell, Intune, and registry changes cannot enable Secure Boot.

Devices with Secure Boot disabled required manual enablement in UEFI/BIOS.

---

# 11. Why couldn't Secure Boot be enabled through PowerShell?

Because Secure Boot is controlled by firmware (UEFI), not by the Windows operating system.

Windows can detect Secure Boot status but cannot enable it through software.

---

# 12. How were devices categorized?

Devices were classified into:

* Certificates Active
* Certificates Missing
* Certificates Inactive
* Secure Boot Enabled
* Secure Boot Disabled

---

# 13. Which devices received automated remediation?

Only devices with:

* Secure Boot Enabled
* Missing or Inactive certificates

These devices were eligible for Microsoft's Option 2.

---

# 14. What happened to devices with Secure Boot disabled?

Those devices required manual Secure Boot enablement in UEFI/BIOS before certificate updates could be delivered.

---

# 15. How did you validate success?

Validation included:

* Intune Proactive Remediation reports
* Secure Boot certificate dashboards
* Windows Update servicing results
* Compliance reporting

---

# 16. What business benefit did this project provide?

The project:

* Reduced manual administration.
* Improved Secure Boot certificate compliance.
* Prepared the enterprise for Microsoft's 2026 certificate expiration.
* Standardized deployment across thousands of devices.

---

# 17. Why was Intune Proactive Remediation selected?

Because it provides:

* Automated detection
* Automated remediation
* Enterprise reporting
* Scheduled execution
* Scalable deployment

---

# 18. What would happen if the registry values were not configured?

Eligible devices would not receive Secure Boot certificate updates through the Microsoft-supported Option 2 deployment method.

---

# 19. How is this solution scalable?

The same remediation package can be deployed to thousands of devices without requiring manual administrator intervention.

---

# 20. What lessons did you learn from this project?

* Always follow Microsoft guidance for security-related changes.
* Separate operating system remediation from firmware configuration.
* Validate enterprise readiness before remediation.
* Use automation wherever supported.
* Keep remediation scripts simple, reliable, and easy to audit.

---

# 21. What was your role in this project?

My responsibilities included:

* Assessing enterprise Secure Boot readiness.
* Designing the remediation approach.
* Developing the Intune Proactive Remediation scripts.
* Deploying the solution through Microsoft Intune.
* Monitoring remediation progress.
* Validating compliance improvements.
* Supporting enterprise rollout.

---

# 22. What were the final results?

Following deployment and Windows Update servicing:

* Approximately 3,800 devices were assessed.
* 2,547 eligible devices were prepared automatically.
* Secure Boot certificate compliance improved significantly.
* Manual remediation effort was substantially reduced.

---

# 23. What would you improve if implementing this project again?

I would:

* Create automated compliance dashboards in Power BI.
* Add proactive alerting for non-compliant devices.
* Integrate reporting with Microsoft Graph API.
* Schedule periodic compliance reviews.
* Automate executive reporting.

---

# 24. How would you explain this project to a non-technical manager?

Microsoft announced that Secure Boot certificates used by Windows devices would expire in 2026.

We built an automated Intune solution that prepared eligible devices to receive updated certificates through normal Windows Updates, reducing manual work and helping ensure devices remain secure and compliant.

---

# 25. Why is this project important for enterprise environments?

This project demonstrates enterprise-scale endpoint management by combining Microsoft Intune, PowerShell, Windows Update, and security best practices to automate a complex remediation across thousands of devices while following Microsoft's official guidance.

