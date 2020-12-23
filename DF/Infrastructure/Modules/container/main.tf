resource "azurerm_storage_container" "boatswain" {
  name                  = var.name
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}