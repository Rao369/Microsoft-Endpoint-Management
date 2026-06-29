# <#

PR-006 – Enterprise Secure Boot Certificate Readiness
Windows Update Remediation Script
=================================

Purpose:
Configure the Windows Update registry settings required
for Microsoft Secure Boot Certificate deployment
(Option 2).

This remediation prepares eligible Windows devices to
receive updated Secure Boot certificates through normal
Windows Update servicing.

This script does NOT enable Secure Boot. Devices with
Secure Boot disabled require manual enablement in UEFI/BIOS.

Reference:
Microsoft Secure Boot Certificate Expiration (2026)
Option 2 Guidance

Author:
Narasimha Rao Jagadam
=====================

#>

# --------------------------------------------------

# Logging

# --------------------------------------------------

$LogFolder = "C:\ProgramData\IntunePR"
$LogFile = "$LogFolder\PR006_SecureBoot_Remediation.log"

if (-not (Test-Path $LogFolder)) {
New-Item -ItemType Directory -Path $LogFolder -Force | Out-Null
}

function Write-PRLog {
param([string]$Message)

```
$Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

"$Time | $Message" | Out-File `
    -FilePath $LogFile `
    -Append `
    -Encoding UTF8

Write-Output $Message
```

}

Write-PRLog "===== Secure Boot Certificate Remediation Started ====="

# --------------------------------------------------

# Registry Path

# --------------------------------------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

if (-not (Test-Path $RegPath)) {

```
New-Item `
    -Path $RegPath `
    -Force | Out-Null

Write-PRLog "Created registry path."
```

}

# --------------------------------------------------

# Configure Required Registry Values

# --------------------------------------------------

$RequiredValues = @{

```
AllowTelemetry                   = 3

AllowUpdateComplianceProcessing  = 1

AllowCommercialDataPipeline      = 1
```

}

foreach ($Item in $RequiredValues.GetEnumerator()) {

```
try {

    New-ItemProperty `
        -Path $RegPath `
        -Name $Item.Key `
        -Value $Item.Value `
        -PropertyType DWord `
        -Force | Out-Null

    Write-PRLog "$($Item.Key) configured successfully."
}
catch {

    Write-PRLog "Failed configuring $($Item.Key)."
}
```

}

# --------------------------------------------------

# Completion

# --------------------------------------------------

Write-PRLog "Registry configuration completed."

Write-PRLog "Eligible devices will receive Secure Boot certificate updates through Windows Update servicing."

Write-PRLog "===== Remediation Completed Successfully ====="

exit 0

