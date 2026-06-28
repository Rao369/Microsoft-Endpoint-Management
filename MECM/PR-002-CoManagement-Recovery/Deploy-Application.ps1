<#
================================================================================

Project      : PR-002 - Enterprise Co-management Recovery Automation
Author       : Narasimha Rao Jagadam
Repository   : Microsoft-Endpoint-Management
Deployment   : MECM Application
Framework    : PSAppDeployToolkit

================================================================================

DESCRIPTION

This deployment package automates the recovery of Windows devices that remain
in a Co-managed state during migration from Microsoft Endpoint Configuration
Manager (MECM) to Microsoft Intune.

The deployment performs the following high-level actions:

1. Execute Microsoft Entra ID recovery (Leave / Join)
2. Create a scheduled task to retry Microsoft Entra Join
3. Allow Configuration Manager client reinstallation
4. Complete recovery after device restart
5. Validate successful transition to Intune management

This repository edition demonstrates the deployment workflow used in enterprise
environments. Customer-specific information has been removed.

================================================================================
#>

Write-Host "====================================================="
Write-Host " Enterprise Co-management Recovery Automation"
Write-Host "====================================================="

Write-Host ""
Write-Host "Step 1 - Running Microsoft Entra Recovery"

cmd.exe /c ".\Dsregcmd.cmd"

Write-Host ""
Write-Host "Step 2 - Creating Scheduled Task"

$Action = New-ScheduledTaskAction `
    -Execute "cmd.exe" `
    -Argument "/c dsregcmd /join"

$Trigger = New-ScheduledTaskTrigger `
    -Once `
    -At (Get-Date).AddMinutes(5)

$Principal = New-ScheduledTaskPrincipal `
    -UserId "SYSTEM" `
    -RunLevel Highest

Register-ScheduledTask `
    -TaskName "Enterprise_AAD_Rejoin" `
    -Description "Enterprise Co-management Recovery" `
    -Action $Action `
    -Trigger $Trigger `
    -Principal $Principal `
    -Force

Write-Host ""
Write-Host "Scheduled Task Created Successfully"

Write-Host ""
Write-Host "Recovery Package Completed."

exit 0
