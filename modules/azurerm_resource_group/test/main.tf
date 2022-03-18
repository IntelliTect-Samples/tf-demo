locals {
  tags = {
    "localtag" = "testlocaltag"
  }
}

module "azurerm_required_tags" {
  source = "../../azurerm_required_tags"

  contact             = "test@profisee.com"
  budget_amount       = "1000"
  data_classification = "public"
  environment         = "sandbox"
}

module "resource_group" {
  source = "../"

  name     = var.name
  location = var.location
  tags = merge(
    local.tags,
    module.azurerm_required_tags.common_tags,
    {
      testing = "true"
    }
  )
}

