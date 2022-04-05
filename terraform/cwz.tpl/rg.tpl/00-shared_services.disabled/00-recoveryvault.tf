#-----------------------------------------------
# Recovery Services vault for VM backup
#-----------------------------------------------

module "recovery_vault" {
  source = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-recovery-vault.git?ref=ntt/1.0.3"

  resource_group_name        = azurerm_resource_group.global.name
  location                   = azurerm_resource_group.global.location
  recovery_vault_name        = var.ntt_naming_convention ? lower(format("rv-%s-%s", var.ntt_environment, substr(var.ntt_service_group, 0, 17))) : var.custom_rv_name
  log_analytics_workspace_id = data.terraform_remote_state.csz_shared.outputs.workspace_id
  tags                       = var.common_tags

  soft_delete_enabled = var.soft_delete_enabled

  # VM backup settings
  vm_backup_policy_timezone           = var.vm_backup_policy_timezone
  vm_backup_policy_time               = var.vm_backup_policy_time
  vm_backup_policy_retention_days     = var.vm_backup_policy_retention_days
  vm_backup_policy_retention_weeks    = var.vm_backup_policy_retention_weeks
  vm_backup_policy_retention_months   = var.vm_backup_policy_retention_months
  vm_backup_policy_retention_weekdays = var.vm_backup_policy_retention_weekdays
}
