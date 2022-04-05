module "sqlserver" {
  for_each = var.sql_servers
  source   = "git::git@scm.capside.com:terraform/azure/terraform-azurerm-azuresql.git?ref=ntt/1.2.1"

  # Resource Group, VNet and Subnet declarations
  create_resource_group         = false
  resource_group_name           = data.terraform_remote_state.global_rg.outputs.resource_group_name
  location                      = var.location != "" ? var.location : data.terraform_remote_state.global_rg.outputs.resource_group_location
  virtual_network_name          = data.terraform_remote_state.vnet.outputs.vnet_name
  private_subnet_address_prefix = "10.0.5.0/29"

  # SQL Server and Database scaling options
  sqlserver_name               = var.ntt_naming_convention ? lower(substr(format("sql-%s-%s", var.ntt_environment, each.key), 0, 60)) : each.key
  database_name                = var.ntt_naming_convention ? lower(substr(format("sqldb-%s-%s", var.ntt_environment, each.value.database_name), 0, 60)) : each.value.database_name
  sql_database_edition         = each.value.sql_database_edition
  sqldb_service_objective_name = each.value.sqldb_service_objective_name

  # SQL Server and Database Audit policies
  storage_auditlogs_name         = azurerm_storage_account.storeacc.name
  enable_auditing_policy         = each.value.enable_auditing_policy
  enable_threat_detection_policy = each.value.enable_threat_detection_policy
  log_retention_days             = each.value.log_retention_days
  email_addresses_for_alerts     = each.value.email_addresses_for_alerts
  enable_log_analytics           = each.value.enable_log_analytics
  log_analytics_workspace_sku    = each.value.log_analytics_workspace_sku
  log_analytics_workspace_name   = each.value.log_analytics_workspace_name
  create_log_analytics_workspace = each.value.create_log_analytics_workspace


  # AD administrator for an Azure SQL server
  enable_sql_ad_admin = each.value.enable_sql_ad_admin
  ad_admin_login_name = each.value.ad_admin_login_name

  # Firewall Rules to allow azure and external clients
  enable_firewall_rules = each.value.enable_firewall_rules
  firewall_rules        = each.value.firewall_rules

  # Sql failover group
  enable_failover_group         = each.value.enable_failover_group
  secondary_sql_server_location = each.value.secondary_sql_server_location
  sql_failover_group_name       = each.value.sql_failover_group_name


  # Create and initialize a database with SQL script
  initialize_sql_script_execution = each.value.initialize_sql_script_execution
  sqldb_init_script_file          = each.value.sqldb_init_script_file


  tags = merge(
    local.common_tags,
    var.resource_tags
  )

  depends_on = [azurerm_storage_account.storeacc]
}

