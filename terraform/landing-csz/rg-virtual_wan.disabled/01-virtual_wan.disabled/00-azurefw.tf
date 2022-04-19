
module "azurefw" {
  for_each = var.azurefws
  source   = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-azurefw.git?ref=ntt/1.1.1"

  azurefw_name        = each.key
  azurefw_type        = "vhub"
  location            = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name

  use_firewall_manager          = true
  azurefw_rule_collection_group = var.azurefw_rule_collection_group

  virtual_hub_id = module.virtualwan.virtual_hub_ids[each.value.virtual_hub_name]

  virtual_hub_public_ip_count = each.value.public_ip_count

  log_analytics_workspace_id = data.terraform_remote_state.global_rg.outputs.workspace_id

  dns_proxy_enabled = false

  tags = merge(
    local.common_tags,
    var.resource_tags
  )

  depends_on = [module.virtualwan]

}
