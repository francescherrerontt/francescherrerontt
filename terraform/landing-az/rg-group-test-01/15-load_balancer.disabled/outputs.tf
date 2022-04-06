output "azurerm_lb_backend_address_pool_id" {
  description = "The id of load balancer address pool"
  value = tomap({
    for k, v in module.loadbalancers : k => v.azurerm_lb_backend_address_pool_id
  })
}