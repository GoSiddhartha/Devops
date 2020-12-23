output "connection" {
  description = "Storage account connection string"
  value       = azurerm_storage_account.sa.primary_connection_string
}

output "storagekey" {
  description = "Storage account storage key"
  value       = azurerm_storage_account.sa.primary_access_key 
}

output "name" {
  description = "Storage account name"
  value       = azurerm_storage_account.sa.name
}

output "id" {
  description = "Storage account id"
  value       = azurerm_storage_account.sa.id
}
