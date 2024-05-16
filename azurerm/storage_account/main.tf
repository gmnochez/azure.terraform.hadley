resource "azurerm_storage_account" "ktc-storage" {
  name                            = var.name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  min_tls_version                 = var.min_tls_version
  queue_encryption_key_type       = var.queue_encryption_key_type
  table_encryption_key_type       = var.table_encryption_key_type         


  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}