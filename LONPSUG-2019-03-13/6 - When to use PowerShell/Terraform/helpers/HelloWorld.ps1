[cmdletbinding()]
param 
(
    [parameter(Mandatory = $true)]
    [String]
    $Name,

    [parameter(Mandatory = $true)]
    [Switch]
    $IncludeDayOfTheWeek
)

try
{
    if ($IncludeDayOfTheWeek)
    {
        Write-Verbose -Message "Connecting to the world clock API"
        $dayOfTheWeek = (Invoke-RestMethod -Uri http://worldclockapi.com/api/json/utc/now).dayOfTheWeek
        Write-Verbose -Message "Creating greeting message for $Name"
        Write-Host "Happy $dayOfTheWeek $Name!"
    }
    else 
    {
        Write-Host "Hello $Name"
    }
}
catch 
{
    $scriptError = $_.Exception
    $scriptError = $scriptError -split "\n"
    Write-Error "$scriptError"
    exit 1
}