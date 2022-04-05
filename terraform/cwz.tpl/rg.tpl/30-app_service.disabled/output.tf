output "app_service_plans_ids" {
  description = "App service plans ids"
  value       = { for plan, id in module.appServicePlans : plan => id.app_service_plan_id }
}
