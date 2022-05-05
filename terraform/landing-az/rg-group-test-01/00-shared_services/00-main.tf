locals {
  common_tags = {
    "ntt_monitoring"     = var.ntt_monitoring
    "ntt_environment"    = var.ntt_environment
    "ntt_platform"       = var.ntt_platform
    "ntt_service_group"  = var.ntt_service_group
    "ntt_service_level"  = var.ntt_service_level
    "ntt_auto_cloud_iac" = var.ntt_auto_cloud_iac
  }
}
resource "azurerm_resource_group" "global" {
  name     = var.custom_rg_name
  location = var.location
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "azurerm_storage_account" "storage_account" {
  name    = var.storage_account_name
  resource_group_name = azurerm_resource_group.global.name
  location = azurerm_resource_group.global.location
  account_tier = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "container" {
  for_each = toset(var.containers)
  name = each.value
  storage_account_name = azurerm_storage_account.storage_account.name
  container_access_type = "private" 
}