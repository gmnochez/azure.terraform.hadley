data "azurerm_network_security_group" "nsg" {
  name                = var.name_nsg
  resource_group_name = var.resource_group_name_nsg

}


resource "azurerm_network_interface_security_group_association" "ktc-association" {
  network_interface_id      = azurerm_network_interface.hadley_resource.id
  network_security_group_id = data.azurerm_network_security_group.nsg.id
}


data "azurerm_network_interface" "interface" {
  name                = var.name
  resource_group_name = var.resource_group_name

}

output "network_interface_id" {
  value = data.azurerm_network_interface.interface.id
}


resource "azurerm_network_interface" "hadley_resource" {
  
  id                  = output.network_interface_id
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_configuration_name
    subnet_id                     = var.ip_configuration_subnet_id
    private_ip_address_allocation = var.ip_configuration_private_ip_address_allocation
    private_ip_address            = var.ip_configuration_private_ip_address
  }

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}