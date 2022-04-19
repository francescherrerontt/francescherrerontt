output "address_space" {
  value = module.vnet-prod.vnet_address_space
}

output "subnets" {
  description = "The ids of subnets created inside the newl vNet"
  value       = module.vnet-prod.vnet_subnets
}

output "vnet_id" {
  description = "The id of the virtual network"
  value       = module.vnet-prod.vnet_id
}

output "routetable_ids" {
  description = "Route table ids"
  value       = { for rt, id in module.routetableva : rt => id.routetable_id }
}

output "vnet_name" {
  description = "Virtual network name"
  value       = module.vnet-prod.vnet_name
}

output "subscription_id" {
  description = "Subscription id"
  value       = data.azurerm_subscription.current.subscription_id
}