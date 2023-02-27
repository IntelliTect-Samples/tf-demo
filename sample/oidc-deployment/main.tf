locals {
  location = "East US"
}

provider "azurerm" {
  use_oidc = true
  features {}
}

terraform {
  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "jcbackendstorage"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }

  required_version = ">= 1.1.7"
  required_providers {
    azurerm = "~>3.7.0"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = "test-rg"
  location = local.location
}

resource "azurerm_automation_account" "example" {
  name                = "example-account"
  location            = local.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Basic"

  tags = {
    environment = "development"
  }
}
