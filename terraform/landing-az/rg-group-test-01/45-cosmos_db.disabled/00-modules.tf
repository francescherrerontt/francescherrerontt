module "cosmosdb" {
  for_each = var.cosmos_dbs
  source   = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-cosmos-db.git?ref=ntt/1.0.0"

  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location            = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location

  custom_server_name    = var.ntt_naming_convention ? lower(substr(format("vm%s%s", var.ntt_environment, each.key), 0, 60)) : each.key
  logs_destinations_ids = each.value.logs_destinations_ids
  backup                = each.value.backup
  allowed_cidrs         = each.value.allowed_cidrs
  failover_locations    = each.value.failover_locations
  kind                  = each.value.kind


  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
