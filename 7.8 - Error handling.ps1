# Error handling
try 
{
    Get-ChildItem -Path MissingFile.ps1 -ErrorAction Stop
}
catch 
{
    $a = $_.Exception
}

# Get exception type
$a.GetType().FullName

# Error handling - specific exception type
try 
{
    Get-ChildItem -Path MissingFile.ps1 -ErrorAction Stop
}
catch [System.Management.Automation.ItemNotFoundException]
{
    $a = $_.Exception
    Write-Error "This file doesn't exist. Do something else."
}
