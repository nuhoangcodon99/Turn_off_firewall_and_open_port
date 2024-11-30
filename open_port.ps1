# Check if the script is running with administrative privileges
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # If not, request administrative privileges
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Exit
}

# Display a message indicating the start of port configuration
Write-Host "Opening required ports in Windows Firewall..." -ForegroundColor Green

# List of ports to open
$ports = @(80, 443, 3306, 14445)

# Loop through each port and open it
foreach ($port in $ports) {
    Write-Host "Opening port $port..."
    Try {
        New-NetFirewallRule -DisplayName "Open Port $port" -Direction Inbound -LocalPort $port -Protocol TCP -Action Allow -ErrorAction Stop
        Write-Host "Port $port opened successfully." -ForegroundColor Green
    } Catch {
        Write-Host "Failed to open port $port: $_" -ForegroundColor Red
    }
}

# Display completion message
Write-Host "All required ports have been opened." -ForegroundColor Green

# Pause to wait for user input before exiting
Write-Host "Press any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
