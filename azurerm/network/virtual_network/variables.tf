variable "location" {
  description = "Location"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "main_virtual_network_name" {
  description = "Virtual network name"
}

variable "main_virtual_network_address_space" {
  description = "Virtual network address space"
  type = set(string)
}


