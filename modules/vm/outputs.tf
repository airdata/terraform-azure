output "public_dns" {
  value = "${azurerm_public_ip.tf-azurerm-pip.fqdn}"
}

output "app_server_url" {
  value = "http://${azurerm_public_ip.tf-azurerm-pip.fqdn}"
}