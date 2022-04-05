module "service_bus" {
  source              = "git@scm.capside.com:terraform/azure/terraform-azurerm-service-bus.git?ref=ntt/1.0.0"
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name

  for_each = var.service_buses
  name     = var.ntt_naming_convention ? lower(substr(format("sb-%s-%s", var.ntt_environment, each.key), 0, 60)) : each.key

  topics = each.value.topics
  queues = each.value.queues

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
