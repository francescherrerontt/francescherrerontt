variable "custom_firewall_name" {
  description = "Custom name for the firewall"
  type        = string
  default     = null
}

variable "firewall_application_rules" {
  description = "List of application rules to apply to firewall."
  type        = map(any)
  default     = {}
}

variable "firewall_network_rules" {
  description = "List of network rules to apply to firewall."
  type        = map(any)
  default     = {}
}

variable "firewall_nat_rules" {
  description = "List of nat rules to apply to firewall."
  type        = map(any)
  default     = {}
}

module "azurefw" {
  source = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-azurefw.git?ref=ntt/1.1.1"

  azurefw_name               = var.ntt_naming_convention ? lower(format("fw-%s-%s", var.ntt_environment, substr(var.ntt_service_group, 0, 49))) : var.custom_firewall_name
  azurefw_type               = "vnet"
  location                   = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  resource_group_name        = data.terraform_remote_state.global_rg.outputs.resource_group_name
  log_analytics_workspace_id = data.terraform_remote_state.global_rg.outputs.workspace_id
  firewall_zones             = [1, 2, 3]
  subnet_id                  = module.vnet-prod.vnet_subnets[1]

  use_firewall_manager = false

  firewall_application_rules = var.firewall_application_rules
  firewall_network_rules     = var.firewall_network_rules
  firewall_nat_rules         = var.firewall_nat_rules

  dns_proxy_enabled = false

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

}
