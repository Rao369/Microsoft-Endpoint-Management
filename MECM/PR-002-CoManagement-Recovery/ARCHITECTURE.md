User Device
      │
      ▼
Device remains Co-managed
      │
      ▼
Validate dsregcmd /status
      │
      ▼
Microsoft Entra Joined = YES
      │
      ▼
Run Recovery Package
      │
      ├── Leave Entra
      ├── Join Entra
      ├── Create Scheduled Task
      ├── Reinstall SCCM Client
      └── Restart
      │
      ▼
Validation
      │
      ▼
Intune Managed
