# Get help about a particular cmdlet
Get-Help Set-AzureRmVM
Get-Help Set-AzureRmVM -Detailed

# Get an example on how to use a cmdlet
Get-Help Set-AzureRmVM -Examples

# Get a list of parameters 
$cmdlet = Get-Command Set-AzureRmVM
$cmdlet.Parameters

# Get help about a particular parameter in a cmdlet
Get-Help Set-AzureRmVMOSDisk -Parameter *encr*key*

# Get online help
Get-Help Set-AzureRmVM -Online
