# Interview Questions

## Q1

Why did you create this solution?

### Answer

To automate the removal of legacy MECM/SCCM clients after migrating devices to Microsoft Intune, reducing manual effort and ensuring consistent endpoint management.

---

## Q2

Why use Proactive Remediation instead of a Win32 application?

### Answer

Proactive Remediations provide built-in detection, recurring health checks, automated remediation, and reporting without requiring application packaging.

---

## Q3

Why return Exit Code 1?

### Answer

Exit Code 1 tells Intune that remediation is required. Exit Code 0 indicates the device is compliant.

---

## Q4

Why remove the WMI namespace?

### Answer

Residual WMI namespaces can interfere with SCCM functionality and should be removed after a successful migration.

---

## Q5

How did you validate success?

### Answer

The script validates that the SCCM installation folder is removed, the client service no longer exists, and the detection script subsequently returns Exit Code 0.
