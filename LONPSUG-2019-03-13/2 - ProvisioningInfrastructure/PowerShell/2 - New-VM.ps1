New-AzResourceGroup -Name RG-LONPSUG1 -Location WestEurope

$cred = Get-Credential -UserName azureadmin -Message "Enter your password"

New-AzVm `
    -ResourceGroupName "RG-LONPSUG1" `
    -Name "myVM" `
    -Location "West Europe" `
    -VirtualNetworkName "myVnet" `
    -SubnetName "mySubnet" `
    -SecurityGroupName "myNetworkSecurityGroup" `
    -PublicIpAddressName "myPublicIpAddress" `
    -OpenPorts 80,3389 `
    -Credential $cred