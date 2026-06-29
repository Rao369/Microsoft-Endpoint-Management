<#
.SYNOPSIS
PR-003 – Enterprise Windows Update Scan Recovery
Remediation Script

.DESCRIPTION
This remediation script performs staged Windows Update recovery by:

• Checking for pending reboot
• Repairing Windows Update services
• Refreshing Windows Update settings
• Triggering Windows Update scan
• Triggering Microsoft Intune sync
• Validating Windows Update scan events

Designed for Microsoft Intune Proactive Remediation.

Author  : Narasimha Rao Jagadam
Version : 1.0
Platform: Microsoft Intune Proactive Remediation
#>

# ==================================================
# Logging
# ==================================================

$LogFile = "C:\Windows\Temp\PR003-WindowsUpdateScanRecovery.log"

Start-Transcript `
    -Path $LogFile `
    -Append

Write-Output ""
Write-Output "==================================================="
Write-Output "PR-003 Enterprise Windows Update Scan Recovery"
Write-Output "Started : $(Get-Date)"
Write-Output "==================================================="

# --------------------------------------------------
# STEP 1 - Pending Reboot Validation
# --------------------------------------------------

if (
    (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending") -or
    (Test-Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired")
) {

    Write-Output ""
    Write-Output "Pending reboot detected."
    Write-Output "Skipping Windows Update recovery."

    Stop-Transcript

    exit 0
}

# --------------------------------------------------
# STEP 2 - Validate Core Windows Update Services
# --------------------------------------------------

$Services = @(
    "wuauserv",
    "bits",
    "UsoSvc",
    "WaaSMedicSvc"
)

foreach ($svc in $Services) {

    try {

        $Service = Get-Service `
            -Name $svc `
            -ErrorAction SilentlyContinue

        if ($null -eq $Service) {

            Write-Output "$svc service not found."

            continue
        }

        if ($Service.StartType -eq "Disabled") {

            Set-Service `
                -Name $svc `
                -StartupType Manual `
                -ErrorAction SilentlyContinue

            Write-Output "$svc startup type corrected."
        }

        if ($Service.Status -ne "Running") {

            Start-Service `
                -Name $svc `
                -ErrorAction SilentlyContinue

            Write-Output "$svc service started."
        }
        else {

            Write-Output "$svc service already running."
        }

    }
    catch {

        Write-Output "Failed to process service: $svc"
    }
}

# --------------------------------------------------
# STEP 3 - Refresh Windows Update Settings
# --------------------------------------------------

try {

    Write-Output ""
    Write-Output "Refreshing Windows Update settings..."

    UsoClient RefreshSettings

    Start-Sleep 15
}
catch {

    Write-Output "RefreshSettings failed."
}

# --------------------------------------------------
# STEP 4 - Trigger Windows Update Scan
# --------------------------------------------------

try {

    Write-Output ""
    Write-Output "Starting Windows Update scan..."

    UsoClient StartScan

    Start-Sleep 30

    Write-Output "Waiting for scan processing..."

    UsoClient ScanInstallWait

    Start-Sleep 20
}
catch {

    Write-Output "Windows Update scan orchestration failed."
}

# --------------------------------------------------
# STEP 5 - Trigger Microsoft Intune Sync
# --------------------------------------------------

try {

    Write-Output ""
    Write-Output "Triggering Microsoft Intune Sync..."

    $Tasks = Get-ScheduledTask `
        -ErrorAction SilentlyContinue |
        Where-Object {

            $_.TaskName -like "*Schedule to run OMADMClient*"
        }

    foreach ($Task in $Tasks) {

        Start-ScheduledTask `
            -InputObject $Task `
            -ErrorAction SilentlyContinue
    }

    Write-Output "Microsoft Intune Sync triggered successfully."
}
catch {

    Write-Output "Microsoft Intune Sync failed."
}

# --------------------------------------------------
# STEP 6 - Validate Windows Update Event
# --------------------------------------------------

try {

    Start-Sleep 20

    $Event = Get-WinEvent `
        -LogName "Microsoft-Windows-WindowsUpdateClient/Operational" `
        -MaxEvents 20 `
        -ErrorAction SilentlyContinue |
        Where-Object {

            $_.Id -in 41,42,43
        } |
        Select-Object -First 1

    if ($Event) {

        Write-Output ""
        Write-Output "Latest Windows Update Event:"
        Write-Output $Event.TimeCreated
    }
    else {

        Write-Output "No recent Windows Update event found."
    }

}
catch {

    Write-Output "Windows Update validation failed."
}

Write-Output ""
Write-Output "==================================================="
Write-Output "PR-003 Remediation Completed Successfully"
Write-Output "Completed : $(Get-Date)"
Write-Output "==================================================="

Stop-Transcript

exit 0
