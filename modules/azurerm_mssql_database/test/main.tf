module "rg" {
  source = "../../azurerm_resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = {}
}

module "sql_server" {
  source = "../../azurerm_mssql_server"

  name                         = var.sql_server_name
  resource_group_name          = module.rg.resource_group.name
  location                     = var.location
  tags                         = {}
  administrator_login          = var.sql_server_administrator_login
  administrator_login_password = var.sql_server_administrator_login_password
}

module "sql_database" {
  source = "../"

  name      = var.name
  tags      = {}
  server_id = module.sql_server.sql_server.id
}

