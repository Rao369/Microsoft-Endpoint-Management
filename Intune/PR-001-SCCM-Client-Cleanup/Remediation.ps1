<#
.SYNOPSIS
    Removes Microsoft Endpoint Configuration Manager (MECM/SCCM) client remnants.

.DESCRIPTION
    This remediation script is intended for Microsoft Intune Proactive Remediations.
    It removes legacy MECM/SCCM client components after migration to Microsoft Intune.

.AUTHOR
    Narasimha Rao Jagadam

.VERSION
    2.0

.NOTES
    Test thoroughly before deploying to production.
#>

#region Logging

$LogFolder = "C:\ProgramData\Microsoft\IntuneManagementExtension\Logs"
$LogFile = Join-Path $LogFolder "PR001-SCCMCleanup.log"

if (!(Test-Path $LogFolder)) {
    New-Item -ItemType Directory -Path $LogFolder -Force | Out-Null
}

function Write-Log {

    param(
        [string]$Message
    )

    $Time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    "$Time : $Message" | Out-File $LogFile -Append -Encoding UTF8
    Write-Output $Message
}

#endregion

#region Functions

function Start-SCCMUninstall {

    Write-Log "Checking for SCCM uninstall executable..."

    $CCMSetup = "C:\Windows\CCMSetup\CCMSetup.exe"

    if (Test-Path $CCMSetup) {

        Write-Log "Starting SCCM Client uninstall..."

        Start-Process `
            -FilePath $CCMSetup `
            -ArgumentList "/uninstall" `
            -Wait `
            -NoNewWindow

        Write-Log "SCCM uninstall process completed."
    }
    else {

        Write-Log "CCMSetup.exe not found."

    }
}

function Stop-SCCMServices {

    $Services = @(
        "CcmExec",
        "CCMSetup",
        "smstsmgr",
        "CmRcService"
    )

    foreach ($Service in $Services) {

        if (Get-Service $Service -ErrorAction SilentlyContinue) {

            Write-Log "Stopping service: $Service"

            Stop-Service $Service -Force -ErrorAction SilentlyContinue
        }
    }
}

function Remove-SCCMWMINamespace {

    Write-Log "Removing SCCM WMI namespaces..."

    Get-WmiObject `
        -Query "SELECT * FROM __Namespace WHERE Name='ccm'" `
        -Namespace root `
        -ErrorAction SilentlyContinue |
        Remove-WmiObject -ErrorAction SilentlyContinue

    Get-WmiObject `
        -Query "SELECT * FROM __Namespace WHERE Name='sms'" `
        -Namespace root\cimv2 `
        -ErrorAction SilentlyContinue |
        Remove-WmiObject -ErrorAction SilentlyContinue
}

function Remove-SCCMRegistry {

    Write-Log "Removing SCCM registry entries..."

    $RegistryKeys = @(

        "HKLM:\SYSTEM\CurrentControlSet\Services\CCMSetup",
        "HKLM:\SYSTEM\CurrentControlSet\Services\CcmExec",
        "HKLM:\SYSTEM\CurrentControlSet\Services\smstsmgr",
        "HKLM:\SYSTEM\CurrentControlSet\Services\CmRcService",

        "HKLM:\SOFTWARE\Microsoft\CCM",
        "HKLM:\SOFTWARE\Microsoft\CCMSetup",
        "HKLM:\SOFTWARE\Microsoft\SMS",
        "HKLM:\SOFTWARE\Microsoft\DeviceManageabilityCSP"

    )

    foreach ($Key in $RegistryKeys) {

        Remove-Item `
            -Path $Key `
            -Recurse `
            -Force `
            -ErrorAction SilentlyContinue
    }
}

function Remove-SCCMFolders {

    Write-Log "Removing SCCM folders..."

    $Folders = @(

        "C:\Windows\CCM",
        "C:\Windows\CCMSetup",
        "C:\Windows\CCMCache",
        "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Configuration Manager"

    )

    foreach ($Folder in $Folders) {

        Remove-Item `
            -Path $Folder `
            -Recurse `
            -Force `
            -ErrorAction SilentlyContinue
    }

    Remove-Item `
        "C:\Windows\SMSCFG.ini" `
        -Force `
        -ErrorAction SilentlyContinue

    Remove-Item `
        "C:\Windows\SMS*.mif" `
        -Force `
        -ErrorAction SilentlyContinue
}

function Validate-Cleanup {

    Write-Log "Validating cleanup..."

    if (Test-Path "C:\Windows\CCM") {

        Write-Log "Validation failed."

        exit 1
    }

    Write-Log "Validation successful."

    exit 0
}

#endregion

#region Main

Write-Log "========== PR-001 Started =========="

Start-SCCMUninstall

Stop-SCCMServices

Remove-SCCMWMINamespace

Remove-SCCMRegistry

Remove-SCCMFolders

Validate-Cleanup

Write-Log "========== PR-001 Completed =========="

#endregion
