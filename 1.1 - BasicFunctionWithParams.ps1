# Basic function with parameters
function Write-Hello {
    param ($Name,$Colour)
    Write-Host "Hello $Name" -ForegroundColor $Colour
}

# Call function
Write-Hello -Name "London PowerShell User Group" -Colour Yellow
Write-Hello -Name "Vanquis" -Colour Blue
