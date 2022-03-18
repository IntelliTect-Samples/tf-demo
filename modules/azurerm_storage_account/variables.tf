variable "name" {
  type        = string
  description = "The name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "The Azure location where the resource exists."
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = "The Kind of account."
  validation {
    condition     = var.account_kind == "Storage" || var.account_kind == "StorageV2"
    error_message = "The account kind must be one of the following: [ Storage, StorageV2 ]."
  }
}

variable "account_tier" {
  type        = string
  description = "The Tier to use for this storage account."
  validation {
    condition     = var.account_tier == "Standard" || var.account_tier == "Premium"
    error_message = "The account tier must be one of the following: [ Standard, Premium ]."
  }
}

variable "account_replication_type" {
  type        = string
  description = "The type of replication to use for this storage account."
  validation {
    condition     = var.account_replication_type == "LRS" || var.account_replication_type == "GRS" || var.account_replication_type == "RAGRS" || var.account_replication_type == "ZRS" || var.account_replication_type == "GZRS" || var.account_replication_type == "RAGZRS"
    error_message = "The account replication type must be one of the following: [ LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS ]."
  }
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = "The Access Tier for BlobStorage, FileStorage, and StorageV2 accounts."
  validation {
    condition     = var.access_tier == "Hot" || var.access_tier == "Cool"
    error_message = "The access tier must be one of the following: [ Hot, Cool ]."
  }
}

variable "enable_https_traffic_only" {
  type        = bool
  default     = true
  description = "Flag specifying to force HTTPS if enabled."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
  description = "The minimum supported TLS version for the storage account."
  validation {
    condition     = var.min_tls_version == "TLS1_0" || var.min_tls_version == "TLS1_1" || var.min_tls_version == "TLS1_2"
    error_message = "The min TLS version must be one of the following: [ TLS1_0, TLS1_1, TLS1_2 ]."
  }
}

variable "allow_blob_public_access" {
  type        = bool
  default     = false
  description = "Flag specifying to Allow or Disallow public access to all blobs or containers in the storage account."
}

variable "is_hns_enabled" {
  type        = bool
  default     = false
  description = "Flag specifying if Hierarchical Namespace is enabled."
}

variable "custom_domain" {
  type = object({
    name          = string
    use_subdomain = bool
  })
  default     = null
  description = "Block specifying the Custom Domain Name for the storage account."
}

variable "identity" {
  type = object({
    type = string
  })
  default     = null
  description = "Block specifying the identity type of the storage account."
}

variable "blob_properties_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default     = null
  description = "Block specifying the CORS Blob properties for the storage account."
}

variable "blob_properties_delete_retention_policy" {
  type = object({
    days = number
  })
  default     = null
  description = "Block specifying the Blob delete retention policy for the storage account."
}

variable "queue_properties_cors_rule" {
  type = object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  })
  default     = null
  description = "Block specifying the CORS Blob properties for the storage account."
}

variable "queue_properties_logging" {
  type = object({
    delete                = bool
    read                  = bool
    version               = string
    write                 = bool
    retention_policy_days = number
  })
  default     = null
  description = "Block specifying the "
}

variable "queue_properties_minute_metrics" {
  type = object({
    enabled               = bool
    version               = string
    include_apis          = bool
    retention_policy_days = number
  })
  default     = null
  description = "Block specifying the "
}

variable "queue_properties_hour_metrics" {
  type = object({
    enabled               = bool
    version               = string
    include_apis          = bool
    retention_policy_days = number
  })
  default     = null
  description = "Block specifying the "
}

variable "static_website" {
  type = object({
    index_document     = string
    error_404_document = string
  })
  default     = null
  description = "Block specifying the configuration for static websites on the storage account."
}

variable "large_file_share_enabled" {
  type        = bool
  default     = null
  description = "Flag specifying if Large File Share is enabled."
}

variable "network_rules" {
  type = object({
    default_action             = string
    bypass                     = list(string)
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default     = null
  description = "Block specifying the network rules for the storage account."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of the tags to assign to the resource."
}
