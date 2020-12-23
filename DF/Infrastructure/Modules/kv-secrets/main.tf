resource "azurerm_key_vault_secret" "secrets" {
  count        = length(var.kv_secrets)  

  name         = var.kv_keys[count.index]
  value        = var.kv_secrets[count.index]
  key_vault_id = var.kv_id

}