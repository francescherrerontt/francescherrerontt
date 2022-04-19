
output "virtual_hub_vnet_connection_ids" {
  description = "IDs of the virtual hub vnet connections"
  value       = module.virtualwan_connections.virtual_hub_vnet_connection_ids
}
