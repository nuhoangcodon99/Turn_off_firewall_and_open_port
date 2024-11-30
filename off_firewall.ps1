# Check if the script is running with administrative privileges
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    # Request administrative privileges if not already granted
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Exit
}

# Display a message indicating the start of the Firewall disabling process
Write-Host "Disabling Windows Defender Firewall..."

# Disable Windows Defender Firewall for all profiles (Domain, Private, Public)
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Display a completion message
Write-Host "Windows Defender Firewall has been successfully disabled."

# Pause and wait for the user to press a key before exiting
Write-Host "Press any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
