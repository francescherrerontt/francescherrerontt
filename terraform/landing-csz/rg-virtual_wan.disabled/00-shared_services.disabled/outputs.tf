output "resource_group_name" {
  description = "Resource group name"
  value       = azurerm_resource_group.global.name
}

output "resource_group_location" {
  description = "Resource group location"
  value       = azurerm_resource_group.global.location
}

output "keyvault_id" {
  description = "The ids of keyvault created"
  value       = azurerm_key_vault.global.id
}

output "keyvault_uri" {
  description = "The uri of keyvault created"
  value       = azurerm_key_vault.global.vault_uri
}

output "workspace_id" {
  description = "The id of the workspace created"
  value       = azurerm_log_analytics_workspace.global.id
}
