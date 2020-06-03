output "acr_id" {
  description = "The Container Registry ID."
  value       = azurerm_container_registry.main.id
}

output "acr_login_server" {
  description = "The URL that can be used to log into the container registry."
  value       = azurerm_container_registry.main.login_server
}

output "acr_admin_username" {
  description = "The Username associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.main.admin_username
}

output "acr_admin_password" {
  description = "The Password associated with the Container Registry Admin account - if the admin account is enabled."
  value       = azurerm_container_registry.main.admin_password
}