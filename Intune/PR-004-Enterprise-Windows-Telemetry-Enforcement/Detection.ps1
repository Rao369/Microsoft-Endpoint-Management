```powershell
<#
.SYNOPSIS
PR-004 – Enterprise Windows Telemetry Enforcement
Detection Script

.DESCRIPTION
Validates the required Windows diagnostic data registry
configuration used by Windows Update for Business reporting.

The script checks:

• AllowTelemetry
• AllowUpdateComplianceProcessing
• AllowCommercialDataPipeline

If any required registry value is missing or incorrect,
Intune Proactive Remediation triggers remediation.

Author  : Narasimha Rao Jagadam
Version : 1.0
Platform: Microsoft Intune Proactive Remediation
#>

# -------------------------------------------------------
# Registry Location
# -------------------------------------------------------

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

# -------------------------------------------------------
# Required Configuration
# -------------------------------------------------------

$RequiredValues = @{
    "AllowTelemetry"                 = 3
    "AllowUpdateComplianceProcessing" = 1
    "AllowCommercialDataPipeline"     = 1
}

# -------------------------------------------------------
# Validate Registry Path
# -------------------------------------------------------

if (-not (Test-Path $RegPath)) {

    Write-Output "Registry path missing."

    exit 1
}

# -------------------------------------------------------
# Validate Registry Values
# -------------------------------------------------------

foreach ($Name in $RequiredValues.Keys) {

    try {

        $CurrentValue = (Get-ItemProperty `
            -Path $RegPath `
            -Name $Name `
            -ErrorAction Stop).$Name

        if ($CurrentValue -ne $RequiredValues[$Name]) {

            Write-Output "$Name is incorrectly configured."

            exit 1
        }

    }
    catch {

        Write-Output "$Name is missing."

        exit 1
    }
}

# -------------------------------------------------------
# Detection Successful
# -------------------------------------------------------

Write-Output "Telemetry configuration compliant."

exit 0
```
