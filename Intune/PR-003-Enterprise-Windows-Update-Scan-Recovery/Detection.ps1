<#
.SYNOPSIS
PR-003 – Enterprise Windows Update Scan Recovery
Detection Script

.DESCRIPTION
This detection script validates the health of Windows Update scanning by checking:

• Recent Windows Update scan events
• Windows Update related services
• Windows Update scan freshness

If any issue is detected, Intune Proactive Remediation triggers the remediation script.

Author  : Narasimha Rao Jagadam
Version : 1.0
Platform: Microsoft Intune Proactive Remediation
#>

$Issues = @()

# Maximum acceptable age (hours) for the last successful Windows Update event
$ThresholdHours = 72

# ------------------------------------------------
# STEP 1 - Validate Recent Windows Update Events
# ------------------------------------------------

try {

    $Event = Get-WinEvent `
        -LogName "Microsoft-Windows-WindowsUpdateClient/Operational" `
        -MaxEvents 50 `
        -ErrorAction SilentlyContinue |
        Where-Object {
            $_.Id -in 41,42,43
        } |
        Select-Object -First 1

    if ($Event) {

        $EventAge = ((Get-Date) - $Event.TimeCreated).TotalHours

        Write-Output "Latest Windows Update Event : $($Event.TimeCreated)"

        if ($EventAge -gt $ThresholdHours) {

            $Issues += "NoRecentWUEvent"
        }
    }
    else {

        $Issues += "NoWUEvents"
    }
}
catch {

    $Issues += "WUEventCheckFailed"
}

# ------------------------------------------------
# STEP 2 - Validate Windows Update Services
# ------------------------------------------------

$Services = @(
    "wuauserv",
    "bits",
    "UsoSvc"
)

foreach ($svc in $Services) {

    try {

        $Service = Get-Service `
            -Name $svc `
            -ErrorAction Stop

        if ($Service.Status -ne "Running") {

            $Issues += "$svc-Stopped"
        }
    }
    catch {

        $Issues += "$svc-Missing"
    }
}

# ------------------------------------------------
# FINAL RESULT
# ------------------------------------------------

if ($Issues.Count -gt 0) {

    Write-Output "Detection Failed"

    Write-Output ($Issues -join ", ")

    exit 1
}
else {

    Write-Output "Windows Update scan health validated successfully."

    exit 0
}
