output "name" {
  description = "Name of the resource group"
  value       = azurerm_batch_account.ba.name
}

output "accesskey" {
  description = "Location of the resource group"
  value       = azurerm_batch_account.ba.primary_access_key
}

output "endpoint" {
  description = "Location of the resource group"
  value       = azurerm_batch_account.ba.account_endpoint
}

