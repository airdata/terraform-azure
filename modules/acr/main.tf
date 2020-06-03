resource "azurerm_container_registry" "main" {
  name                = "${var.prefix}${var.acr_name}"
  location            = var.location
  resource_group_name = var.resource_group_name
  admin_enabled       = var.acr_admin_enabled
  sku                 = var.acr_sku
  tags                = var.acr_tags
}