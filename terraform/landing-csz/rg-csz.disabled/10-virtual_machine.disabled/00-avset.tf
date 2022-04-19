variable "avset" {
  description = "This is the availability set definition map"
  type        = map(any)
  default     = {}
}
resource "azurerm_availability_set" "vm" {
  for_each                     = var.avset
  name                         = var.ntt_naming_convention ? lower(substr(format("avset-%s-%s-%s", var.ntt_environment, var.ntt_service_group, each.key), 0, 79)) : each.key
  resource_group_name          = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location                     = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  platform_fault_domain_count  = each.value.platform_fault_domain_count
  platform_update_domain_count = each.value.platform_update_domain_count
  managed                      = true
  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
