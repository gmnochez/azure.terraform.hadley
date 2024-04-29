resource "azurerm_virtual_network" "main" {
  name                = var.main_virtual_network_name
  address_space       = var.main_virtual_network_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
}