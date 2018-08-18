# install powershell cookbook
Install-Module PowerShellCookBook -Force -AllowClobber

Show-Object (Get-WmiObject Win32_ActiveRoute) # SameElement = route
