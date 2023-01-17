locals {
  location = "East US"
  key_vaults = {
    "first" = {
      name = "jcmeetup-kv1"
    }
    "second" = {
      name = "jcmeetup-kv2"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}

terraform {
  backend "azurerm" {}
  required_version = ">= 1.1.7"
  required_providers {
    azurerm = "~> 3.7.0"
  }
}

module "resource_group" {
  source = "git::https://github.com/IntelliTect-Samples/tf-demo.git//modules/azurerm_resource_group?ref=resource_group/1.0.0"

  name     = "test-rg"
  location = local.location
}

module "key_vault" {
  source = "git::https://github.com/IntelliTect-Samples/tf-demo.git//modules/azurerm_key_vault?ref=key_vault/1.0.0"
  for_each = local.key_vaults

  name                = each.value.name
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

  name        = "test-database"
  server_id   = module.sql_server.mssql_server.id
  server_name = module.sql_server.mssql_server.name
}

output "key_vault_1_name" {
  value = module.key_vault["first"].key_vault.name
}

output "key_vault_2_name" {
  value = module.key_vault["second"].key_vault.name
}