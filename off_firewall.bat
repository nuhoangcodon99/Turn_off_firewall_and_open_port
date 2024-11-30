@echo off
:: Disable command display in the batch file
echo Turning off Windows Defender Firewall...

:: Check and request administrative privileges
:: Create a variable to determine if the script has admin rights
:checkPrivileges
NET FILE 1>NUL 2>NUL
if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
if '%1'=='ELEV' (shift & goto gotPrivileges)
ECHO Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
ECHO UAC.ShellExecute "cmd.exe", "/c %~s0 ELEV", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
exit /B

:gotPrivileges
:: Delete the temporary script for admin privileges
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")

:: Disable Windows Defender Firewall for all profiles (domain, private, and public)
echo Disabling Windows Defender Firewall for all profiles...
netsh advfirewall set allprofiles state off

:: Display a completion message
echo Windows Defender Firewall has been turned off.

:: Pause and wait for user input before exiting
pause
exit
