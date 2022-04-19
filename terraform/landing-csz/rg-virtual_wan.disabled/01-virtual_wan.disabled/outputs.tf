output "subscription_id" {
  description = "Subscription id"
  value       = data.azurerm_client_config.current.subscription_id
}

# Virtual WAN
output "virtual_wan_id" {
  description = "ID of the virtual wan"
  value       = module.virtualwan.virtual_wan_id
}

output "virtual_hub_ids" {
  description = "IDs of the virtual hubs"
  value       = module.virtualwan.virtual_hub_ids
}

output "virtual_hub_vpn_gateway_ids" {
  description = "IDs of the virtual hubs vpn gateways"
  value       = module.virtualwan_configuration.virtual_hub_vpn_gateway_ids
}

output "virtual_hub_route_table_ids" {
  description = "IDs of the virtual hub route tables created"
  value       = module.virtualwan_configuration.virtual_hub_route_table_ids
}

output "virtual_hub_vpn_bgp_and_ip_configuration" {
  description = "Virtual hub bgp configuration, including public IP used for vpn peer."
  value       = module.virtualwan_configuration.virtual_hub_vpn_bgp_and_ip_configuration
}

# Azure firewall
output "azurefw_ids" {
  description = "Azure firewall Id"
  value       = { for name, info in module.azurefw : name => info.firewall_id }
}

output "azurefw_policy_ids" {
  description = "Azure firewall policy id"
  value       = { for name, info in module.azurefw : name => info.firewall_policy_id }
}
