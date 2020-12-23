output "objectid" {
  value = "${ var.df_enable_gitsync ? azurerm_data_factory.df_git[0].identity.0.principal_id : azurerm_data_factory.df[0].identity.0.principal_id}"
}

