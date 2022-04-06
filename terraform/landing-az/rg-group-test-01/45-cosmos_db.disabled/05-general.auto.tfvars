# Cosmos databases definitions
cosmos_dbs = {
  "cosmosdb01skelntt" = {
    kind                              = "GlobalDocumentDB"
    logs_destinations_ids             = []
    is_virtual_network_filter_enabled = false
    allowed_cidrs                     = ["83.1.2.3/32", "84.1.3.4/32"]
    consistency_policy_level          = "Eventual"
    backup = {
      type                = "Periodic"
      interval_in_minutes = 60 * 3 # 3 hours
      retention_in_hours  = 24
    }
    failover_locations = {
      "nttfailovertestlocation" = {
        location = "northeurope"
      }
    }
  }
  "cosmosdb02skelntt" = {
    kind                              = "MongoDB"
    logs_destinations_ids             = []
    is_virtual_network_filter_enabled = false
    allowed_cidrs                     = ["81.1.2.3/32"]
    consistency_policy_level          = "Session"
    backup = {
      type = "Continuous"
    }
    failover_locations = {
      "nttfailovertestlocation02" = {
        location = "centralus"
      }
    }
  }
}
