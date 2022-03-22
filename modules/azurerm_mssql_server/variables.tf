variable "name" {
  type        = string
  description = "Resource name"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resource(s)."
}

variable "location" {
  type        = string
  description = "Location to deploy the resource"
}

variable "tags" {
  type        = map(any)
  description = "Tags for the resource"
  default     = {}
}

variable "sql_version" {
  type        = string
  default     = "12.0"
  description = "The version of SQL Server to use; the default is '12.0'"
}

variable "administrator_login" {
  type        = string
  description = "The name of the SQL Administrator."
}

variable "administrator_login_password" {
  type        = string
  default     = null
  description = "(Optional) The password of the SQL Administrator. If a value is not provided a random password will be generated."
}

variable "azuread_administrator" {
  type = map(object({
    login_username = string           # The login username of the Azure AD Administrator of this SQL Server.
    object_id      = string           # The object id of the Azure AD Administrator of this SQL Server.
    tenant_id      = optional(string) # (Optional) The tenant id of the Azure AD Administrator of this SQL Server.
  }))
  default     = {}
  description = "(Optional) A map of a single azuread administrator of azuread group of administrators. For argument details see variable comments."
}

variable "connection_policy" {
  type        = string
  default     = null
  description = "(Optional) The connection policy the server will use. Possible values are Default, Proxy, and Redirect. Defaults to Default."
}

variable "minimum_tls_version" {
  type        = string
  default     = "1.2"
  description = "(Optional) The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether public network access is allowed for this server. Defaults to false."
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "Specifies the identity type of the Microsoft SQL Server. At this time the only allowed value is SystemAssigned."
}
