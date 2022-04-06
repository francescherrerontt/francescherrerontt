output "sql_servers_ids" {
  description = "Primary SQL servers ids"
  value       = { for server, id in module.sqlserver : server => id.primary_sql_server_id }
}
