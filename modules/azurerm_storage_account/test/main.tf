module "rg" {
  source = "../../azurerm_resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "sa" {
  source = "../"

  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = var.location
  name                     = var.name
  resource_group_name      = module.rg.resource_group.name
  tags                     = var.tags
}