data "azurerm_subscription" "current" {
}

locals {
  common_tags = {
    "ntt_monitoring"     = var.ntt_monitoring
    "ntt_environment"    = var.ntt_environment
    "ntt_platform"       = var.ntt_platform
    "ntt_service_group"  = var.ntt_service_group
    "ntt_service_level"  = var.ntt_service_level
    "ntt_auto_cloud_iac" = var.ntt_auto_cloud_iac
  }
  state_container_name = lower(substr(format("ct-%s-%s", var.ntt_environment, replace(var.ntt_platform, "/[_.]/", "")), 0, 63))
}

resource "azurerm_resource_group" "states" {
  name     = var.resource_group_name
  location = var.location
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "random_id" "ststate" {
  keepers = {
    rg_name = var.resource_group_name
  }

  byte_length = 2
}

module "storage_account" {
  source = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-storage.git?ref=ntt/1.0.1"

  storage_account_name = var.ntt_naming_convention ? lower(format("st%s%s%s", var.ntt_environment, substr(replace(var.ntt_service_group, "/[_.-]/", ""), 0, 9), random_id.ststate.hex)) : var.custom_st_name
  resource_group_name  = azurerm_resource_group.states.name
  location             = azurerm_resource_group.states.location

  enable_versioning                 = true
  enable_advanced_threat_protection = true
  skuname                           = "Standard_GRS"
  containers_list = [
    { name = local.state_container_name, access_type = "private" }
  ]


  tags = merge(
    local.common_tags,
    var.resource_tags
  )

  depends_on = [azurerm_resource_group.states]
}
