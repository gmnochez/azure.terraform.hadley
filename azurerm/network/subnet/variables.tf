

variable "app_subnet_name" {
  description = "App subnet name"
}

variable "app_subnet_address_prefixes" {
  description = "App subnet address prefixes"
  type = set(string)
}

variable "app_subnet_resource_group_name" {
  description = "Resorce Group of the network"
}

variable "app_subnet_virtual_network_name" {
  description = "Virtual Network Name"
}

variable "app_subnet_service_endpoints" {
  type = list
  description = "List of Service Enspoints"
}


