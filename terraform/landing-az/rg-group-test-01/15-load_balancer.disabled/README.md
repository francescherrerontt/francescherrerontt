# load_balancer module

## Introduction

This module belongs to customer-sample NTT main modules and it will do actions related to load balancers like, the following:

- create load balancers (LB)
- create LB address pools
- create LB NAT rules
- create LB probes
- create LB rules

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.13.3 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >=2.50.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >=2.50.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_loadbalancers"></a> [loadbalancers](#module\_loadbalancers) | git@scm.capside.com:terraform/azure/terraform-azurerm-loadbalancer.git?ref=SFSTRY0001942 |  |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb_backend_address_pool_address.ips](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address) | resource |
| [azurerm_network_interface_backend_address_pool_association.nics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_backend_address_pool_association) | resource |
| [terraform_remote_state.global_rg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vnet](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Backend container | `string` | n/a | yes |
| <a name="input_lb_ips_asoc"></a> [lb\_ips\_asoc](#input\_lb\_ips\_asoc) | Adds IP addresses to LB backend address pool. | `map(any)` | `{}` | no |
| <a name="input_lb_nics_asoc"></a> [lb\_nics\_asoc](#input\_lb\_nics\_asoc) | Adds NIC to LB backend address pool. | `map(any)` | `{}` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | This is the load balancers definition map. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | This is the location to deploy resources | `string` | `"westeurope"` | no |
| <a name="input_ntt_auto_cloud_iac"></a> [ntt\_auto\_cloud\_iac](#input\_ntt\_auto\_cloud\_iac) | NTT IaC environment identified. Create Automation Managed System per deployment. | `string` | `null` | no |
| <a name="input_ntt_environment"></a> [ntt\_environment](#input\_ntt\_environment) | Productive environment type. Possible values: pro, pre, dev, int, qa, dr | `string` | `"dev"` | no |
| <a name="input_ntt_monitoring"></a> [ntt\_monitoring](#input\_ntt\_monitoring) | Defines wether the resources should be monitored or not. Possible values: 0, 1 | `string` | `"1"` | no |
| <a name="input_ntt_naming_convention"></a> [ntt\_naming\_convention](#input\_ntt\_naming\_convention) | Set to 'true' to autogenerate resource names using NTT naming convention. Name variables will be used as tags inside the names. Set to 'false' to use name variables as resource names | `bool` | `true` | no |
| <a name="input_ntt_platform"></a> [ntt\_platform](#input\_ntt\_platform) | The platform represents a group of systems that underpins one or more critical business functions. This grouping is done per environments (Production, Pre-production, DR, Development, etc.) and per specific functions (DMZ, Backup solution, Marketing site, Email service etc.) | `string` | `null` | no |
| <a name="input_ntt_service_group"></a> [ntt\_service\_group](#input\_ntt\_service\_group) | The service group is a category to group CIs that have a similar function in a platform | `string` | `null` | no |
| <a name="input_ntt_service_level"></a> [ntt\_service\_level](#input\_ntt\_service\_level) | As defined in Service Now u\_service\_level\_label table: 24x7, EU\_10x5, US\_10x5 | `string` | `"24x7"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Backend storage resource group | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Key/Value of tags to apply to created resources | `map(any)` | `{}` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Backend storage account | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Backend subscription\_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_lb_backend_address_pool_id"></a> [azurerm\_lb\_backend\_address\_pool\_id](#output\_azurerm\_lb\_backend\_address\_pool\_id) | The id of load balancer address pool |

## Execution

```sh
terraform init -backend-config ../../../backend.tfvars  && terraform apply -var-file ../../common.tfvars -var-file ../../../backend.tfvars -var-file ../group.tfvars
```
