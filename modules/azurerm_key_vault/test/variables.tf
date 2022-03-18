variable "name" {
  type        = string
  description = "The name of the key vault."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the key vault."
}

variable "location" {
  type        = string
  description = "The Azure location where the resource exists."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of the tags to assign to the resource."
}
