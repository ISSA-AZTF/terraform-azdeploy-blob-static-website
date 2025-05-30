
output "primary_endpoint" {
  description = "URL du site web statique hébergé sur le Storage Account"
  value       = azurerm_storage_account.sa.primary_web_endpoint
}

output "storage_account_id" {
  description = "L'ID du storage account"
  value       = azurerm_storage_account.sa.id
}

output "storage_account_name" {
  description = "Nom du storage account"
  value       = azurerm_storage_account.sa.name
}