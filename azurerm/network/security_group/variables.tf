variable "name" {
  description = "Resource group name"
}

variable "resource_group_name" {
  description = "Resorce Group of the network"
}

variable "location" {
  description = "Location"
}



variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}