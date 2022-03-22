/*
* # Egress Ips
* - This module is used by other modules to configure firewall ips
* - Each time this module is called, the egress ips are pull from a master storage account
*
*/

locals {
    module_path = abspath(path.module)
}

variable "client_id" {}
variable "client_secret" {}
variable "tenant_id" {}
variable "subscription_id" {}

resource "null_resource" "updateips" {
  triggers = {
    datetime = timestamp()
  }

  provisioner "local-exec" {
    command = "${local.module_path}/egressips.ps1 -ClientId ${var.client_id} -ClientSecret ${var.client_secret} -TenantId ${var.tenant_id} -SubscriptionID ${var.subscription_id}"
    interpreter = ["PowerShell", "-Command"]
  }
}

output "egress_ips" {
    value = csvdecode(file("${local.module_path}/ipaddresses.csv"))
}
