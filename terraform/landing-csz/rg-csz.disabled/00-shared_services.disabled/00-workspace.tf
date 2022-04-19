#-----------------------------------------------
# Log analytics workspace  for Logs analysis
#-----------------------------------------------

resource "azurerm_log_analytics_workspace" "global" {
  name                = var.ntt_naming_convention ? lower(format("logaws-%s-%s", var.ntt_environment, substr(var.ntt_service_group, 0, 17))) : var.custom_logaws_name
  resource_group_name = azurerm_resource_group.global.name
  location            = azurerm_resource_group.global.location
  sku                 = var.log_analytics_workspace_sku
  retention_in_days   = var.log_analytics_logs_retention_in_days
  tags                = var.common_tags
}
