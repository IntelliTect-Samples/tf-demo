locals {
  source_tags = merge({ source = "terraform" }, var.tags)
}

resource "azurerm_storage_account" "sa" {
  name                      = var.name
  resource_group_name       = var.resource_group_name
  location                  = var.location
  account_kind              = var.account_kind
  account_tier              = var.account_tier
  account_replication_type  = var.account_replication_type
  access_tier               = var.access_tier
  enable_https_traffic_only = var.enable_https_traffic_only
  min_tls_version           = var.min_tls_version
  allow_blob_public_access  = var.allow_blob_public_access
  is_hns_enabled            = var.is_hns_enabled

  dynamic "custom_domain" {
    for_each = var.custom_domain == null ? [] : [1]
    content {
      name          = var.custom_domain.name
      use_subdomain = var.custom_domain.use_subdomain
    }
  }

  dynamic "identity" {
    for_each = var.identity == null ? [] : [1]
    content {
      type = var.identity.type
    }
  }

  dynamic "blob_properties" {
    for_each = var.blob_properties_cors_rule == null && var.blob_properties_delete_retention_policy == null ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.blob_properties_cors_rule == null ? [] : [1]
        content {
          allowed_headers    = lookup(var.blob_properties_cors_rule, "allowed_headers", null)
          allowed_methods    = lookup(var.blob_properties_cors_rule, "allowed_methods", null)
          allowed_origins    = lookup(var.blob_properties_cors_rule, "allowed_origins", null)
          exposed_headers    = lookup(var.blob_properties_cors_rule, "exposed_headers", null)
          max_age_in_seconds = lookup(var.blob_properties_cors_rule, "max_age_in_seconds", null)
        }
      }
      dynamic "delete_retention_policy" {
        for_each = var.blob_properties_delete_retention_policy == null ? [] : [1]
        content {
          days = lookup(var.blob_properties_delete_retention_policy, "days", null)
        }
      }
    }
  }

  dynamic "queue_properties" {
    for_each = var.queue_properties_cors_rule == null && var.queue_properties_logging == null && var.queue_properties_minute_metrics == null && var.queue_properties_hour_metrics == null ? [] : [1]
    content {
      dynamic "cors_rule" {
        for_each = var.queue_properties_cors_rule == null ? [] : [1]
        content {
          allowed_headers    = lookup(var.queue_properties_cors_rule, "allowed_headers", null)
          allowed_methods    = lookup(var.queue_properties_cors_rule, "allowed_methods", null)
          allowed_origins    = lookup(var.queue_properties_cors_rule, "allowed_origins", null)
          exposed_headers    = lookup(var.queue_properties_cors_rule, "exposed_headers", null)
          max_age_in_seconds = lookup(var.queue_properties_cors_rule, "max_age_in_seconds", null)
        }
      }
      dynamic "logging" {
        for_each = var.queue_properties_logging == null ? [] : [1]
        content {
          delete                = lookup(var.queue_properties_logging, "delete", null)
          read                  = lookup(var.queue_properties_logging, "read", null)
          version               = lookup(var.queue_properties_logging, "version", null)
          write                 = lookup(var.queue_properties_logging, "write", null)
          retention_policy_days = lookup(var.queue_properties_logging, "retention_policy_days", null)
        }
      }
      dynamic "minute_metrics" {
        for_each = var.queue_properties_minute_metrics == null ? [] : [1]
        content {
          enabled               = lookup(var.queue_properties_minute_metrics, "enabled", null)
          version               = lookup(var.queue_properties_minute_metrics, "version", null)
          include_apis          = lookup(var.queue_properties_minute_metrics, "include_apis", null)
          retention_policy_days = lookup(var.queue_properties_minute_metrics, "retention_policy_days", null)
        }
      }
      dynamic "hour_metrics" {
        for_each = var.queue_properties_hour_metrics == null ? [] : [1]
        content {
          enabled               = lookup(var.queue_properties_hour_metrics, "enabled", null)
          version               = lookup(var.queue_properties_hour_metrics, "version", null)
          include_apis          = lookup(var.queue_properties_hour_metrics, "include_apis", null)
          retention_policy_days = lookup(var.queue_properties_hour_metrics, "retention_policy_days", null)
        }
      }
    }
  }

  dynamic "static_website" {
    for_each = var.static_website == null ? [] : [1]
    content {
      index_document     = var.static_website.index_document
      error_404_document = var.static_website.error_404_document
    }
  }

  dynamic "network_rules" {
    for_each = var.network_rules == null ? [] : [1]
    content {
      default_action             = var.network_rules["default_action"] # required
      bypass                     = lookup(var.network_rules, "bypass", null)
      ip_rules                   = lookup(var.network_rules, "ip_rules", null)
      virtual_network_subnet_ids = lookup(var.network_rules, "virtual_network_subnet_ids", null)
    }
  }

  large_file_share_enabled = var.large_file_share_enabled

  tags = local.source_tags
}
