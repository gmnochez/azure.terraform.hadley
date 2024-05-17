resource "azurerm_network_interface" "hadley_resource" {
  
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