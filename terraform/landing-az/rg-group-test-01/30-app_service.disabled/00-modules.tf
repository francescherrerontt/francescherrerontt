module "appServicePlans" {
  for_each            = var.app_service_plans
  source              = "git@scm.capside.com:terraform/azure/terraform-azurerm-app-service-plan.git?ref=ntt/1.0.1"
  app_service_name    = each.value.custom_app_service_plan_name
  location            = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  resource_group_name = data.terraform_remote_state.global_rg.outputs.resource_group_name
  kind                = each.value.kind
  sku                 = each.value.sku
  scaling             = each.value.scaling

  tags = merge(
    local.common_tags,
    var.resource_tags
  )
}
