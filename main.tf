#***********************
# Resource Group
#***********************
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
#***********************
# Chaîne de caractère
#***********************
resource "random_string" "random" {
  length      = 7
  special     = false
  upper       = false
  min_numeric = 3
}
#***********************
# Storage Account
#***********************
resource "azurerm_storage_account" "sa" {
  name                     = lower(coalesce(var.storage_account_name, "mystorage${random_string.random.result}"))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = lookup(var.account_type, "account_tier", null)
  account_replication_type = lookup(var.account_type, "replication_type", null)
  tags                     = merge({ "environment" = var.tags }, var.global_tags)
}
#**************************
# Activation Static web site
#**************************
resource "azurerm_storage_account_static_website" "test" {
  storage_account_id = azurerm_storage_account.sa.id
  error_404_document = trim(var.error_file, " ")
  index_document     = trim(var.index_file, " ")
}
#***********************
# Azure blob storages
#***********************
resource "azurerm_storage_blob" "index_blob" {
  for_each               = var.blob_storage != null ? var.blob_storage : {}
  name                   = each.value.name
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = each.value.storage_container_name
  type                   = each.value.type
  content_type           = each.value.content_type # Obligatoire pour afficher le contenu sur le web
  source                 = each.value.source
  depends_on             = [azurerm_storage_account_static_website.test]
}