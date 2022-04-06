locals {
  hub_virtual_network_id   = data.terraform_remote_state.vnet_csz.outputs.vnet_id
  hub_resource_group_name  = element(split("/", local.hub_virtual_network_id), 4)
  hub_virtual_network_name = element(split("/", local.hub_virtual_network_id), 8)
}

resource "azurerm_virtual_network_peering" "spoke_to_hub" {
  name                         = lower("peering-${module.vnet-prod.vnet_name}-to-${local.hub_virtual_network_name}")
  resource_group_name          = data.terraform_remote_state.global_rg.outputs.resource_group_name
  virtual_network_name         = module.vnet-prod.vnet_name
  remote_virtual_network_id    = local.hub_virtual_network_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

resource "azurerm_virtual_network_peering" "hub_to_spoke" {
  name                         = lower("peering-${local.hub_virtual_network_name}-to-${module.vnet-prod.vnet_name}")
  resource_group_name          = local.hub_resource_group_name
  virtual_network_name         = local.hub_virtual_network_name
  remote_virtual_network_id    = module.vnet-prod.vnet_id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true
  use_remote_gateways          = false
  provider                     = azurerm.csz
}

