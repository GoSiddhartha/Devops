resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = var.is_admin_enabled

  # This resource depends on whatever the variable
  # depends on, indirectly. This is the same
  # as using var.storage_account_depends_on in
  # an expression above, but for situations where
  # we don't actually need the value.
  depends_on = [var.acr_depends_on]
}

resource "azurerm_role_assignment" "acrpull_sp" {
  count                = length(var.acrpull_service_principals)
  scope                = azurerm_container_registry.acr.id
  role_definition_name = "AcrPull"
  principal_id         = var.acrpull_service_principals[count.index]

  depends_on = [azurerm_container_registry.acr]
}