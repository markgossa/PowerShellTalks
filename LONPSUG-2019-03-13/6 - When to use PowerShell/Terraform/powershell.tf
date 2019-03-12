resource "null_resource" "helloWorld" {
  triggers {
    functionAppKey = "${uuid()}"
  }
  provisioner "local-exec" {
    command = ".'${path.module}\\helpers\\HelloWorld.ps1' -Name 'LONPSUG' -IncludeDayOfTheWeek -Verbose" 
    interpreter = ["PowerShell", "-Command"]
  }
}

resource "null_resource" "newAnsibleInventory" {
  triggers {
    functionAppKey = "${uuid()}"
  }
  provisioner "local-exec" {
    command = ".'${path.module}\\helpers\\New-AnsibleInventory.ps1' -DomainControllerVmCount '2' -DomainControllerFirstHostNumber '4' -DomainControllerHostnamePrefix 'contosodc' -SubnetNetworkId '10.0.0.0/24' -DomainName 'contoso.com' -Username 'administrator'" 
    interpreter = ["PowerShell", "-Command"]
  }
}
