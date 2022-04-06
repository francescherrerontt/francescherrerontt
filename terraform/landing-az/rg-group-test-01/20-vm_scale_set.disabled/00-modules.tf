module "windowsscale" {
  for_each                        = var.vm_scale_set_w
  source                          = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-vm-scale-sets.git?ref=ntt/1.0.3"
  resource_group_name             = data.terraform_remote_state.global_rg.outputs.resource_group_name
  disable_password_authentication = false
  subnet_name                     = each.value.subnet_name
  vmscaleset_name                 = var.ntt_naming_convention ? lower(substr(format("vmsss-%s-%s-%s", var.ntt_environment, var.ntt_service_group, each.key), 0, 63)) : each.key
  vm_computer_name                = var.ntt_naming_convention ? lower(substr(format("vm%s", each.value.vm_computer_name), 0, 8)) : each.value.vm_computer_nam
  os_flavor                       = each.value.os_flavor
  virtual_machine_size            = each.value.virtual_machine_size

  instances_count      = each.value.instances_count
  admin_username       = "nttrmadm"
  admin_password       = azurerm_key_vault_secret.provisioning.value
  virtual_network_name = data.terraform_remote_state.vnet.outputs.vnet_name

  load_balancer_type                 = each.value.load_balancer_type
  load_balancer_health_probe_port    = each.value.load_balancer_health_probe_port
  load_balanced_port_list            = each.value.load_balanced_port_list
  additional_data_disks              = each.value.additional_data_disks
  windows_distribution_name          = "windows2019dc"
  enable_autoscale_for_vmss          = true
  minimum_instances_count            = each.value.minimum_instances_count
  maximum_instances_count            = each.value.maximum_instances_count
  scale_out_cpu_percentage_threshold = each.value.scale_out_cpu_percentage_threshold
  scale_in_cpu_percentage_threshold  = each.value.scale_in_cpu_percentage_threshold

  nsg_inbound_rules = each.value.nsg_inbound_rules

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

module "linuxscale" {
  for_each                = var.vm_scale_set_l
  source                  = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-vm-scale-sets.git?ref=ntt/1.0.3"
  resource_group_name     = data.terraform_remote_state.global_rg.outputs.resource_group_name
  subnet_name             = each.value.subnet_name
  vmscaleset_name         = var.ntt_naming_convention ? lower(substr(format("vmsss-%s-%s", var.ntt_environment, each.key), 0, 63)) : each.key
  vm_computer_name        = var.ntt_naming_convention ? lower(substr(format("vm%s", each.value.vm_computer_name), 0, 8)) : each.value.vm_computer_name
  os_flavor               = "linux"
  generate_admin_ssh_key  = false
  linux_distribution_name = "ubuntu1804"
  virtual_machine_size    = each.value.virtual_machine_size
  admin_ssh_key_data      = var.ssh_key
  instances_count         = each.value.instances_count
  admin_username          = "nttrmadm"
  virtual_network_name    = data.terraform_remote_state.vnet.outputs.vnet_name

  load_balancer_type              = each.value.load_balancer_type
  load_balancer_health_probe_port = each.value.load_balancer_health_probe_port
  load_balanced_port_list         = each.value.load_balanced_port_list
  additional_data_disks           = each.value.additional_data_disks

  enable_autoscale_for_vmss          = true
  minimum_instances_count            = each.value.minimum_instances_count
  maximum_instances_count            = each.value.maximum_instances_count
  scale_out_cpu_percentage_threshold = each.value.scale_out_cpu_percentage_threshold
  scale_in_cpu_percentage_threshold  = each.value.scale_in_cpu_percentage_threshold
  identity_type                      = "SystemAssigned"

  nsg_inbound_rules = each.value.nsg_inbound_rules

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
