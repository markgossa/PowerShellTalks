Describe "New-VblAzureInfrastructure" {
    Context "Test-VblAzureRmResourceGroup" {
        # Test 1
        It "Return true if resource group exists in correct location" {
            Test-VblAzureRmResourceGroup -Name "RG-TEST" -Location "WestEurope" | Should be $true
        } 

        # Test 2
        It "Return false if resource group doesn't exist" {
            Test-VblAzureRmResourceGroup -Name "RG-TEST" -Location "WestEurope" | Should be $false
        }

        # Test 3
        It "Return false if resource group exists in incorrect location" {
            Test-VblAzureRmResourceGroup -Name "RG-TEST" -Location "WestEurope" | Should be $false
        }
    }
}
