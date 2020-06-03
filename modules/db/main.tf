// ==================== PostgresSQL ====================

resource "random_pet" "primary" {
}

resource "random_id" "primary" {
  byte_length                  = 10
}

resource "random_password" "password" {
  length                       = 16
  special                      = true
  override_special             = "_%@"
}

resource "azurerm_postgresql_server" "main" {
  name                         = random_pet.primary.id
  location                     = var.location
  resource_group_name          = var.resource_group_name

  version                      = var.db_pgsql_ver
  ssl_enforcement              = var.db_pgsql_ssl
  sku_name                     = var.db_sku_name

  administrator_login          = var.postgresql_admin_name
  administrator_login_password = random_password.password.result

  storage_profile {
    storage_mb                 = var.db_storage_mb
    backup_retention_days      = var.db_backup_retention_days
    geo_redundant_backup       = var.db_gr_backup
  }

}

resource "azurerm_postgresql_database" "main" {
  name                         = "${var.prefix}-postgres-main"
  resource_group_name          = var.resource_group_name
  server_name                  = azurerm_postgresql_server.main.name
  charset                      = var.db_charset
  collation                    = var.db_collation
}

resource "azurerm_postgresql_firewall_rule" "fw-db-uneo-ip" {
  name                         = "${var.prefix}-allow-uneo-ip"
  resource_group_name          = var.resource_group_name
  server_name                  = azurerm_postgresql_server.main.name
  start_ip_address             = var.uneo_ip
  end_ip_address               = var.uneo_ip
}

resource "azurerm_postgresql_firewall_rule" "allow_tinqin_office" {
  name                         = "${var.prefix}-allow-tinqin-ip"
  resource_group_name          = var.resource_group_name
  server_name                  = azurerm_postgresql_server.main.name
  start_ip_address             = var.tinqin_ip
  end_ip_address               = var.tinqin_ip
}