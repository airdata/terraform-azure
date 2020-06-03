// ==================== Backend ====================

resource "azurerm_resource_group" "main" {
  name                     = join("-", [title("${var.customer}"), "Terraform-States-RG"])
  location                 = var.location

  tags = {
    Description            = "Resource Group for Terraform States"
    Owner                  = title("${var.customer}")
  }
}

resource "azurerm_storage_account" "main" {
  name                     = lower("${var.customer}tfacc")
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Description            = "Storage Account for Terraform States"
    Owner                  = title("${var.customer}")
  }
}

resource "azurerm_storage_container" "main" {
  name                     = lower("${var.customer}-tfstates")
  storage_account_name     = azurerm_storage_account.main.name
  container_access_type    = "container"
}

