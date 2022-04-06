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

resource "random_id" "diag" {
  keepers = {
    resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  }

  byte_length = 2
}

resource "azurerm_storage_account" "diag" {
  name                     = var.ntt_naming_convention ? lower(format("stdiag%s%s%s", var.ntt_environment, substr(replace(var.ntt_service_group, "/[_.-]/", ""), 0, 9), random_id.diag.hex)) : var.custom_stdiag_name
  resource_group_name      = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location                 = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  account_tier             = element(split("_", var.boot_diagnostics_sa_type), 0)
  account_replication_type = element(split("_", var.boot_diagnostics_sa_type), 1)
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "random_string" "password" {
  length      = 24
  min_upper   = 2
  min_lower   = 2
  min_numeric = 2
  min_special = 2
}

resource "azurerm_key_vault_secret" "provisioning" {
  name         = "provisioning"
  value        = random_string.password.result
  key_vault_id = data.terraform_remote_state.global_rg.outputs.keyvault_id

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
