# Create virtual wan and virtual hubs
module "virtualwan" {
  source = "git::git@scm.capside.com:terraform/azure/ntt-terraform-azurerm-vwan.git?ref=ntt/1.0.2"

  create_virtual_wan                   = true
  create_virtual_hubs                  = true
  create_virtual_hub_vpn_configuration = false
  create_virtual_hub_vpn_client        = false
  create_route_tables                  = false
  create_virtual_hub_vnet_connections  = false

  virtual_wan_name    = var.ntt_naming_convention ? lower(format("vwan-%s-%s", var.ntt_environment, substr(var.ntt_service_group, 0, 49))) : var.custom_virtual_wan_name
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location            = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location

  virtual_hubs = var.virtual_hubs

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

locals {
  # We convert known names to ids
  vpn_gateways_with_ids = {
    for name, info in var.vpn_gateways : name => {
      virtual_hub_id = module.virtualwan.virtual_hub_ids[info.virtual_hub_id]
      location       = info.location
      scale_unit     = info.scale_unit
      bgp_settings   = info.bgp_settings
    }
  }
  vpn_client_gateways_with_ids = {
    for name, info in var.vpn_client_gateways : name => {
      location                 = info.location
      vpn_server_configuration = info.vpn_server_configuration
      virtual_hub_id           = module.virtualwan.virtual_hub_ids[info.virtual_hub_name]
      scale_unit               = info.scale_unit
      vpn_client_address_pools = info.vpn_client_address_pools
      routing                  = info.routing
    }
  }
  route_tables_with_ids = {
    for name, info in var.route_tables : name => {
      virtual_hub_id = module.virtualwan.virtual_hub_ids[info.virtual_hub_id]
      labels         = info.labels
      routes = {
        for route_name, route_info in info.routes : route_name => {
          destinations      = route_info.destinations
          destinations_type = route_info.destinations_type
          next_hop_id       = contains(keys(var.azurefws), route_info.next_hop_id) ? module.azurefw[route_info.next_hop_id].firewall_id : route_info.next_hop_id
          next_hop_type     = lookup(route_info, "next_hop_type", null)
        }
      }
    }
  }
}

# Create vpns, route tables and vnet connections
module "virtualwan_configuration" {
  source = "git::git@scm.capside.com:terraform/azure/ntt-terraform-azurerm-vwan.git?ref=ntt/1.0.2"

  create_virtual_wan                   = false
  create_virtual_hubs                  = false
  create_virtual_hub_vpn_configuration = true
  create_virtual_hub_vpn_client        = true
  create_route_tables                  = true
  create_virtual_hub_vnet_connections  = false

  import_virtual_wan_id = module.virtualwan.virtual_wan_id
  resource_group_name   = data.terraform_remote_state.global_rg.outputs.resource_group_name

  location = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location

  vpn_gateways = local.vpn_gateways_with_ids
  vpn_sites    = var.vpn_sites

  route_tables = local.route_tables_with_ids

  virtual_hub_vpn_connections = var.virtual_hub_vpn_connections

  vpn_server_configurations = var.vpn_server_configurations

  vpn_client_gateways = local.vpn_client_gateways_with_ids

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

  depends_on = [
    module.virtualwan,
    module.azurefw
  ]
}
