# get-vm vmware
gcm Get-VM

# get-vm hyper-v
gcm Get-VM -Module hyper-v

# get-vm
gcm Get-VM

# option 1
VMware.VimAutomation.Core\Get-VM
Hyper-V\Get-VM

# option 2
Import-Module VMware.VimAutomation.Core -Prefix VMware
Import-Module Hyper-V -Prefix HyperV
Get-VMwareVM
Get-HyperVVM
