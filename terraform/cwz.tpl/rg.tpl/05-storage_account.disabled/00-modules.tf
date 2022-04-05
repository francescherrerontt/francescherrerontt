module "storage_account" {
  for_each = var.storage_accounts
  source   = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-storage.git?ref=ntt/1.0.1"

  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location            = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location

  storage_account_name              = each.key
  enable_advanced_threat_protection = each.value.enable_advanced_threat_protection
  containers_list                   = each.value.containers_list
  file_shares                       = each.value.file_shares
  tables                            = each.value.tables
  queues                            = each.value.queues
  lifecycles                        = each.value.lifecycles
  last_access_time_enabled          = each.value.last_access_time_enabled


  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
