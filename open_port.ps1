New-NetFirewallRule -DisplayName "Open Port 80" -Direction Inbound -Protocol TCP -LocalPort 80 -Action Allow
New-NetFirewallRule -DisplayName "Open Port 443" -Direction Inbound -Protocol TCP -LocalPort 443 -Action Allow
New-NetFirewallRule -DisplayName "Open Port 3306" -Direction Inbound -Protocol TCP -LocalPort 3306 -Action Allow
New-NetFirewallRule -DisplayName "Open Port 14445" -Direction Inbound -Protocol TCP -LocalPort 14445 -Action Allow