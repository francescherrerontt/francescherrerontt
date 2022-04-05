aks_kubenet = {
  "testecom" = {
    kubernetes_version        = "1.21.7"
    orchestrator_version      = "1.21.7"
    agents_size               = "Standard_D2s_v3"
    os_disk_size_gb           = 60
    agents_min_count          = 3
    agents_max_count          = 4
    agents_max_pods           = 60
    agents_availability_zones = ["1", "2", "3"]
    agents_labels = {
      "node" : "testecom"
    }
    agents_tags = {
      "Agent" : "agentTagIBST"
    }
  },
  "testhr" = {
    kubernetes_version        = "1.21.7"
    orchestrator_version      = "1.21.7"
    agents_size               = "Standard_D2s_v3"
    os_disk_size_gb           = 70
    agents_min_count          = 2
    agents_max_count          = 3
    agents_max_pods           = 70
    agents_availability_zones = ["1", "2"]
    agents_labels = {
      "node" : "tsribs2"
      "env" : "prod"
    }
    agents_tags = {
      "Agent" : "agentTagIBST2"
    }
  },
}

aks_resource_pool = {
  "power" = {
    aks                       = "testecom"
    agents_size               = "Standard_D2s_v3"
    os_disk_size_gb           = 65
    agents_min_count          = 2
    agents_max_count          = 3
    agents_max_pods           = 60
    agents_availability_zones = ["1", "2", "3"]
    agents_labels = {
      "node" : "usertestecom"
    }
    agents_tags = {
      "Agent" : "agentTag"
    }
  },
  "superpower" = {
    aks                       = "testecom"
    agents_size               = "Standard_D4s_v3"
    os_disk_size_gb           = 70
    agents_min_count          = 3
    agents_max_count          = 4
    agents_max_pods           = 50
    agents_availability_zones = ["1", "2", "3"]
    agents_labels = {
      "node" : "usertestecom"
    }
    agents_tags = {
      "Agent" : "agentTag"
    }
  },
  "power" = {
    aks                       = "testhr"
    agents_size               = "Standard_D2s_v3"
    os_disk_size_gb           = 70
    agents_min_count          = 2
    agents_max_count          = 3
    agents_max_pods           = 70
    agents_availability_zones = ["1", "2"]
    agents_labels = {
      "node" : "usertsribs2"
      "env" : "prod"
    }
    agents_tags = {
      "Agent" : "agentTag"
    }
  },
}