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


variable "ddos_protection_plan_enable" {
  description = "DDOS protection switch"
  type = bool
}

variable "ddos_protection_plan_id" {
  description = "Id resource DDOS"
  
}

variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}



