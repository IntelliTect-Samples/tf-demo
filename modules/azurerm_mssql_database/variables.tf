variable "name" {
  type        = string
  description = "Resource name"
}

variable "tags" {
  type        = map(any)
  description = "Tags for the resource"
  default = {}
}

variable "server_id" {
  type        = string
  description = "The id of the Ms SQL Server on which to create the database."
}

variable "auto_pause_delay_in_minutes" {
  type        = string
  default     = null
  description = "(Optional) Time in minutes after which database is automatically paused. A value of -1 means that automatic pause is disabled. This property is only settable for General Purpose Serverless databases."
}

variable "create_mode" {
  type        = string
  default     = null
  description = "(Optional) The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary."
}

variable "creation_source_database_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the source database from which to create the new database. This should only be used for databases with create_mode values that use another database as reference. Changing this forces a new resource to be created."
}

variable "collation" {
  type        = string
  default     = null
  description = "(Optional) Specifies the collation of the database. Changing this forces a new resource to be created."
}

variable "elastic_pool_id" {
  type        = string
  default     = null
  description = "(Optional) Specifies the ID of the elastic pool containing this database."
}

variable "failover_group_name" {
  type        = string
  description = "The name of the failover group to add the database to."
  default = null
}

variable "failover_group_resource_group_name" {
  type        = string
  description = "The name of the resource group containing the failover group to add the database to."
  default = null
}

variable "geo_backup_enabled" {
  type        = string
  default     = null
  description = "(Optional) A boolean that specifies if the Geo Backup Policy is enabled."
}

variable "license_type" {
  type        = string
  default     = null
  description = "(Optional) Specifies the license type applied to this database. Possible values are LicenseIncluded and BasePrice."
}

variable "max_size_gb" {
  type        = string
  default     = null
  description = "The max size of the database in gigabytes."
}

variable "min_capacity" {
  type        = string
  default     = null
  description = "(Optional) Minimal capacity that database will always have allocated, if not paused. This property is only settable for General Purpose Serverless databases."
}

variable "restore_point_in_time" {
  type        = string
  default     = null
  description = "Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database. This property is only settable for create_mode= PointInTimeRestore databases."
}

variable "recover_database_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the database to be recovered. This property is only applicable when the create_mode is Recovery."
}

variable "restore_dropped_database_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the database to be restored. This property is only applicable when the create_mode is Restore."
}

variable "read_replica_count" {
  type        = string
  default     = null
  description = "(Optional) The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed. This property is only settable for Hyperscale edition databases."
}

variable "read_scale" {
  type        = string
  default     = null
  description = "(Optional) If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica. This property is only settable for Premium and Business Critical databases."
}

variable "sample_name" {
  type        = string
  default     = null
  description = "(Optional) Specifies the name of the sample schema to apply when creating this database. Possible value is AdventureWorksLT."
}

variable "server_name" {
  type        = string
  description = "The id of the Ms SQL Server on which to create the database."
}

variable "sku_name" {
  type        = string
  default     = null
  description = "(Optional) Specifies the name of the SKU used by the database. For example, GP_S_Gen5_2,HS_Gen4_1,BC_Gen5_2, ElasticPool, Basic,S0, P2 ,DW100c, DS100. Changing this from the HyperScale service tier to another service tier will force a new resource to be created."
}

variable "storage_account_type" {
  type        = string
  default     = null
  description = " (Optional) Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are GRS, LRS and ZRS. The default value is GRS."
}

variable "zone_redundant" {
  type        = string
  default     = null
  description = "(Optional) Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. This property is only settable for Premium and Business Critical databases."
}
