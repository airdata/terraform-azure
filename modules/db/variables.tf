variable "prefix" {
  type        = string
  description = "Prefix"
}

variable "location" {
  type        = string
  description = "Location of the resources in this module"
}

variable "resource_group_name" {
  type        = string
  description = "Resource group in which module will be built"
}

variable "postgresql_admin_name" {
  type        = string
  description = "admin username for postgres server"
}

variable "tinqin_ip" {
  description = "IP address of Tinqin office"
}

variable "uneo_ip" {
  description = "IP address of UNEO office"
}

variable "db_collation" {
  type        = string
  description = "Db collation"
  default     = "English_United States.1252"
}
variable "db_charset" {
  type        = string
  description = "Db charset"
  default     = "UTF8"
}

variable "db_sku_name" {
  type        = string
  default     = "B_Gen5_2"
}

variable "db_gr_backup" {
  type        = string
  default     = "Disabled"
}

variable "db_storage_mb" {
  type        = number
  default     = 5120
}

variable "db_pgsql_ver" {
  type        = string
  default     = "10"
}

variable "db_pgsql_ssl" {
  type        = string
  default     = "Disabled"
}

variable "db_backup_retention_days" {
  type        = number
  default     = 7
}
