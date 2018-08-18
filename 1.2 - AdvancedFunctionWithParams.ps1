# Advanced function with parameters
function Write-Hello {
    [cmdletbinding()]
    param 
    (
        [parameter(Mandatory = $true)]    
        [string]
        $Name,
        [parameter()]    
        [string]
        $Colour = "Red"
    )
    
    Write-Verbose "Writing hello to '$Name' and colour is set to '$Colour'"
    Write-Host "Hello $Name" -ForegroundColor $Colour
}

# Call function without Colour parameter
Write-Hello -Name "London PowerShell User Group"

# Call function with -Verbose
Write-Hello -Name "London PowerShell User Group" -Colour Blue -Verbose
