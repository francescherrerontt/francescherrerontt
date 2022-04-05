output "azurerm_service_buses_namespace_id" {
  description = "The Namespace ID of the Service Bus"
  value = tomap({
    for k, v in module.service_bus : k => v.id
  })
}
