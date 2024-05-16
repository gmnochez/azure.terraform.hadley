variable "name" {
  description = "Resource Account Name"
}

variable "resource_group_name" {
  description = "Resource Account Resource Name"
}

variable "location" {
  description = "Resource Account Location"
}

variable "account_tier" {
  description = "Account Tier Name"
}

variable "account_replication_type" {
  description = "Account Replication Type"
}

variable "allow_nested_items_to_be_public" {
  description = "Switch allow public items"
  type = bool
}

variable "min_tls_version" {
  description = "Min TLS"
}


variable "queue_encryption_key_type" {
  description = "Queue Encryptation Key Type"
}


variable "table_encryption_key_type" {
  description = "Table Encryptation Key Type"
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}