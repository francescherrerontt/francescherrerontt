# custom names
ntt_naming_convention = true
custom_stdiagsql_name = null

# Load balancers definition
sql_servers = {
  "sqlserver01skel" = {
    database_name                  = "demomssqldb01"
    sql_database_edition           = "Standard"
    sqldb_service_objective_name   = "S1"
    enable_auditing_policy         = true
    enable_threat_detection_policy = true
    log_retention_days             = 30
    email_addresses_for_alerts     = ["user@example.com"]
    # AD administrator for an Azure SQL server
    enable_sql_ad_admin = true
    ad_admin_login_name = "firstname.lastname@example.com"

    # Advanced threat protection
    enable_log_analytics           = false
    log_analytics_workspace_sku    = "PerGB2018"
    log_analytics_workspace_name   = null
    create_log_analytics_workspace = true

    # Firewall Rules to allow azure and external clients
    enable_firewall_rules = true
    firewall_rules = [
      { name             = "access-to-azure"
        start_ip_address = "0.0.0.0"
      end_ip_address = "0.0.0.0" },
      { name             = "desktop-ip"
        start_ip_address = "123.201.75.71"
    end_ip_address = "123.201.75.71" }]

    # Sql failover group
    enable_failover_group         = false
    secondary_sql_server_location = "northeurope"
    sql_failover_group_name       = "thisisdisabled"

    initialize_sql_script_execution = false
    sqldb_init_script_file          = "./artifacts/db-init-sample.sql"

  }
  "sqlserver02skel" = {
    database_name                  = "demomssqldb02"
    sql_database_edition           = "Standard"
    sqldb_service_objective_name   = "S1"
    enable_auditing_policy         = false
    enable_threat_detection_policy = false
    log_retention_days             = 30
    email_addresses_for_alerts     = []
    # AD administrator for an Azure SQL server
    enable_sql_ad_admin = true
    ad_admin_login_name = "firstname.lastname@example.com"

    # Advanced threat protection
    enable_log_analytics           = false
    log_analytics_workspace_sku    = "PerGB2018"
    log_analytics_workspace_name   = null
    create_log_analytics_workspace = true

    # Firewall Rules to allow azure and external clients
    enable_firewall_rules = false
    firewall_rules        = []

    # Sql failover group
    enable_failover_group         = true
    secondary_sql_server_location = "northeurope"
    sql_failover_group_name       = "sqlserver02skelfog"


    initialize_sql_script_execution = false
    sqldb_init_script_file          = "./artifacts/db-init-sample.sql"

  }
}
