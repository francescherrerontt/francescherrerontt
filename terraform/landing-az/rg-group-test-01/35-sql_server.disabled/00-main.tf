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
resource "azurerm_storage_account" "storeacc" {
  name                      = var.ntt_naming_convention ? lower(format("stlogsql%s%s%s", var.ntt_environment, substr(replace(var.ntt_service_group, "/[_.-]/", ""), 0, 9), random_id.diag.hex)) : var.custom_stdiagsql_name
  resource_group_name       = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location                  = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "GRS"
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
}
