output "resource_group_name" {
  description = "The name of resource group created"
  # Adding quotes as these are required later in the backend configuration
  value = azurerm_resource_group.states.name
}

output "storage_account_name" {
  description = "The name of storage account created"
  # Adding quotes as these are required later in the backend configuration
  value = module.storage_account.storage_account_name
}

output "container_name" {
  description = "The name of storage container created"
  # Adding quotes as these are required later in the backend configuration
  value = local.state_container_name
}

output "subscription_id" {
  description = "The name of storage subscription id created"
  # Adding quotes as these are required later in the backend configuration
  value = data.azurerm_subscription.current.subscription_id
}
