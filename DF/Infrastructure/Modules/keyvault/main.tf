# Configuration of the AzureRM provider
data "azurerm_client_config" "current" {}

locals {
  access_policies = concat([
    # Current signed-in user in CLI
    {
      object_id          = data.azurerm_client_config.current.object_id
      key_permissions    = ["create", "get", "list"]
      secret_permissions = ["set", "get", "list", "delete"]
    },
  ], var.access_policies)
}

resource "azurerm_key_vault" "key_vault" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku
  tenant_id           = data.azurerm_client_config.current.tenant_id

  enabled_for_disk_encryption = true

  soft_delete_enabled = true
  tags                = var.tags
}

resource "azurerm_key_vault_access_policy" "access_policy" {
  count = length(local.access_policies)

  key_vault_id       = azurerm_key_vault.key_vault.id
  tenant_id          = data.azurerm_client_config.current.tenant_id
  object_id          = local.access_policies[count.index]["object_id"]
  key_permissions    = local.access_policies[count.index]["key_permissions"]
  secret_permissions = local.access_policies[count.index]["secret_permissions"]
}