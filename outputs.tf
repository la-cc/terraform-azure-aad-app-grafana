output "application_id" {
  value       = azuread_application.main.id
  description = "The Application ID (also called Client ID)."
}

output "object_id" {
  value       = azuread_application.main.object_id
  description = "The Applications object ID."
}
