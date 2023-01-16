terraform {
  required_version = "~> 1.0.8"
  required_providers {
    azurerm = "~> 2.76"
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}