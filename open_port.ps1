# Kiểm tra xem script có đang chạy với quyền quản trị hay không
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Nếu không có quyền quản trị, yêu cầu quyền quản trị
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Exit
}

# Hiển thị thông báo bắt đầu mở các port
Write-Host "Mở các port cần thiết trên Windows Firewall..."

# Mở port 80
Write-Host "Mở port 80..."
New-NetFirewallRule -DisplayName "Open Port 80" -Direction Inbound -LocalPort 80 -Protocol TCP -Action Allow

# Mở port 443
Write-Host "Mở port 443..."
New-NetFirewallRule -DisplayName "Open Port 443" -Direction Inbound -LocalPort 443 -Protocol TCP -Action Allow

# Mở port 3306
Write-Host "Mở port 3306..."
New-NetFirewallRule -DisplayName "Open Port 3306" -Direction Inbound -LocalPort 3306 -Protocol TCP -Action Allow

# Mở port 14445
Write-Host "Mở port 14445..."
New-NetFirewallRule -DisplayName "Open Port 14445" -Direction Inbound -LocalPort 14445 -Protocol TCP -Action Allow

# Hiển thị thông báo hoàn thành
Write-Host "Đã mở tất cả các port."

# Dừng lại và chờ người dùng nhấn phím để kết thúc
Write-Host "Nhấn phím bất kỳ để thoát..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
