

variable "subnet_name" {
  description = "App subnet name"
}

variable "subnet_address_prefixes" {
  description = "App subnet address prefixes"
  type = set(string)
}

variable "subnet_resource_group_name" {
  description = "Resorce Group of the network"
}

variable "subnet_virtual_network_name" {
  description = "Virtual Network Name"
}

variable "subnet_service_endpoints" {
  type = list
  description = "List of Service Enspoints"
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}