## Project Evidence

### 1. Initial Enterprise Assessment

The initial enterprise assessment categorized devices based on Secure Boot status and certificate readiness.

The assessment identified devices with:

* Certificates Active
* Certificates Inactive
* Certificates Missing
* Secure Boot Enabled
* Secure Boot Disabled

This assessment was used to determine the appropriate remediation strategy based on Microsoft's guidance.


---

### 2. Intune Proactive Remediation Deployment

The enterprise solution consisted of two Microsoft Intune Proactive Remediation packages:

* **Windows Secure Boot Certificate Readiness (2026)** – Audit package
* **PR_SecureBoot_Cert_Enablement_Fix** – Remediation package

Both packages were deployed through Microsoft Intune to assess Secure Boot readiness and automatically configure eligible devices.


---

### 3. Secure Boot Compliance Improvement

Following deployment and Windows Update servicing, Secure Boot certificate compliance improved significantly across the enterprise.

The dashboard below compares the initial compliance status with the final compliance after remediation.


---

### 4. Microsoft Guidance

This implementation followed Microsoft's official guidance for Secure Boot Certificate expiration (2026), specifically the recommended Option 2 deployment model.
https://techcommunity.microsoft.com/blog/windows-itpro-blog/secure-boot-playbook-for-certificates-expiring-in-2026/4469235#community-4469235-_option2
https://support.microsoft.com/en-us/topic/windows-secure-boot-certificate-expiration-and-ca-updates-7ff40d33-95dc-4c3c-8725-a9b95457578e
