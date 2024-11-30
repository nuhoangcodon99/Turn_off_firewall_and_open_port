@echo off
:: Disable command echoing
echo Opening required ports in Windows Firewall...

:: Check and request administrative privileges
:checkPrivileges
whoami /groups | find "S-1-16-12288" >nul 2>&1
if errorlevel 1 (
    echo This script requires administrative privileges. Requesting...
    goto getPrivileges
)

:getPrivileges
if '%1'=='ELEV' (shift & goto gotPrivileges)
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
ECHO UAC.ShellExecute "cmd.exe", "/c %~s0 ELEV", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
goto cleanup

:gotPrivileges
:: Cleanup temporary files if they exist
:cleanup
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")

:: Open required ports
set ports=80 443 3306 14445
for %%p in (%ports%) do (
    echo Opening port %%p...
    netsh advfirewall firewall delete rule name="Open Port %%p" >nul 2>&1
    netsh advfirewall firewall add rule name="Open Port %%p" protocol=TCP dir=in localport=%%p action=allow
    if errorlevel 1 (
        echo Error occurred while opening port %%p.
    ) else (
        echo Port %%p successfully opened.
    )
)

:: Display completion message
echo All required ports have been opened.
pause
exit
