output "storage_account_id" {
  description = "Storage accounts ids"
  value       = { for db, id in module.storage_account : db => id.storage_account_id }
}

output "storage_account_name" {
  description = "Storage accounts names"
  value       = { for db, id in module.storage_account : db => id.storage_account_name }
}
