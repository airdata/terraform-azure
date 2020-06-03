
# Terraform on Azure

## Prerequisites
 - Azure user with sufficient rights on the account
  -  [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
  -  [Azure CLI Configure](https://docs.microsoft.com/en-us/azure/developer/terraform/install-configure)
  -  [Download terraform](https://www.terraform.io/downloads.html) and [add to path](https://www.vasos-koupparis.com/terraform-getting-started-install/)
## Initializing Terraform

1. #### Comment out the backend config part in main.tf
```JSON
 # terraform {
 #   required_version    = ">= 0.12.0"
 #   backend "azurerm" {
 #     key               = "backend/backend.tfstate"
 #   }
 # }
```

   - Run **`terraform init`**
   - Check the config with **`terraform plan`**
   - Deploy with **`terraform apply -target=module.backend`**
   - Make a note of the _storage account details_ output at the end of the `apply` chain.

1. ### Remote backend configuration
Restore the backend config, by uncomment out the backend config part in main.tf=
#### main.tf
```JSON
terraform {
  backend "azurerm" {
    key = "backend/backend.tfstate"
  }
}
```

The **key** value tells Terraform to automatically create a `backend` folder.


1. ### Populate the **`backend.tfvars`** file.
With the storage account details provided by the output at the end of the last `terraform apply`
##### backend.tfvars

```JSON
resource_group_name = ""
storage_account_name = ""
container_name = ""
access_key = ""
```

4. Run **`terraform init -backend-config="backend.tfvars"`** to use the new backend configuration.
   > `-backend-config` tells Terraform to use these variables at runtime.

```SH
terraform init -backend-config="backend.tfvars
```