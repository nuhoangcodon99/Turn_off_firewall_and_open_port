# Kiểm tra xem script có đang chạy với quyền quản trị hay không
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Nếu không có quyền quản trị, yêu cầu quyền quản trị
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Exit
}

# Hiển thị thông báo bắt đầu tắt Firewall
Write-Host "Tắt Windows Defender Firewall..."

# Tắt Windows Defender Firewall cho tất cả các profile (Domain, Private, Public)
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Hiển thị thông báo hoàn thành
Write-Host "Windows Defender Firewall đã được tắt."

# Dừng lại và chờ người dùng nhấn phím để kết thúc
Write-Host "Nhấn phím bất kỳ để thoát..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
