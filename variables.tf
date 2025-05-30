variable "resource_group_name" {
  type        = string
  description = "Nom du groupe de ressources"
}
variable "location" {
  type        = string
  description = "Localisation des ressources azure"
}
variable "tags" {
  type        = string
  description = "Tag du storage account"
}
variable "global_tags" {
  type        = map(string)
  description = "Un tag global pour les ressources azure"
}
variable "account_type" {
  type        = map(string)
  description = "Tier du compte de stockage"
}
variable "storage_account_name" {
  type        = string
  default     = ""
  description = "Nom du compte de stockage"
}
variable "error_file" {
  type = string
  validation {
    condition     = endswith(var.error_file, "html")
    error_message = "le fichier error doit être un fichier .html"
  }
}
variable "index_file" {
  type = string
  validation {
    condition     = endswith(var.index_file, "html")
    error_message = "le fichier index doit être un fichier .html"
  }
}
variable "blob_storage" {
  type = map(object({
    name                   = string
    storage_container_name = string
    type                   = string
    content_type           = string
    source                 = string
  }))
  description = "Dictionnaire de blobs"
}