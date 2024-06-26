variable "network_security_group_name" {
  description = "Network Security Group Name"
}

variable "resource_group_name" {
  description = "Resorce Group of the network"
}

variable "security_rule" {
  description = "Network Security Rule Definition"

  type = map(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_ranges         = string
    destination_port_ranges    = string
    source_address_prefix      = string
    destination_address_prefix = string
    description                = string

  }))

  default = {}

}

variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}