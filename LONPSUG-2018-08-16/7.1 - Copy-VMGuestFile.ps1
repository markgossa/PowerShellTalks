function Copy-VeeamAgentForWindowsSetupFiles
{
    param($VMName,$GuestCredential)
    $files = "\\fileserver\Veeam Agent for Windows\Setup\VeeamAgentWindows_2.0.0.700\VeeamAgentWindows_2.0.0.700.exe", `
    "\\fileserver\Veeam Agent for Windows\Setup\veeam_agent_windows_subscription_0.lic", `
    "\\fileserver\Veeam Agent for Windows\Setup\Config.xml"
    foreach ($file in $files)
    {
        Copy-VMGuestFile -Source $file -Destination C:\vafw\ -VM $VMName `
        -GuestCredential $GuestCredential -LocalToGuest -Force -WarningAction SilentlyContinue
    }
}
