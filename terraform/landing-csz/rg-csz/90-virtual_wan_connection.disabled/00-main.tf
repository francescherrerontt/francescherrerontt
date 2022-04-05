
# Note
# -------
# Virtual wan main configuration can be found at `landing-global/rg-virtual_wan'.
# Here we are only configuring the connection to an existent virtual hub.
# Make sure virtual hub configuration has been build first

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

# Creates a connection to the specified virtual hub (virtual wan)
module "virtualwan_connections" {
  source = "git::git@scm.capside.com:terraform/azure/ntt-terraform-azurerm-vwan.git?ref=ntt/1.0.2"

  create_virtual_wan                   = false
  create_virtual_hubs                  = false
  create_virtual_hub_vpn_configuration = false
  create_virtual_hub_vpn_client        = false
  create_route_tables                  = false
  create_virtual_hub_vnet_connections  = true

  import_virtual_wan_id = data.terraform_remote_state.global_virtual_wan.outputs.virtual_wan_id

  # Modify as required
  virtual_hub_vnet_connections = {
    "cn-vnet-vwan-csz" = {
      virtual_hub_id            = data.terraform_remote_state.global_virtual_wan.outputs.virtual_hub_ids["vhub_01"]
      vnet_id                   = data.terraform_remote_state.virtual_network.outputs.vnet_id
      internet_security_enabled = true
      routing = {
        associated_route_table_id     = data.terraform_remote_state.global_virtual_wan.outputs.virtual_hub_route_table_ids["rt-vwan-vhub_01-default"]
        propagated_route_table_labels = []
        propagated_route_table_ids    = ["none"]
      }
    }
  }

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}



