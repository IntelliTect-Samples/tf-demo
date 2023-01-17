locals {
  source_tags    = merge({ source = "terraform" }, var.tags)
  admin_password = (var.administrator_login_password == null ? random_password.password.result : var.administrator_login_password)
}

resource "random_password" "password" {
  length  = 13
  special = true
}

resource "azurerm_mssql_server" "sql_server" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  tags                          = local.source_tags
  version                       = var.sql_version
  administrator_login           = var.administrator_login
  administrator_login_password  = local.admin_password
  minimum_tls_version           = var.minimum_tls_version
  connection_policy             = var.connection_policy
  public_network_access_enabled = var.public_network_access_enabled

  dynamic "identity" {
    for_each = (var.identity_type == null ? {} : { placeholder = { "placeholder" = "here" } })
    content {
      type = var.identity_type
    }
  }

  dynamic "azuread_administrator" {
    for_each = var.azuread_administrator
    content {
      login_username = azuread_administrator.value.login_username
      object_id      = azuread_administrator.value.object_id
      tenant_id      = azuread_administrator.value.tenant_id
    }
  }

  # extended_auditing_policy is deprecated
}