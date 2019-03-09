Instructions

1. Log into Azure Cloud Shell

2. Modify main.tf as needed (add username, password, IPs etc)

3. Upload main.tf into Cloud Shell

4. Run below commands

```bash
az account set --subscription "Your subscription name" # Changes to the correct subscription
cd ~
terraform init # Terraform downloads the terraform Azure plugin
terraform plan -out=plan # This is what Terraform will do to make your infrastructure like the configuration
terraform apply
```
