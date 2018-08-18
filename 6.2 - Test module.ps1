# check module exists
Get-Module *vanq* -ListAvailable

# import module
gcm -Module VanquisTest

# check functions work
Write-VblHello -Names "Vanquis bank!" -Colour Yellow
