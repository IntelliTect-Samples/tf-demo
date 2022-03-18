variable "name" {
  type        = string
  description = "The name of the key vault."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resource(s)."
}

variable "location" {
  type        = string
  description = "The Azure location where the resource(s) exists."
}

variable "tenant_id" {
  type        = string
  default     = null
  description = "The Azure AD Tenant ID to use for authenticating requests to the key vault."
}

variable "sku_name" {
  type        = string
  default     = "standard"
  description = "The SKU used for this Key Vault."
  validation {
    condition     = var.sku_name == "standard" || var.sku_name == "premium"
    error_message = "The sku name must be one of the following: [ standard, premium ]."
  }
}

variable "enabled_for_deployment" {
  type        = bool
  default     = false
  description = "Specifies whether Azure VMs are permitted to retrieve certificates storage as secrets from this Key Vault. Default is False."
}

variable "enabled_for_disk_encryption" {
  type        = bool
  default     = false
  description = "Specifies whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. Default is False."
}

variable "enabled_for_template_deployment" {
  type        = bool
  default     = false
  description = "Specifies whether Azure Resource Manager is permitted to retrieve secrets from the Key Vault. Default is False."
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Specifies whether Purge Protection is enabled for this Key Vault."
}

variable "tags" {
  type        = map(string)
  default     = null
  description = "A mapping of the tags to assign to the resource."
}

variable "network_acls" {
  type = object({
    default_action             = string
    bypass                     = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = {
    default_action             = "Deny"
    bypass                     = "AzureServices"
    ip_rules                   = []
    virtual_network_subnet_ids = []
  }
  description = "An object map of networking rules for the Key Vault. Default allows network access from anything in Azure."
}

variable "enable_rbac_authorization" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to true"
}
