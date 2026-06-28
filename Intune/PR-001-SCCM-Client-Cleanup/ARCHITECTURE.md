# Solution Architecture

```

```
                    Microsoft Intune
                           │
                           │
                Proactive Remediation
                           │
          ┌────────────────┴───────────────┐
          │                                │
          ▼                                ▼
 Detection.ps1                    Exit Code 0
          │
          │
          ▼
 Exit Code 1
          │
          ▼
 Remediation.ps1
          │
          ├───────────────┐
          │               │
          ▼               ▼
 SCCM Uninstall      Stop Services
          │               │
          ├───────────────┤
          ▼
 Remove WMI
          │
          ▼
 Remove Registry
          │
          ▼
 Remove Folders
          │
          ▼
 Validation
          │
          ▼
 Intune Managed Device
```

---

## Workflow

1. Detection script runs.

2. SCCM client detected.

3. Intune starts remediation.

4. Native uninstall executed.

5. Remaining artifacts removed.

6. Validation performed.

7. Device becomes fully Intune managed.
