@echo off
setlocal

:: ============================================================================
:: PR-002 - Enterprise Co-management Recovery Automation
:: Author  : Narasimha Rao Jagadam
:: Purpose : Microsoft Entra ID Leave / Join Recovery
:: Version : Repository Edition v1.0
:: ============================================================================

set LOGFILE=%windir%\Temp\AAD_Rejoin.log

echo ============================================================= >> "%LOGFILE%"
echo Enterprise Co-management Recovery Started >> "%LOGFILE%"
echo Date: %DATE% %TIME% >> "%LOGFILE%"
echo ============================================================= >> "%LOGFILE%"

echo.
echo Checking Microsoft Entra ID Status...
dsregcmd /status >> "%LOGFILE%" 2>&1

echo.
echo Leaving Microsoft Entra ID...
dsregcmd /leave >> "%LOGFILE%" 2>&1

echo.
echo Rejoining Microsoft Entra ID...
dsregcmd /join >> "%LOGFILE%" 2>&1

echo.
echo Collecting updated Microsoft Entra ID status...
dsregcmd /status >> "%LOGFILE%" 2>&1

echo.
echo Recovery process completed.
echo Review log file:
echo %LOGFILE%

echo ============================================================= >> "%LOGFILE%"
echo Recovery Completed >> "%LOGFILE%"
echo ============================================================= >> "%LOGFILE%"

exit /b 0
