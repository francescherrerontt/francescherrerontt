service_buses = {
  "servicebusntt01" = {
    topics = [
      {
        name                = "sourcentt01"
        enable_partitioning = true
        subscriptions = [
          {
            name               = "sourcentt01"
            forward_to         = "destinationntt01"
            max_delivery_count = 1
          }
        ]
      },
      {
        name                = "destinationntt01"
        enable_partitioning = true
      }
    ]
    queues = []
  }
  "servicebusntt02" = {
    topics = []
    queues = [
      {
        name = "queuentt01"
        authorization_rules = [
          {
            name   = "example"
            rights = ["listen", "send"]
          }
        ]
      }
    ]
  }
}
