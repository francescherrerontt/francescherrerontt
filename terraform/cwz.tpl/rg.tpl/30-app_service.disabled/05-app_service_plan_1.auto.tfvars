app_service_plans = {
  "devPlan" = {
    custom_app_service_plan_name = "plan-development"
    kind                         = "Linux"
    sku = {
      tier = "PremiumV2"
      size = "P1v2"
    }
    scaling = {
      enabled   = true
      max_count = 3
      rules = [
        {
          condition = "CpuPercentage > 80 avg 5m"
          scale     = "out 1"
        },
        {
          condition = "CpuPercentage < 35 avg 10m"
          scale     = "in 1"
        }
      ]
    }
  }
}
