locals {
  location = "East US"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id = var.client_id
  client_secret = var.client_secret
  tenant_id =  var.tenant_id
  features {}
}

terraform {
  backend "remote" {}
}

module "resource_group" {
  source = "../../modules/azurerm_resource_group"

  name     = "test-rg"
  location = local.location
}

module "key_vault" {
  source = "../../modules/azurerm_key_vault"

  name                = "jcmeetup-kv"
  location            = local.location
  resource_group_name = module.resource_group.resource_group.name
}

module "sql_server" {
  source = "../../modules/azurerm_mssql_server"

  name                = "jcmeetup-sqlserver"
  resource_group_name = module.resource_group.resource_group.name
  location            = local.location
  administrator_login = "TestAdmin"
}

module "database" {
  source = "../../modules/azurerm_mssql_database"

  name        = "test-database"
  server_id   = module.sql_server.mssql_server.id
  server_name = module.sql_server.mssql_server.name
}

output "database_name" {
  value = module.database.mssql_database.id
}





