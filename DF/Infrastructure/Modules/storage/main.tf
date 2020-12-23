variable "storage_account_depends_on" {
  # the value doesn't matter; we're just using this variable
  # to propagate dependencies.
  type    = any
  default = []
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  is_hns_enabled = var.is_hns_enabled

  # This resource depends on whatever the variable
  # depends on, indirectly. This is the same
  # as using var.storage_account_depends_on in
  # an expression above, but for situations where
  # we don't actually need the value.
  depends_on = [var.storage_account_depends_on]
}