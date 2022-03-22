# Test egress_ips module

variable input_client_id {}
variable input_client_secret {}
variable input_tenant_id {}
variable input_subscription_id {}

module "egress_ips" {
    source = "../../egress_ips"
    client_id = var.input_client_id
    client_secret = var.input_client_secret
    tenant_id = var.input_tenant_id
    subscription_id = var.input_subscription_id
}

output "ips" {
    value = module.egress_ips.egress_ips
}
