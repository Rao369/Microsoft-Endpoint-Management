# Interview Questions & Answers

## Q1. What problem did this project solve?

During an enterprise migration from MECM Co-management to Microsoft Intune, approximately 580 devices remained in a Co-managed state instead of transitioning to full Intune management.

---

## Q2. How did you investigate?

We first validated the device using:

- dsregcmd /status
- Microsoft Intune Portal
- MECM Console
- SCCM Client Health

The devices were already Microsoft Entra joined.

---

## Q3. What recovery process did you implement?

The recovery workflow included:

- Microsoft Entra Leave
- Microsoft Entra Join
- SCCM Client Reinstallation
- Device Restart
- Validation of Intune Management

---

## Q4. Why was PSAppDeployToolkit used?

PSAppDeployToolkit provided:

- Standardized deployment
- Enterprise logging
- Silent execution
- SYSTEM context
- Integration with MECM

---

## Q5. Why create a Scheduled Task?

The scheduled task ensured the Microsoft Entra Join command executed under the SYSTEM account after deployment, improving reliability.

---

## Q6. What lessons did you learn?

Not every migration issue has an immediately identifiable root cause. We validated the recovery workflow through pilot testing before deploying it at scale, ensuring a reliable operational solution.

---

## Q7. How did you validate success?

- Microsoft Entra Join = YES
- SCCM Client healthy
- Device synchronized successfully
- Device transitioned to Intune managed
