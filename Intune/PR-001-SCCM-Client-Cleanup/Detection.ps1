<#
.SYNOPSIS
    Detects the presence of the Microsoft Endpoint Configuration Manager (MECM/SCCM) client.

.DESCRIPTION
    This detection script is intended for use with Microsoft Intune Proactive Remediations.
    It checks for common MECM/SCCM client components.

.AUTHOR
    Narasimha Rao Jagadam

.VERSION
    2.0

.NOTES
    Exit Code 0 = SCCM Client Not Detected
    Exit Code 1 = SCCM Client Detected (Remediation Required)
#>

#region Variables

$CCMFolder          = "C:\Windows\CCM"
$CCMExecutable      = "C:\Windows\CCM\CCMExec.exe"
$StartMenuFolder    = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Configuration Manager"

#endregion

#region Detection

Write-Output "Starting SCCM Client Detection..."

$ClientDetected = $false

if (Test-Path $CCMFolder) {
    Write-Output "Detected: SCCM installation folder."
    $ClientDetected = $true
}

if (Test-Path $CCMExecutable) {
    Write-Output "Detected: CCMExec executable."
    $ClientDetected = $true
}

if (Test-Path $StartMenuFolder) {
    Write-Output "Detected: SCCM Start Menu folder."
    $ClientDetected = $true
}

#endregion

#region Result

if ($ClientDetected) {

    Write-Output "Result: SCCM Client detected. Remediation required."
    exit 1

}
else {

    Write-Output "Result: SCCM Client not detected."
    exit 0

}

#endregion
