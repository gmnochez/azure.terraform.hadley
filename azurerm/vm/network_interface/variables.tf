variable "name" {
  description = "Name Interface"
}

variable "location" {
  description = "Location Interface"
}

variable "resource_group_name" {
  description = "Resource Group Name"
}

variable "ip_configuration_name" {
  description = "Ip Configuration Name"
}

variable "ip_configuration_subnet_id" {
  description = "Ip Configuration Subnet Id"
}

variable "ip_configuration_private_ip_address_allocation" {
  description = "Ip Configuration Private Ip Allocation"
}

variable "ip_configuration_private_ip_address" {
  description = "Ip Configuration Private IP"
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}