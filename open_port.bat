@echo off

REM Mở cổng 80 (HTTP)
netsh advfirewall firewall add rule name="Open Port 80" protocol=TCP dir=in localport=80 action=allow
netsh advfirewall firewall add rule name="Open Port 80" protocol=TCP dir=out localport=80 action=allow

REM Mở cổng 443 (HTTPS)
netsh advfirewall firewall add rule name="Open Port 443" protocol=TCP dir=in localport=443 action=allow
netsh advfirewall firewall add rule name="Open Port 443" protocol=TCP dir=out localport=443 action=allow

REM Mở cổng 3306 (SQL)
netsh advfirewall firewall add rule name="Open Port 3306" protocol=TCP dir=in localport=3306 action=allow
netsh advfirewall firewall add rule name="Open Port 3306" protocol=TCP dir=out localport=3306 action=allow

REM Mở cổng 14445 (Custom)
netsh advfirewall firewall add rule name="Open Port 14445" protocol=TCP dir=in localport=14445 action=allow
netsh advfirewall firewall add rule name="Open Port 14445" protocol=TCP dir=out localport=14445 action=allow

echo Các cổng đã được mở.
pause
