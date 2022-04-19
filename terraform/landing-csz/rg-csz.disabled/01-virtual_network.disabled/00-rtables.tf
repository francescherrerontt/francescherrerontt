#routetables supporting virtualAppliance
module "routetableva" {
  source                        = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-routetable.git?ref=ntt/1.0.2"
  for_each                      = var.route_tablesva
  resource_group_name           = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location                      = var.location
  route_table_name              = var.ntt_naming_convention ? lower(format("route-%s-%s-%s", var.ntt_environment, var.ntt_service_group, each.key)) : each.key
  route_prefixes                = each.value.routes[*].prefix
  route_nexthop_types           = each.value.routes[*].nexthop_type
  route_names                   = each.value.routes[*].name
  route_nexthop_ips             = each.value.routes[*].route_nexthop_ips
  disable_bgp_route_propagation = each.value.disable_bgp_route_propagation
  enable_va                     = true

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "azurerm_subnet_route_table_association" "rtableva" {
  for_each = var.route_tablesva_assoc

  route_table_id = module.routetableva[each.value].routetable_id
  subnet_id      = module.vnet-prod.vnet_subnets[index(var.subnet_objects.*.name, each.key)]
}
