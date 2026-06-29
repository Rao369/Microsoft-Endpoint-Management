# INTERVIEW-QA – PR-005 Enterprise Windows Update Health Orchestrator

# PR-005 Interview Questions & Answers

---

## Q1. What business problem were you trying to solve?

**Answer:**

We observed recurring Windows Update issues across our enterprise environment, including:

* Devices below the approved monthly patch baseline
* Devices reporting **"Device Not Scanned"** in Windows Update reports
* Stopped Windows Update services
* Reduced patch compliance

To address these issues, I developed an Intune Proactive Remediation solution that continuously validated Windows Update health and automatically remediated common problems before they impacted compliance.

---

## Q2. Why did you use Microsoft Intune Proactive Remediation?

**Answer:**

Proactive Remediation allows automatic detection and remediation without requiring manual administrator intervention.

Benefits include:

* Scheduled execution
* Automatic remediation
* Centralized reporting
* Scalable deployment
* Enterprise-wide automation

---

## Q3. What does the detection script validate?

**Answer:**

The detection script validates:

* Windows Build (CurrentBuild)
* Update Build Revision (UBR)
* Recent Windows Update events
* Windows Update service status
* BITS service status
* Update Session Orchestrator (UsoSvc)

If any validation fails, Intune executes the remediation script.

---

## Q4. Why do you validate the UBR value?

**Answer:**

The UBR (Update Build Revision) identifies the installed cumulative update level.

Each month, Microsoft releases new cumulative updates that increase the UBR.

By comparing the device UBR against the approved monthly baseline, we can quickly identify devices that are behind the expected patch level.

---

## Q5. Why do you update the baseline every month?

**Answer:**

After each Patch Tuesday release, Microsoft publishes new cumulative updates.

The approved UBR values in the detection script must therefore be updated monthly so that compliance is measured against the current enterprise baseline.

---

## Q6. What does the remediation script do?

**Answer:**

The remediation performs staged recovery by:

1. Checking for pending reboot
2. Validating Windows Update services
3. Correcting service startup types if required
4. Starting stopped services
5. Refreshing Windows Update settings
6. Triggering Windows Update scan
7. Triggering download
8. Triggering installation
9. Performing advanced recovery when configured

---

## Q7. Which Windows Update services are validated?

**Answer:**

The remediation validates:

* Windows Update (wuauserv)
* Background Intelligent Transfer Service (BITS)
* Update Session Orchestrator (UsoSvc)
* Windows Update Medic Service (WaaSMedicSvc)

---

## Q8. Why is a pending reboot check important?

**Answer:**

If Windows already requires a restart, additional remediation may interfere with the update process.

The script exits gracefully when a reboot is pending, allowing Windows Update to complete normally.

---

## Q9. Why did you use USOClient?

**Answer:**

USOClient interacts with the Windows Update Orchestrator.

The remediation uses it to:

* Refresh update settings
* Start update scans
* Start downloads
* Initiate installation

This helps resume the standard Windows Update workflow without manual intervention.

---

## Q10. Why perform staged remediation instead of immediately running DISM and SFC?

**Answer:**

SFC and DISM are resource-intensive operations.

Running them on every device would increase execution time and unnecessary system load.

A staged approach performs lightweight recovery first and reserves advanced repair for devices with persistent issues.

---

## Q11. What is the purpose of SoftwareDistribution and Catroot2 reset?

**Answer:**

These folders contain Windows Update metadata, downloaded content, and update catalog information.

Corruption within these folders can cause Windows Update failures.

Resetting them forces Windows to rebuild its update cache.

---

## Q12. What logging does the solution provide?

**Answer:**

The remediation records execution details in:

```text
C:\ProgramData\IntunePR\WU_Master.log
```

The log includes:

* Execution time
* Service validation
* Windows Update actions
* Recovery actions
* Completion status

This simplifies troubleshooting and operational review.

---

## Q13. How was the solution deployed?

**Answer:**

The solution was deployed through Microsoft Intune Proactive Remediation.

Configuration:

* Execution Context: SYSTEM
* Assignment: Common_DYN_WKS_All_Autopilot_Devices
* Schedule: Daily
* Repeat Interval: Every 3 Days

---

## Q14. What measurable improvements did this solution deliver?

**Answer:**

Following deployment:

* Patch compliance improved from approximately **91% to 97%**
* Devices reporting **"Device Not Scanned"** reduced from approximately **800 to 150**

The solution reduced manual troubleshooting while improving Windows Update health across the environment.

---

## Q15. What would you improve in the next version?

**Answer:**

Potential enhancements include:

* Automatic maintenance of remediation state information
* Modular remediation engine
* Decision-based recovery workflows
* Enhanced reporting and telemetry
* Integration with enterprise monitoring dashboards

These improvements would increase automation while keeping the production deployment stable.

---

# Interview Summary

This project demonstrates experience with:

* Microsoft Intune
* Windows Update for Business (WUfB)
* Microsoft Entra ID
* Enterprise PowerShell automation
* Windows Update troubleshooting
* Service remediation
* Enterprise deployment strategies
* Patch compliance optimization
* Operational monitoring
* Large-scale endpoint management

It also showcases the ability to design and implement automated remediation solutions that improve compliance and reduce operational overhead in a production environment.

