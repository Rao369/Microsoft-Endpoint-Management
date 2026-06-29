```powershell
<#
.SYNOPSIS
PR-004 – Enterprise Windows Telemetry Enforcement
Remediation Script

.DESCRIPTION

Creates and enforces the required Windows telemetry
registry configuration for Windows Update for Business.

The remediation:

• Creates the DataCollection registry path if required
• Configures diagnostic data settings
• Enables Update Compliance processing
• Enables Commercial Data Pipeline

Designed for Microsoft Intune Proactive Remediation.

Author  : Narasimha Rao Jagadam
Version : 1.0
Platform: Microsoft Intune Proactive Remediation
#>

# -------------------------------------------------------
# Logging
# -------------------------------------------------------

$LogFile = "C:\Windows\Temp\PR004-TelemetryEnforcement.log"

Start-Transcript `
    -Path $LogFile `
    -Append

Write-Output ""
Write-Output "==============================================="
Write-Output "PR-004 Enterprise Windows Telemetry Enforcement"
Write-Output "Started : $(Get-Date)"
Write-Output "==============================================="

# -------------------------------------------------------
# Registry Location
# -------------------------------------------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# -------------------------------------------------------
# Create Registry Path
# -------------------------------------------------------

if (-not (Test-Path $RegPath)) {

    New-Item `
        -Path $RegPath `
        -Force | Out-Null

    Write-Output "Created registry path."
}

# -------------------------------------------------------
# Configure Registry Values
# -------------------------------------------------------

New-ItemProperty `
    -Path $RegPath `
    -Name "AllowTelemetry" `
    -Value 3 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Output "Configured AllowTelemetry."

New-ItemProperty `
    -Path $RegPath `
    -Name "AllowUpdateComplianceProcessing" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Output "Configured AllowUpdateComplianceProcessing."

New-ItemProperty `
    -Path $RegPath `
    -Name "AllowCommercialDataPipeline" `
    -Value 1 `
    -PropertyType DWord `
    -Force | Out-Null

Write-Output "Configured AllowCommercialDataPipeline."

# -------------------------------------------------------
# Completion
# -------------------------------------------------------

Write-Output ""
Write-Output "Telemetry registry configuration completed successfully."

Write-Output ""
Write-Output "==============================================="
Write-Output "Completed : $(Get-Date)"
Write-Output "==============================================="

Stop-Transcript

exit 0
```
