resource "azurerm_data_factory" "df" {
  count               = var.df_enable_gitsync  ? 0 : 1

  name                = var.df_name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type         = var.identity_type
  }
}

resource "azurerm_data_factory" "df_git" {
  count               = var.df_enable_gitsync  ? 1 : 0  

  name                = var.df_name
  resource_group_name = var.resource_group_name
  location            = var.location

  identity {
    type = var.identity_type
  }

  vsts_configuration {
    account_name    = var.vsts_account_name
    project_name    = var.vsts_project_name
    repository_name = var.vsts_repository_name
    branch_name     = var.vsts_branch_name
    root_folder     = var.vsts_root
    tenant_id       = var.tenant_id
  }
}

resource "azurerm_key_vault_access_policy" "df" {
  count               = var.df_enable_gitsync  ? 0 : 1

  key_vault_id        = var.kv_id
  tenant_id           = var.tenant_id
  object_id           = azurerm_data_factory.df[0].identity.0.principal_id

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}

resource "azurerm_key_vault_access_policy" "df_git" {
  count               = var.df_enable_gitsync  ? 1 : 0

  key_vault_id        = var.kv_id
  tenant_id           = var.tenant_id
  object_id           = azurerm_data_factory.df_git[0].identity.0.principal_id

  key_permissions = [
    "get",
  ]

  secret_permissions = [
    "get",
  ]
}