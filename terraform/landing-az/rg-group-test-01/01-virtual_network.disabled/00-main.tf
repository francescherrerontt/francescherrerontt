locals {
  common_tags = {
    "ntt_monitoring"     = var.ntt_monitoring
    "ntt_environment"    = var.ntt_environment
    "ntt_platform"       = var.ntt_platform
    "ntt_service_group"  = var.ntt_service_group
    "ntt_service_level"  = var.ntt_service_level
    "ntt_auto_cloud_iac" = var.ntt_auto_cloud_iac
  }
}
module "vnet-prod" {
  source              = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-network.git?ref=ntt/1.1.0"
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  vnet_name           = var.ntt_naming_convention ? lower(format("vnet-%s-%s", var.ntt_environment, substr(var.ntt_service_group, 0, 69))) : var.custom_vnet_name

  dns_servers     = var.dns_servers
  address_space   = var.address_space
  subnet_prefixes = var.subnet_objects[*].prefix
  subnet_names    = var.subnet_objects[*].name

  delegations                                           = var.delegations
  subnet_enforce_private_link_endpoint_network_policies = var.subnet_enforce_private_link_endpoint_network_policies
  subnet_service_endpoints                              = var.subnet_service_endpoints

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

}