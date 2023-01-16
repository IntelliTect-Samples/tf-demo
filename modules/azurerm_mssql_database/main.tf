locals {
  source_tags = merge({ source = "terraform" }, var.tags)
}

resource "azurerm_mssql_database" "sql_database" {
  name                        = var.name
  tags                        = local.source_tags
  server_id                   = var.server_id
  auto_pause_delay_in_minutes = var.auto_pause_delay_in_minutes
  create_mode                 = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  collation                   = var.collation
  elastic_pool_id             = var.elastic_pool_id
  geo_backup_enabled          = var.geo_backup_enabled
  license_type                = var.license_type
  max_size_gb                 = var.max_size_gb
  min_capacity                = var.min_capacity
  restore_point_in_time       = var.restore_point_in_time
  recover_database_id         = var.recover_database_id
  restore_dropped_database_id = var.restore_dropped_database_id
  read_replica_count          = var.read_replica_count
  read_scale                  = var.read_scale
  sample_name                 = var.sample_name
  sku_name                    = var.sku_name
  storage_account_type        = var.storage_account_type
  zone_redundant              = var.zone_redundant

  # extended_auditing_policy is deprecated
  # long_term_retention_policy
  # short_term_retention_policy
  # threat_detection_policy

  # provisioner "local-exec" {
  #   command = "az sql failover-group update --name ${var.failover_group_name} --add-db ${var.name} -g ${var.failover_group_resource_group_name} -s ${var.server_name} --subscription ${data.azurerm_client_config.current.subscription_id}"
  # }
}

data "azurerm_client_config" "current" {}