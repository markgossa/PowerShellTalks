cd '.\LONPSUG-2019-03-13\3 - Changing infrastructure\terraform'
copy "..\..\2 - ProvisioningInfrastructure\Terraform\terraform.tfstate" -Force
terraform init
terraform apply