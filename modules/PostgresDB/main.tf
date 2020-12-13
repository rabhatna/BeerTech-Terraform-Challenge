resource "azurerm_resource_group" "postgresql-rg" {
  name     = "kopi-postgresql-rg"
  location = "North Europe"
}

resource "azurerm_postgresql_server" "postgresql-server" {
  name                = "kopi-postgresql-server"
  location            = azurerm_resource_group.postgresql-rg.location
  resource_group_name = azurerm_resource_group.postgresql-rg.name

  administrator_login          = var.postgresql-admin-login
  administrator_login_password = var.postgresql-admin-password

  sku_name = var.postgresql-sku-name
  version  = var.postgresql-version

  storage_mb        = var.postgresql-storage
  auto_grow_enabled = true

  backup_retention_days            = 7
  geo_redundant_backup_enabled     = false
  public_network_access_enabled    = true
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_database" "postgresql-db" {
  name                = "kopidb"
  resource_group_name = azurerm_resource_group.postgresql-rg.name
  server_name         = azurerm_postgresql_server.postgresql-server.name
  charset             = "utf8"
  collation           = "English_United States.1252"
}

resource "azurerm_postgresql_firewall_rule" "postgresql-fw-rule" {
  name                = "postgresql-fw-rule"
  resource_group_name = azurerm_resource_group.postgresql-rg.name
  server_name         = azurerm_postgresql_server.postgresql-server.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}
