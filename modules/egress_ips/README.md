# Egress Ips
- This module is used to configure ips used in firewalls
- Each time this module is called, the egress ips are pull from a master storage account

## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| null | n/a |

## Modules

No Modules.

## Resources

| Name |
|------|
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_id | n/a | `any` | n/a | yes |
| client\_secret | n/a | `any` | n/a | yes |
| tenant\_id | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| egress\_ips | n/a |
