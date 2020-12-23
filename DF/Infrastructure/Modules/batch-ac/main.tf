resource "azurerm_batch_account" "ba" {
  name                 = var.batch_account_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  pool_allocation_mode = var.allocation_mode
  storage_account_id   = var.storage_account_id
}