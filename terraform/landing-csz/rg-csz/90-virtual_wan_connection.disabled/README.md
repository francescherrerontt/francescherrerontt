# virtual_wan_connection

## Introduction

This module belongs to customer-sample NTT main modules and is responsible for creating a connection between the vnet in this resource group and one (or more) Virtual Hubs.

## Pre-requisites

Before this module can be executed, virtual wan needs to be deployed.

Virtual wan configuration can be found in:

```bash
terraform\landing-global\rg-virtual_wan
```

## External module requirements

- [ntt-terraform-azurerm-vwan](https://scm.capside.com/terraform/azure/ntt-terraform-azurerm-vwan)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_virtualwan_connections"></a> [virtualwan\_connections](#module\_virtualwan\_connections) | ../../../../../modules/ntt-terraform-azurerm-vwan | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.global_virtual_wan](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.virtual_network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Backend container | `string` | n/a | yes |
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
| <a name="output_virtual_hub_vnet_connection_ids"></a> [virtual\_hub\_vnet\_connection\_ids](#output\_virtual\_hub\_vnet\_connection\_ids) | IDs of the virtual hub vnet connections |


## Execution

```
 terraform init -backend-config ../../../backend.tfvars  && terraform apply -var-file ../../common.tfvars -var-file ../../../backend.tfvars -var-file ../group.tfvars
```