variable "name" {
  type        = string
  description = "Resource group name"
}

variable "location" {
  type        = string
  description = "Location to deploy the resource"
}

variable "tags" {
  type        = map(any)
  description = "Tags for the resource"
  default = {}
}