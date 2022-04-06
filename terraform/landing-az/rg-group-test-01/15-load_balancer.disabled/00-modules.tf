module "loadbalancers" {
  for_each = var.load_balancers

  source                                 = "git@scm.capside.com:terraform/azure/terraform-azurerm-loadbalancer.git?ref=ntt/1.1.0"
  resource_group_name                    = data.terraform_remote_state.global_rg.outputs.resource_group_name
  name                                   = var.ntt_naming_convention ? lower(substr(format("lb-%s-%s", var.ntt_environment, each.key), 0, 60)) : each.key
  pip_name                               = var.ntt_naming_convention ? lower(substr(format("pip-%s-%s-lb", var.ntt_environment, each.key), 0, 60)) : each.value.pip_name
  lb_probe_unhealthy_threshold           = each.value.lb_probe_unhealthy_threshold
  lb_probe_interval                      = each.value.lb_probe_interval
  frontend_name                          = "lbPublicIp"
  remote_port                            = each.value.remote_port
  lb_port                                = each.value.lb_port
  lb_probe                               = each.value.lb_probe
  allocation_method                      = each.value.allocation_method
  type                                   = each.value.type
  frontend_subnet_name                   = each.value.frontend_subnet_name
  frontend_vnet_name                     = data.terraform_remote_state.vnet.outputs.vnet_name
  frontend_private_ip_address            = each.value.frontend_private_ip_address
  frontend_private_ip_address_allocation = each.value.frontend_private_ip_address_allocation
  pip_domain_name_label                  = each.value.pip_domain_name_label
  pip_availability_zone                  = each.value.pip_availability_zone
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard"
  enable_floating_ip                     = each.value.enable_floating_ip

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "azurerm_lb_backend_address_pool_address" "ips" {
  for_each = var.lb_ips_asoc

  name                    = each.key
  backend_address_pool_id = module.loadbalancers[each.value.lb].azurerm_lb_backend_address_pool_id
  virtual_network_id      = data.terraform_remote_state.vnet.outputs.vnet_id
  ip_address              = each.value.ip
}

resource "azurerm_network_interface_backend_address_pool_association" "nics" {
  for_each = var.lb_nics_asoc

  ip_configuration_name   = each.key
  backend_address_pool_id = module.loadbalancers[each.value.lb].azurerm_lb_backend_address_pool_id
  network_interface_id    = each.value.id
}
