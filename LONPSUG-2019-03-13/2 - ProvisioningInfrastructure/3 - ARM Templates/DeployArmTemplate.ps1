New-AzResourceGroup -Name "RG-LONPSUG3" -Location "West Europe"

New-AzResourceGroupDeployment -ResourceGroupName "RG-LONPSUG3" -Name "myDeployment" -TemplateFile vm.json -TemplateParameterFile vm.parameters.json