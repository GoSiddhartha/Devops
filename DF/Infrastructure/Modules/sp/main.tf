resource "azuread_application" "app" {
  name = var.sp_name
}

resource "azuread_service_principal" "sp" {
  application_id = azuread_application.app.application_id

  depends_on = [azuread_application.app]
}

resource "azuread_service_principal_password" "password" {
  service_principal_id = azuread_service_principal.sp.id
  value                = random_password.application_server_password.result
  end_date             = timeadd(timestamp(), "87600h") 

  lifecycle {
    ignore_changes = [end_date]
  }
  depends_on = [azuread_service_principal.sp]
}

resource "random_password" "application_server_password" {
  length  = 16
  special = true

  keepers = {
    application = azuread_application.app.application_id
  }
}