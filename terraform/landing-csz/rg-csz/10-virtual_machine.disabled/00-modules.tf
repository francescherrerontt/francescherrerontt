module "windowsservers" {
  for_each             = var.virtual_machines_w
  source               = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-compute.git?ref=ntt/1.4.0"
  resource_group_name  = data.terraform_remote_state.global_rg.outputs.resource_group_name
  is_windows_image     = true
  vm_hostname          = var.ntt_naming_convention ? lower(substr(format("vm%s%s", var.ntt_environment, each.key), 0, 13)) : each.key
  admin_username       = "nttrmadm"
  admin_password       = azurerm_key_vault_secret.provisioning.value
  vm_os_publisher      = "MicrosoftWindowsServer"
  vm_os_offer          = "WindowsServer"
  vm_os_sku            = "2019-Datacenter-gensecond"
  virtual_network_name = data.terraform_remote_state.vnet.outputs.vnet_name
  vnet_subnet_name     = each.value.vnet_subnet_name
  allocation_method    = "Dynamic"
  nb_public_ip         = each.value.nb_public_ip
  os_disk              = each.value.os_disk
  vm_size              = each.value.vm_size
  extra_disks          = each.value.extra_disks
  avset_id             = each.value.avset_name != "" ? azurerm_availability_set.vm[each.value.avset_name].id : null
  diag_storage_uri     = azurerm_storage_account.diag.primary_blob_endpoint
  identity_type        = ""
  recovery_vault_name  = data.terraform_remote_state.global_rg.outputs.recovery_services_vault_name
  vm_backup_policy_id  = data.terraform_remote_state.global_rg.outputs.vm_backup_policy_id
  private_ip_address   = each.value.private_ip_address != null ? [each.value.private_ip_address] : null
  #disk_encryption_set_id = azurerm_disk_encryption_set.disk-encryption-set.id  ##  Uncomment if you are configuring SSE with CMK
  encryption_at_host_enabled = each.value.encryption_at_host_enabled

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

}
/*
module "linuxservers" {
  for_each             = var.virtual_machines_l
  source               = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-compute.git?ref=ntt/1.4.0"
  resource_group_name  = data.terraform_remote_state.global_rg.outputs.resource_group_name
  vm_hostname          = var.ntt_naming_convention ? lower(substr(format("vm%s%s",var.ntt_environment,each.key),0,60)) : each.key
  admin_username       = "nttrmadm"
  ssh_key              = var.ssh_key
  vm_os_simple         = "UbuntuServer"
  virtual_network_name = data.terraform_remote_state.vnet.outputs.vnet_name
  vnet_subnet_name     = each.value.vnet_subnet_name  
  nb_public_ip         = each.value.nb_public_ip
  public_ip_dns        = each.value.public_ip_dns
  vm_size              = each.value.vm_size
  extra_disks          = each.value.extra_disks
  avset_id             = each.value.avset_name != "" ? azurerm_availability_set.vm[each.value.avset_name].id : null
  diag_storage_uri     = azurerm_storage_account.diag.primary_blob_endpoint
  custom_data          = filebase64("./scripts/azure-salt.sh")
  identity_type        = "SystemAssigned"
  recovery_vault_name  = data.terraform_remote_state.global_rg.outputs.recovery_services_vault_name
  vm_backup_policy_id  = data.terraform_remote_state.global_rg.outputs.vm_backup_policy_id
  private_ip_address   = each.value.private_ip_address != null ? [each.value.private_ip_address] : null
  #disk_encryption_set_id = azurerm_disk_encryption_set.disk-encryption-set.id  ##  Uncomment if you are configuring SSE with CMK
  encryption_at_host_enabled = each.value.encryption_at_host_enabled

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

}
*/
