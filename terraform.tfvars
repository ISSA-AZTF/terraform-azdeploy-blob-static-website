resource_group_name = "test-resource-group"
location            = "West Europe"
tags                = "Prod"
global_tags = {
  "Department" = "IT"
}
account_type = {
  "account_tier"     = "Standard"
  "replication_type" = "LRS"
}
error_file = "404.html"
index_file = "index.html"
blob_storage = {
  "blob1" = {
    name                   = "index.html"
    storage_container_name = "$web"
    type                   = "Block"
    content_type           = "text/html"
    source                 = "index.html"
  }
  "blob2" = {
    name                   = "404.html"
    storage_container_name = "$web"
    type                   = "Block"
    content_type           = "text/html"
    source                 = "404.html"
  }
}