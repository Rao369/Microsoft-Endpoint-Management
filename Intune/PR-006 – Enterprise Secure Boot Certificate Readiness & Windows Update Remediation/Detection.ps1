# <#

PR-006 – Enterprise Secure Boot Certificate Readiness
Detection Script
================

Purpose:
Detect whether the Windows Update registry configuration
required for Microsoft Secure Boot Certificate updates
(Option 2) is correctly configured.

If any required registry value is missing or incorrect,
the device is marked as non-compliant.

Author:
Narasimha Rao Jagadam
=====================

#>

$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection"

$RequiredValues = @{
"AllowTelemetry" = 3
"AllowUpdateComplianceProcessing" = 1
"AllowCommercialDataPipeline" = 1
}

# Registry path validation

if (-not (Test-Path $RegPath)) {

```
Write-Output "Registry path missing."
exit 1
```

}

# Validate required registry values

foreach ($Name in $RequiredValues.Keys) {

```
try {

    $CurrentValue = (Get-ItemProperty `
        -Path $RegPath `
        -Name $Name `
        -ErrorAction Stop).$Name

    if ($CurrentValue -ne $RequiredValues[$Name]) {

        Write-Output "$Name is not configured correctly."
        exit 1
    }
}
catch {

    Write-Output "$Name is missing."
    exit 1
}
```

}

Write-Output "Secure Boot certificate prerequisites are compliant."

exit 0

