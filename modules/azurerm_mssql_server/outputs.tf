output "mssql_server" {
  value = azurerm_mssql_server.sql_server
}

output "sql_server_admin_password" {
  value     = local.admin_password
  sensitive = true
}
