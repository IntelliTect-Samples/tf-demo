terraform {
  required_version = ">= 1.0.6"
  required_providers {
    azurerm = "~> 2.76"
    azuread = "~> 2.5"
  }
}

provider "azurerm" {
  features {}
}
