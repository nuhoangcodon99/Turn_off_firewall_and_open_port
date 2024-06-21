@echo off
:: Tắt hiển thị các lệnh trong file batch
echo Mở các port cần thiết trên Windows Firewall...

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

:: Mở các port lần lượt
echo Mở port 80...
netsh advfirewall firewall add rule name="Open Port 80" protocol=TCP dir=in localport=80 action=allow

echo Mở port 443...
netsh advfirewall firewall add rule name="Open Port 443" protocol=TCP dir=in localport=443 action=allow

echo Mở port 3306...
netsh advfirewall firewall add rule name="Open Port 3306" protocol=TCP dir=in localport=3306 action=allow

echo Mở port 14445...
netsh advfirewall firewall add rule name="Open Port 14445" protocol=TCP dir=in localport=14445 action=allow

:: Hiển thị thông báo hoàn thành
echo Đã mở tất cả các port.

:: Dừng lại và chờ người dùng nhấn phím để kết thúc
pause
exit
