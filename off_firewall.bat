@echo off
:: Tắt hiển thị các lệnh trong file batch
echo Tắt Windows Defender Firewall...

:: Kiểm tra và yêu cầu quyền quản trị
:: Tạo biến xác định nếu script đã có quyền quản trị
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
:: Xóa file tạm chứa script để lấy quyền quản trị
if exist "%temp%\getadmin.vbs" (del "%temp%\getadmin.vbs")

:: Lệnh tắt Windows Defender Firewall cho cả domain, private và public profile
netsh advfirewall set allprofiles state off

:: Hiển thị thông báo hoàn thành
echo Windows Defender Firewall đã được tắt.

:: Dừng lại và chờ người dùng nhấn phím để kết thúc
pause
exit
