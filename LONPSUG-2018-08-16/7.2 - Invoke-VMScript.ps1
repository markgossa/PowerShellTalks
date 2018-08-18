function Install-VeeamAgentForWindowsLicense
{
    param($VMToConvert,$GuestCredential)
    $ScriptText = '"C:\Program Files\Veeam\Endpoint Backup\Veeam.Agent.Configurator.exe" ' 
    $ScriptText += "-license /f:C:\vafw\veeam_agent_windows_subscription_0.lic /s'"
    $Result = Invoke-VMScript -ScriptText $ScriptText -VM $VMToConvert.Name -GuestCredential $GuestCredential -ScriptType Bat -WarningAction SilentlyContinue
    $ExitCode = $Result.ScriptOutput[10] + $Result.ScriptOutput[11]
    [int]$ExitCode
}

function Install-VeeamAgentForWindows
{
    param($VMToConvert,$GuestCredential)
    $ScriptText = 'C:\vafw\VeeamAgentWindows_2.0.0.700.exe /silent /accepteula'
    $Result = Invoke-VMScript -ScriptText $ScriptText -VM $VMToConvert.Name -GuestCredential $GuestCredential -ScriptType Bat -WarningAction SilentlyContinue
}
