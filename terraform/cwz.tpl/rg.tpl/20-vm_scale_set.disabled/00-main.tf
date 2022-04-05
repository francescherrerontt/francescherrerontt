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
resource "random_string" "password" {
  length      = 34
  min_upper   = 4
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}
resource "azurerm_key_vault_secret" "provisioning" {
  name         = "provisioning-scale"
  value        = random_string.password.result
  key_vault_id = data.terraform_remote_state.global_rg.outputs.keyvault_id

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
