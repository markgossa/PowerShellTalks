Describe "New-VblAzureInfrastructure" {
    Context "Test-VblAzureRmResourceGroup" {
        It "Return true if resource group exists in correct location" {
            Mock -CommandName Get-AzureRmResourceGroup -MockWith {
                [Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup]@{
                    ResourceGroupName   = "RG-TEST"
                    Location            = "WestEurope"
                }
            }

            Test-VblAzureRmResourceGroup -Name "RG-TEST" -Location "WestEurope" | Should be $true
            Assert-MockCalled -CommandName Get-AzureRmResourceGroup -Times 1 -Exactly -Scope It
        } 

        It "Return false if resource group doesn't exist" {
            Mock -CommandName Get-AzureRmResourceGroup -MockWith {}
            Test-VblAzureRmResourceGroup -Name "RG-TEST" -Location "WestEurope" | Should be $false
            Assert-MockCalled -CommandName Get-AzureRmResourceGroup -Times 1 -Exactly -Scope It
        }

        It "Return false if resource group exists in incorrect location" {
            Mock -CommandName Get-AzureRmResourceGroup -MockWith {
                [Microsoft.Azure.Commands.ResourceManager.Cmdlets.SdkModels.PSResourceGroup]@{
                    ResourceGroupName   = "RG-TEST"
                    Location            = "EastUS"
                }
            }

            Test-VblAzureRmResourceGroup -Name "RG-TEST" -Location "WestEurope" | Should be $false
            Assert-MockCalled -CommandName Get-AzureRmResourceGroup -Times 1 -Exactly -Scope It
        }
    }
}
