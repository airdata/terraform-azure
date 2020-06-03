output "resource_group_name" {
  value = "${module.backend.resource_group_name}"
}

output "resource_group_location" {
  value = "${module.backend.resource_group_location}"
}

output "storage_account_name" {
  value = "${module.backend.storage_account_name}"
}

output "container_name" {
  value = "${module.backend.container_name}"
}

output "primary_access_key" {
  value = "${module.backend.primary_access_key}"
}

output "secondary_access_key" {
  value = "${module.backend.secondary_access_key}"
}

output "public_dns" {
  value = "${module.vm.public_dns}"
}

output "app_server_url" {
  value = "${module.vm.app_server_url}"
}


output "acr_login_server" {
  value = "${module.acr.acr_login_server}"
}

output "acr_admin_username" {
  value = "${module.acr.acr_admin_username}"
}

output "acr_admin_password" {
  value = "${module.acr.acr_admin_password}"
}
output "app_service_default_hostname" {
  value = "https://${module.appservice.app_service_default_hostname}"
}
