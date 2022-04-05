# virtual_wan

## Introduction

This module belongs to customer-sample NTT main modules and is responsible for:

* Creation and management of Virtual WANs
* Creation and management of Virtual Hubs
* Creation and management of VPN Sites
* Creation and management of Virtual Hub routing tables
* VPN connections to hubs
* Creation and management of Azure FWs in Virtual Hubs (including fw policy via Firewal Manager)
* Creation and management of Point-To-Site User VPNs (with Azure Active Directory authentication)

## External module requirements

- [ntt-terraform-azurerm-vwan](https://scm.capside.com/terraform/azure/ntt-terraform-azurerm-vwan)
- [terraform-azurerm-azurefw](https://scm.capside.com/terraform/azure/terraform-azurerm-azurefw)


## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>2.61.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azurefw"></a> [azurefw](#module\_azurefw) | git::git@scm.capside.com:terraform/azure/terraform-azurerm-azurefw.git | ntt/1.1.1 |
| <a name="module_virtualwan"></a> [virtualwan](#module\_virtualwan) | git::git@scm.capside.com:terraform/azure/ntt-terraform-azurerm-vwan.git | ntt/1.0.2 |
| <a name="module_virtualwan_configuration"></a> [virtualwan\_configuration](#module\_virtualwan\_configuration) | git::git@scm.capside.com:terraform/azure/ntt-terraform-azurerm-vwan.git | ntt/1.0.2 |

## Resources

| Name | Type |
|------|------|
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [terraform_remote_state.global_rg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurefw_rule_collection_group"></a> [azurefw\_rule\_collection\_group](#input\_azurefw\_rule\_collection\_group) | List of rule collection groups to add to the firewall policy. Requires `use_firewall_manager` set to `true` | `map` | `{}` | no |
| <a name="input_azurefws"></a> [azurefws](#input\_azurefws) | List of azure fws to deploy | `map(any)` | `{}` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Key/Value of global tags to apply to created resources | `map(any)` | `{}` | no |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Backend container | `string` | n/a | yes |
| <a name="input_custom_virtual_wan_name"></a> [custom\_virtual\_wan\_name](#input\_custom\_virtual\_wan\_name) | Custom virtual wan name | `string` | `""` | no |
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
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | Map of virtual hub route tables to create | `map(any)` | `{}` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Backend storage account | `string` | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Backend subscription\_id | `string` | n/a | yes |
| <a name="input_virtual_hub_vpn_connections"></a> [virtual\_hub\_vpn\_connections](#input\_virtual\_hub\_vpn\_connections) | Map of virtual hub vpn connections to create. | `map(any)` | `{}` | no |
| <a name="input_virtual_hubs"></a> [virtual\_hubs](#input\_virtual\_hubs) | Virtual hubs to create | `map(any)` | `{}` | no |
| <a name="input_vpn_client_gateways"></a> [vpn\_client\_gateways](#input\_vpn\_client\_gateways) | Map of virtual hub Point-To-Site User VPN gateways to create. | `map(any)` | `{}` | no |
| <a name="input_vpn_gateways"></a> [vpn\_gateways](#input\_vpn\_gateways) | Map of vpn gateways to create. | `map(any)` | `{}` | no |
| <a name="input_vpn_server_configurations"></a> [vpn\_server\_configurations](#input\_vpn\_server\_configurations) | Map of virtual hub user vpn server configurations to create. | `map(any)` | `{}` | no |
| <a name="input_vpn_sites"></a> [vpn\_sites](#input\_vpn\_sites) | Map of vpn sites to create. | `map(any)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurefw_ids"></a> [azurefw\_ids](#output\_azurefw\_ids) | Azure firewall Id |
| <a name="output_azurefw_policy_ids"></a> [azurefw\_policy\_ids](#output\_azurefw\_policy\_ids) | Azure firewall policy id |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | Subscription id |
| <a name="output_virtual_hub_ids"></a> [virtual\_hub\_ids](#output\_virtual\_hub\_ids) | IDs of the virtual hubs |
| <a name="output_virtual_hub_route_table_ids"></a> [virtual\_hub\_route\_table\_ids](#output\_virtual\_hub\_route\_table\_ids) | IDs of the virtual hub route tables created |
| <a name="output_virtual_hub_vpn_bgp_and_ip_configuration"></a> [virtual\_hub\_vpn\_bgp\_and\_ip\_configuration](#output\_virtual\_hub\_vpn\_bgp\_and\_ip\_configuration) | Virtual hub bgp configuration, including public IP used for vpn peer. |
| <a name="output_virtual_hub_vpn_gateway_ids"></a> [virtual\_hub\_vpn\_gateway\_ids](#output\_virtual\_hub\_vpn\_gateway\_ids) | IDs of the virtual hubs vpn gateways |
| <a name="output_virtual_wan_id"></a> [virtual\_wan\_id](#output\_virtual\_wan\_id) | ID of the virtual wan |

## Execution

```
 terraform init -backend-config ../../../backend.tfvars  && terraform apply -var-file ../../common.tfvars -var-file ../../../backend.tfvars -var-file ../group.tfvars
```