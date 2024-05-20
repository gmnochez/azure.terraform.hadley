
variable "name" {
  description = "Private Dns Name"
}
variable "zone_name" {
  description = "Private Dns zone name"
}
variable "resource_group_name" {
  description = "Private Dns resource group name"
}
variable "ttl" {
  description = "Private Dns ttl"
}
variable "records" {
  description = "Private Dns records"
  type = list(any)
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}