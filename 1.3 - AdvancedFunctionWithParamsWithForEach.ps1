# Advanced function with parameters and foreach loop
function Write-Hello {
    [cmdletbinding()]
    param 
    (
        [parameter(Mandatory = $true)]    
        [string[]]
        $Names,
        [parameter()]    
        [string]
        $Colour = "Red"
    )
    
    Write-Verbose "Writing hello to '$($Names -join ', ')' and colour is set to '$Colour'"
    foreach($Name in $Names)
    {
        Write-Host "Hello $Name" -ForegroundColor $Colour
    }
}

# Call function without Colour parameter
Write-Hello -Names "London PowerShell User Group"

# Call function with -Verbose
Write-Hello -Names "London PowerShell User Group",Paul,Mark,James,Mary -Colour Blue -Verbose
