resource "azurerm_postgresql_server" "postgres" {
  name                    = "postgres-server-${var.env}-${var.region}"
  location                = azurerm_resource_group.rg.id
  resource_group_name     = azurerm_resource_group.rg.id
  sku_name                = "B_Gen5_2"
  version                 = "11"
  storage_mb              = 5120
  backup_retention_days   = 7
  administrator_login     = sensitive("db-user")
  ssl_enforcement_enabled = true
}

resource "azurerm_postgresql_database" "postgres" {
  name                  = "postgres-db-${var.env}-${var.region}"
  resource_group_name   = azurerm_resource_group.rg.id
  server_name           = azurerm_postgresql_server.postgres.name
  charset               = "UTF8"
  collation             = "English_United States.1252"
}