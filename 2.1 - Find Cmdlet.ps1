# Find all cmdlets that relate to Azure VMs
Get-Command -Noun AzureRmVM
Get-Command -Noun *vm*

# Find all cmdlets that can set properties on Azure VMs
Get-Command -Noun AzureRmVM -Verb Set

# Find all get* cmdlets related to Azure VMs
gcm get*AzureRmVM*

# Find all cmdlets which accept the parameter NetworkSecurityGroup
Import-Module AzureRm
gcm -ParameterName *NetworkSecurityGroup*

# Typing cmdlet in vscode


# List all installed modules
Get-Module -ListAvailable

# Get all functions in a module
gcm -Module AzureRM.Compute
gcm get* -Module AzureRM.Compute
gcm get*disk* -Module AzureRM.Compute
