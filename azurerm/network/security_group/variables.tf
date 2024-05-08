variable "resource_group_name" {
  description = "Resource group name"
}

variable "location" {
  description = "Location"
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}