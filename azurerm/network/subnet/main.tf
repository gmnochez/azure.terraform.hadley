resource "azurerm_subnet" "hadley_resource" {
  name                 = var.subnet_name
  resource_group_name  = var.subnet_resource_group_name
  virtual_network_name = var.subnet_virtual_network_name
  address_prefixes     = var.subnet_address_prefixes
  service_endpoints    = var.subnet_service_endpoints


}