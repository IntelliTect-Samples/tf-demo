locals {
  location = "East US"
  databases = {
    "first" = {
      name = "test-database1"
    }
    "second" = {
      name = "test-database2"
    }
  }
}

provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
  features {}
}

terraform {
  backend "azurerm" {}
  required_version = ">= 1.1.7"
  required_providers {
    azurerm = "~> 2.76"
  }
}

module "resource_group" {
  source = "git::https://github.com/IntelliTect-Samples/tf-demo.git//modules/azurerm_resource_group?ref=resource_group/1.0.0"

  name     = "test-rg"
  location = local.location
}

module "key_vault" {
  source = "git::https://github.com/IntelliTect-Samples/tf-demo.git//modules/azurerm_key_vault?ref=key_vault/1.0.0"

  name                = "jcmeetup-kv"
  location            = local.location
  resource_group_name = module.resource_group.resource_group.name
}

module "sql_server" {
  source = "git::https://github.com/IntelliTect-Samples/tf-demo.git//modules/azurerm_mssql_server?ref=mssql_server/1.0.0"

  name                = "jcmeetup-sqlserver"
  resource_group_name = module.resource_group.resource_group.name
  location            = local.location
  administrator_login = "TestAdmin"
}

module "database" {
  source   = "git::https://github.com/IntelliTect-Samples/tf-demo.git//modules/azurerm_mssql_database?ref=mssql_database/1.0.0"
  for_each = local.databases

  name        = each.value.name
  server_id   = module.sql_server.mssql_server.id
  server_name = module.sql_server.mssql_server.name
}

output "database1_name" {
  value = module.database[0].mssql_database.id
}

output "database2_name" {
  value = module.database[1].mssql_database.id
}





