# virtual_network module

## Introduction

This module belongs to customer-sample NTT main modules and it will do actions related to virtual networks like, the following:
- create vnet
- create route tables
- create nsg
- create azure fw
- create vpn/ExpressRoute

## ExpressRoute

In case of using ExpressRoute, the circuit needs to be provisioned before the connection can be created. First iteration will create the circuit and the ExpressRoute Virtual Network Gateway, and will provide the service key (`expressroute_circuit_service_key`) required to provision the circuit. Once the circuit has been provisioned, change `expressroute_circuit_provisioned` variable in `/*/rg-csz/virtual_network/05-expressroute.auto.tfvars` to `true` and re-apply the configuration again. This will create the missing required connections.

In case the circuit id is already provisioned and should not be managed via Terraform, you can provide the circuit id via `expressroute_circuit_id` variable in `/*/rg-csz/virtual_network/05-expressroute.auto.tfvars`. This will prevent the creation of a new circuit via terraform, and use this one instead. *Note: This option still requires `expressroute_circuit_provisioned` to be set to `true`.

## External module requirements

- Azure/network/azurerm
- [terraform-azurerm-routetable](https://scm.capside.com/terraform/azure/terraform-azurerm-routetable)
- [terraform-azurerm-virtual-network-gateway](https://scm.capside.com/terraform/azure/terraform-azurerm-virtual-network-gateway)
- [terraform-azurerm-azurefw](https://scm.capside.com/terraform/azure/terraform-azurerm-azurefw)

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=0.14.4 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>2.86.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>2.86.0 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azurefw"></a> [azurefw](#module\_azurefw) | git::git@scm.capside.com:terraform/azure/terraform-azurerm-azurefw.git | ntt/1.1.1 |
| <a name="module_routetableva"></a> [routetableva](#module\_routetableva) | git::git@scm.capside.com:terraform/azure/terraform-azurerm-routetable.git | ntt/1.0.2 |
| <a name="module_vnet-prod"></a> [vnet-prod](#module\_vnet-prod) | git::git@scm.capside.com:terraform/azure/terraform-azurerm-network.git | ntt/1.1.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_network_security_group.nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_rule.custom_rules](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_network_security_rule.deny_all](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_rule) | resource |
| [azurerm_subnet_network_security_group_association.main](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.rtableva](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |
| [terraform_remote_state.global_rg](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | The address space that is used by the virtual network. | `string` | n/a | yes |
| <a name="input_container_name"></a> [container\_name](#input\_container\_name) | Backend container | `string` | n/a | yes |
| <a name="input_custom_firewall_name"></a> [custom\_firewall\_name](#input\_custom\_firewall\_name) | Custom name for the firewall | `string` | `null` | no |
| <a name="input_custom_vnet_name"></a> [custom\_vnet\_name](#input\_custom\_vnet\_name) | Custom name for the virtual network | `string` | `null` | no |
| <a name="input_delegations"></a> [delegations](#input\_delegations) | A map with key (string) `subnet name`, value (map of delegations for this subnet) to indicate delegations to create. Default value is {}. | `map(any)` | `{}` | no |
| <a name="input_dns_servers"></a> [dns\_servers](#input\_dns\_servers) | The DNS servers to be used with vNet. | `list(any)` | `[]` | no |
| <a name="input_firewall_application_rules"></a> [firewall\_application\_rules](#input\_firewall\_application\_rules) | List of application rules to apply to firewall. | `map(any)` | `{}` | no |
| <a name="input_firewall_nat_rules"></a> [firewall\_nat\_rules](#input\_firewall\_nat\_rules) | List of nat rules to apply to firewall. | `map(any)` | `{}` | no |
| <a name="input_firewall_network_rules"></a> [firewall\_network\_rules](#input\_firewall\_network\_rules) | List of network rules to apply to firewall. | `map(any)` | `{}` | no |
| <a name="input_location"></a> [location](#input\_location) | This is the location to deploy resources | `string` | `"westeurope"` | no |
| <a name="input_nsg"></a> [nsg](#input\_nsg) | Custom map for several nsg | `map(any)` | `{}` | no |
| <a name="input_nsg_assoc"></a> [nsg\_assoc](#input\_nsg\_assoc) | Associates security groups to | `map(any)` | `{}` | no |
| <a name="input_ntt_auto_cloud_iac"></a> [ntt\_auto\_cloud\_iac](#input\_ntt\_auto\_cloud\_iac) | NTT IaC environment identified. Create Automation Managed System per deployment. | `string` | `null` | no |
| <a name="input_ntt_environment"></a> [ntt\_environment](#input\_ntt\_environment) | Productive environment type. Possible values: pro, pre, dev, int, qa, dr | `string` | `"dev"` | no |
| <a name="input_ntt_monitoring"></a> [ntt\_monitoring](#input\_ntt\_monitoring) | Defines wether the resources should be monitored or not. Possible values: 0, 1 | `string` | `"1"` | no |
| <a name="input_ntt_naming_convention"></a> [ntt\_naming\_convention](#input\_ntt\_naming\_convention) | Set to 'true' to autogenerate resource names using NTT naming convention. Name variables will be used as tags inside the names. Set to 'false' to use name variables as resource names | `bool` | `true` | no |
| <a name="input_ntt_platform"></a> [ntt\_platform](#input\_ntt\_platform) | The platform represents a group of systems that underpins one or more critical business functions. This grouping is done per environments (Production, Pre-production, DR, Development, etc.) and per specific functions (DMZ, Backup solution, Marketing site, Email service etc.) | `string` | `null` | no |
| <a name="input_ntt_service_group"></a> [ntt\_service\_group](#input\_ntt\_service\_group) | The service group is a category to group CIs that have a similar function in a platform | `string` | `null` | no |
| <a name="input_ntt_service_level"></a> [ntt\_service\_level](#input\_ntt\_service\_level) | As defined in Service Now u\_service\_level\_label table: 24x7, EU\_10x5, US\_10x5 | `string` | `"24x7"` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Backend storage resource group | `string` | n/a | yes |
| <a name="input_resource_tags"></a> [resource\_tags](#input\_resource\_tags) | Key/Value of tags to apply to created resources | `map(any)` | `{}` | no |
| <a name="input_route_tables"></a> [route\_tables](#input\_route\_tables) | Custom map for route tables supporting Valid values are 'VirtualNetworkGateway', 'VnetLocal', 'Internet', 'HyperNetGateway', 'None' | `map(any)` | `{}` | no |
| <a name="input_route_tablesva"></a> [route\_tablesva](#input\_route\_tablesva) | Custom map for route tables supporting Virtual appliance | `map(any)` | `{}` | no |
| <a name="input_route_tablesva_assoc"></a> [route\_tablesva\_assoc](#input\_route\_tablesva\_assoc) | List of associations between route tables and subnets | `map(any)` | `{}` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Backend storage account | `string` | n/a | yes |
| <a name="input_subnet_enforce_private_link_endpoint_network_policies"></a> [subnet\_enforce\_private\_link\_endpoint\_network\_policies](#input\_subnet\_enforce\_private\_link\_endpoint\_network\_policies) | A map with key (string) `subnet name`, value (bool) `true` or `false` to indicate enable or disable network policies for the private link endpoint on the subnet. Default value is false. | `map(bool)` | `{}` | no |
| <a name="input_subnet_objects"></a> [subnet\_objects](#input\_subnet\_objects) | List of subnet objects | <pre>list(object({<br>    name   = string<br>    prefix = string<br>  }))</pre> | `[]` | no |
| <a name="input_subnet_service_endpoints"></a> [subnet\_service\_endpoints](#input\_subnet\_service\_endpoints) | A map with key (string) `subnet name`, value (list(string)) to indicate enabled service endpoints on the subnet. Default value is {}. | `map(list(string))` | `{}` | no |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | Backend subscription\_id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address_space"></a> [address\_space](#output\_address\_space) | n/a |
| <a name="output_routetable_ids"></a> [routetable\_ids](#output\_routetable\_ids) | Route table ids |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | The ids of subnets created inside the newl vNet |
| <a name="output_subscription_id"></a> [subscription\_id](#output\_subscription\_id) | Subscription id |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | The id of the virtual network |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | Virtual network name |

## Execution

```
 terraform init -backend-config ../../../backend.tfvars  && terraform apply -var-file ../../common.tfvars -var-file ../../../backend.tfvars -var-file ../group.tfvars
```
