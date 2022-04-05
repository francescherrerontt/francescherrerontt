output "cosmos_db_accounts_ids" {
  description = "Cosmos DB accounts ids"
  value       = { for db, id in module.cosmosdb : db => id.cosmosdb_id }
}
