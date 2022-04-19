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
  name     = var.ntt_naming_convention ? lower(format("rg-%s-%s", var.ntt_environment, substr(var.ntt_service_group, 0, 53))) : var.custom_rg_name
  location = var.location
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}