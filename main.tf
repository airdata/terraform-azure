// ==================== GLobal Config ====================

provider "azurerm" {
  version               = "~> 1.0"
}

// ==================== Backend Config ====================

terraform {
  required_version      = ">= 0.12.0"
  backend "azurerm" {
    key                 = "backend/backend.tfstate"
  }
}

module "backend" {
  source                = "./modules/backend"
  location              = var.location
  customer              = var.customer
  prefix                = var.prefix
}

// ==================== Container Registry ====================

module "acr" {
  source                = "./modules/acr"
  acr_name              = var.prefix
  location              = var.location
  customer              = var.customer
  prefix                = var.prefix
  resource_group_name   = module.backend.resource_group_name
}

// ==================== Virtual Machines ====================

module "vm" {
  source                = "./modules/vm"
  hostname              = var.hostname
  location              = var.location
  customer              = var.customer
  prefix                = var.prefix
  resource_group_name   = module.backend.resource_group_name
  acr_login_server      = module.acr.acr_login_server
  acr_admin_username    = module.acr.acr_admin_username
  acr_admin_password    = module.acr.acr_admin_password
  tinqin_ip             = var.tinqin_ip
  uneo_ip               = var.uneo_ip
}

// ==================== Databases ====================

module "db" {
  source                = "./modules/db"
  prefix                = var.prefix
  location              = var.location
  resource_group_name   = module.backend.resource_group_name
  postgresql_admin_name = "${var.prefix}_admin"
  tinqin_ip             = var.tinqin_ip
  uneo_ip               = var.uneo_ip
}

// ==================== App Service ====================

module "appservice" {
  source                = "./modules/appservice"
  location              = var.location
  customer              = var.customer
  prefix                = var.prefix
  resource_group_name   = module.backend.resource_group_name
  resource_group_location = module.backend.resource_group_location
}