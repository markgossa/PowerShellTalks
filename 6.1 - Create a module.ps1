# where are modules stored?
$env:PSModulePath -split ";"

Get-ChildItem 'C:\Program Files\WindowsPowerShell\Modules'

# create a new module folder
New-Item -ItemType Directory -Path 'C:\Program Files\WindowsPowerShell\Modules\VanquisTest'

# copy module file to module folder
Copy-Item -Path 'Fulltalk\6.0 - VanquisTest.psm1' -Destination 'C:\Program Files\WindowsPowerShell\Modules\VanquisTest\VanquisTest.psm1' -Force

# create module manifest
New-ModuleManifest -Path 'C:\Program Files\WindowsPowerShell\Modules\VanquisTest\VanquisTest.psd1' `
-Author "Vanquis Bank" `
-FunctionsToExport Test-VblAzureRmResourceGroup,Write-VblHello `
-RootModule '.\VanquisTest.psm1'

# check contents of module folder
Get-ChildItem -Path 'C:\Program Files\WindowsPowerShell\Modules\VanquisTest'

# open module manfiest file
code 'C:\Program Files\WindowsPowerShell\Modules\VanquisTest\VanquisTest.psd1'
