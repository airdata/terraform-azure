output "resource_group_name" {
  value = "${azurerm_resource_group.main.name}"
}

output "resource_group_location" {
  value = "${azurerm_resource_group.main.location}"
}

output "storage_account_name" {
  value = "${azurerm_storage_account.main.name}"
}

output "container_name" {
  value = "${azurerm_storage_container.main.name}"
}

output "primary_access_key" {
  value = "${azurerm_storage_account.main.primary_access_key}"
}

output "secondary_access_key" {
  value = "${azurerm_storage_account.main.secondary_access_key}"
}

output "resource_group_id" {
  value = "${azurerm_resource_group.main.id}"
}