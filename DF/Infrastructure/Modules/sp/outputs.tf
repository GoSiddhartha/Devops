output "sp_password" {
  value = random_password.application_server_password.result
}

output "sp_id" {
  value = azuread_service_principal.sp.id
}

output "sp_client_id" {
  value = azuread_application.app.application_id
}

