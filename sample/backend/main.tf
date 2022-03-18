locals {
  location = "West US 2"
}

provider "azurerm" {
  subscription_id = var.subscription_id
  features {}
}

module "resource_group" {
  source = "../../modules/azurerm_resource_group"

  name     = "backend-rg"
  location = local.location

}

module "storage_account" {
  source = "../../modules/azurerm_storage_account"

  name                     = "jcbackendstorage"
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = local.location
  resource_group_name      = module.resource_group.resource_group.name
}



