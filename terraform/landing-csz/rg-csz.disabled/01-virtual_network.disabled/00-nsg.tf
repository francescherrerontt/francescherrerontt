# security groups
resource "azurerm_network_security_group" "nsg" {
  for_each = var.nsg_assoc

  name                = var.ntt_naming_convention ? lower(format("nsg-%s-%s-%s", var.ntt_environment, var.ntt_service_group, each.key)) : each.key
  location            = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}

resource "azurerm_network_security_rule" "custom_rules" {
  for_each = var.nsg

  name                         = each.key
  priority                     = each.value.priority
  direction                    = "Inbound"
  access                       = each.value.action
  protocol                     = each.value.protocol
  source_port_range            = contains(each.value.source_port_ranges, "*") ? "*" : null
  source_port_ranges           = contains(each.value.source_port_ranges, "*") ? null : each.value.source_port_ranges
  destination_port_range       = contains(each.value.destination_port_ranges, "*") ? "*" : null
  destination_port_ranges      = contains(each.value.destination_port_ranges, "*") ? null : each.value.destination_port_ranges
  source_address_prefix        = contains(each.value.source_address_prefixes, "*") ? "*" : null
  source_address_prefixes      = contains(each.value.source_address_prefixes, "*") ? null : each.value.source_address_prefixes
  destination_address_prefix   = contains(each.value.destination_address_prefixes, "*") ? "*" : null
  destination_address_prefixes = contains(each.value.destination_address_prefixes, "*") ? null : each.value.destination_address_prefixes
  description                  = each.value.description
  resource_group_name          = data.terraform_remote_state.global_rg.outputs.resource_group_name
  network_security_group_name  = var.ntt_naming_convention ? lower(format("nsg-%s-%s-%s", var.ntt_environment, var.ntt_service_group, each.value.nsg_name)) : each.value.nsg_name
  depends_on                   = [azurerm_network_security_group.nsg]
}

resource "azurerm_network_security_rule" "deny_all" {
  for_each = var.nsg_assoc

  name                        = "DenyAll"
  priority                    = "4000"
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  description                 = "DenyAll"
  resource_group_name         = data.terraform_remote_state.global_rg.outputs.resource_group_name
  network_security_group_name = var.ntt_naming_convention ? lower(format("nsg-%s-%s-%s", var.ntt_environment, var.ntt_service_group, each.key)) : each.key

  depends_on = [azurerm_network_security_group.nsg]
}

# attach nsg to subnet 1 to 1 relationship
resource "azurerm_subnet_network_security_group_association" "main" {
  for_each = var.nsg_assoc

  subnet_id                 = module.vnet-prod.vnet_subnets[each.value.subnet_id]
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
