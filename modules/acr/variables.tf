// ==================== GLobal variables ====================
variable "location" {
  type        = string
}

variable "customer" {
  type        = string
}

variable "prefix" {
  type        = string
}

variable "resource_group_name" {
  type        = string
}

variable "acr_name" {
  type        = string
}

variable "acr_admin_enabled" {
  description = "Specifies whether the admin user is enabled."
  type        = string
  default     = true
}

variable "acr_sku" {
  description = "The SKU name of the the container registry. Possible values are Classic, Basic, Standard and Premium."
  type        = string
  default     = "Basic"
}

variable "acr_storage_account_id" {
  description = "The ID of a Storage Account which must be located in the same Azure Region as the Container Registry (Required for Classic Sku - Optional otherwise)."
  type        = string
  default     = ""
}

variable "acr_georeplication_locations" {
  description = "A list of Azure locations where the container registry should be geo-replicated."
  type        = list
  default     = []
}

variable "acr_tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map

  default = {
    "projet"  = "terraform"
    "purpose" = "acr"
  }
}