# Enterprise Recovery Workflow

```text
                    Enterprise Co-management Recovery

+--------------------------------------------------------------+
|                      Windows Device                           |
+--------------------------------------------------------------+
                           |
                           v
              Device remains Co-managed
                           |
                           v
                Validate dsregcmd /status
                           |
                           v
             Microsoft Entra Joined = YES
                           |
                           v
        Deploy Recovery Package using MECM Application
                           |
          +----------------+----------------+
          |                                 |
          v                                 v
   Microsoft Entra Leave           Reinstall SCCM Client
          |                                 |
          +----------------+----------------+
                           |
                           v
            Create Scheduled Task (SYSTEM)
                           |
                           v
                 Restart Windows Device
                           |
                           v
                Execute dsregcmd /join
                           |
                           v
               Validate Device Health
                           |
                           v
        Device Successfully Managed by Intune
```
