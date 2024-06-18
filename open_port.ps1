# Define a function to open ports
function Open-Ports {
    param (
        [int[]]$Ports
    )

    foreach ($port in $Ports) {
        # Mở cổng vào (Inbound)
        New-NetFirewallRule -DisplayName "Open Port $port Inbound" -Direction Inbound -Protocol TCP -LocalPort $port -Action Allow
        # Mở cổng ra (Outbound)
        New-NetFirewallRule -DisplayName "Open Port $port Outbound" -Direction Outbound -Protocol TCP -LocalPort $port -Action Allow
    }
}

# Gọi hàm Open-Ports với các cổng cần mở
Open-Ports -Ports @(80, 443, 3306, 14445)
