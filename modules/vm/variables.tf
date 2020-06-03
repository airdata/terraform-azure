variable "customer" {
  description = "The name of customer."
}
variable "resource_group_name" {
  description = "The name of your Azure Resource Group."
}

variable "prefix" {
  description = "This prefix will be included in the name of some resources."
}

variable "hostname" {
  description = "Virtual machine hostname."
}

variable "location" {
  description = "The region where the virtual network is created."
}

variable "virtual_network_name" {
  description = "The name for your virtual network."
  default     = "vnet"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. "
  default     = "10.0.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.0.10.0/24"
}

variable "storage_account_tier" {
  description = "Defines the storage tier. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "storage_replication_type" {
  description = "Defines the replication type to use for this storage account."
  default     = "LRS"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B1ms"
}

variable "image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "Administrator user name"
  default     = "adminuser"
}

variable "admin_password" {
  description = "Administrator password"
  default     = "Adminpassword123!"
}

variable "source_network" {
  description = "Allow access from this network prefix. Defaults to '*'."
  default     = "*"
}

variable "acr_login_server" {
  description ="The URL that can be used to log into the container registry."
}
variable "acr_admin_username" {
  description = "The Username associated with the Container Registry"
}
variable "acr_admin_password" {
  description = "The Password associated with the Container Registry"
}
variable "tinqin_ip" {
  description = "IP address of Tinqin office"
}

variable "uneo_ip" {
  description = "IP address of Tinqin office"
}