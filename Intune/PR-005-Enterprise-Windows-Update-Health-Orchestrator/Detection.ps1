```powershell
<#
=========================================================================================
PR-005 – Enterprise Windows Update Health Orchestrator
Detection Script

Version      : 1.1
Author       : Narasimha Rao Jagadam
Platform     : Microsoft Intune Proactive Remediation
Run Context  : SYSTEM

Description:
This detection script validates the overall Windows Update health of an endpoint.

Validation includes:
- Windows Build & UBR compliance
- Recent Windows Update scan activity
- Windows Update core services

Exit Codes:
0 = Healthy
1 = Remediation Required

Production Notes:
This script was used in production as part of an enterprise Windows Update
health monitoring solution. The monthly UBR baseline should be updated
after each Microsoft Patch Tuesday release.
=========================================================================================
#>

# --------------------------------------------------
# Configuration
# --------------------------------------------------

$Issues = @()

# Monthly supported Build -> Minimum UBR
# Update these values after each monthly patch cycle.
$Baselines = @{
    26100 = 8655
    22631 = 7219
    19045 = 7417
}

# --------------------------------------------------
# STEP 1 - Windows Build & Patch Compliance
# --------------------------------------------------

try {

    $OS = Get-ItemProperty `
        "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion"

    $Build = [int]$OS.CurrentBuild
    $UBR   = [int]$OS.UBR

    Write-Output "Detected Windows Version : $Build.$UBR"

    if ($Baselines.ContainsKey($Build)) {

        if ($UBR -lt $Baselines[$Build]) {

            $Issues += "PatchNonCompliant"

            Write-Output "Patch baseline not met."
        }
    }
    else {

        Write-Output "Build not present in current baseline table."
    }
}
catch {

    $Issues += "UBRValidationFailed"
}

# --------------------------------------------------
# STEP 2 - Windows Update Activity Validation
# --------------------------------------------------

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

        $Age = ((Get-Date) - $Event.TimeCreated).TotalDays

        Write-Output "Latest Windows Update Event : $($Event.TimeCreated)"

        if ($Age -gt 7) {

            $Issues += "NoRecentWUEvents"
        }
    }
    else {

        $Issues += "NoWUEvents"
    }
}
catch {

    $Issues += "WUEventCheckFailed"
}

# --------------------------------------------------
# STEP 3 - Windows Update Service Validation
# --------------------------------------------------

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

# --------------------------------------------------
# Detection Result
# --------------------------------------------------

if ($Issues.Count -gt 0) {

    Write-Output ""
    Write-Output "Windows Update Health Issues Detected"

    $Issues | Sort-Object -Unique | ForEach-Object {

        Write-Output "- $_"
    }

    exit 1
}

Write-Output ""
Write-Output "Windows Update Health Validation Successful"

exit 0
```

