$process = "notepad"
Start-Process "$process.exe"
$VerbosePreference = "Continue"

$i = 0
while((Get-Process -Name $process -ErrorAction SilentlyContinue) -and $i -le 60)
{
    #Refresh Cloud Connect Repository
    Write-Verbose "Waiting for process $process. Time elapsed $($i+1) seconds."    
    Start-Sleep -Seconds 1
    $i++
}

$VerbosePreference = "SilentlyContinue"
