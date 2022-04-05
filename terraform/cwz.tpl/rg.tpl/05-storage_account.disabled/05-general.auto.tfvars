# Storage Accounts definitions
storage_accounts = {
  "storagentt01" = {
    enable_advanced_threat_protection = true

    # Container lists with access_type to create
    containers_list = [
      { name = "mystore250", access_type = "private" },
      { name = "blobstore251", access_type = "blob" },
      { name = "containter252", access_type = "container" }
    ]

    # SMB file share with quota (GB) to create
    file_shares = []

    # Storage tables
    tables = []

    # Storage queues
    queues = ["queue1", "queue2"]

    # Last access time based tracking policy must be enabled
    # before using its specific actions in object lifecycle management policy
    last_access_time_enabled = true

    lifecycles = [
      {
        prefix_match               = ["mystore250/folder_path"]
        tier_to_cool_after_days    = 0
        tier_to_archive_after_days = 50
        delete_after_days          = 100
        snapshot_delete_after_days = 30
      },
      {
        prefix_match               = ["blobstore251/another_path"]
        tier_to_cool_after_days    = 0
        tier_to_archive_after_days = 30
        delete_after_days          = 75
        snapshot_delete_after_days = 30
      }
    ]

  }
  "storagentt02" = {
    enable_advanced_threat_protection = false

    # Container lists with access_type to create
    containers_list = []

    # SMB file share with quota (GB) to create
    file_shares = [
      { name = "smbfileshare1", quota = 50 },
      { name = "smbfileshare2", quota = 50 }
    ]

    # Storage tables
    tables = ["table1", "table2", "table3"]

    # Storage queues
    queues = []

    # Last access time based tracking policy must be enabled
    # before using its specific actions in object lifecycle management policy  
    last_access_time_enabled = false

    lifecycles = []
  }
}
