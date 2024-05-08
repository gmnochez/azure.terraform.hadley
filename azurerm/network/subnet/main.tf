resource "azurerm_subnet" "hadley_resource" {
  name                 = var.app_subnet_name
  resource_group_name  = var.app_subnet_resource_group_name
  virtual_network_name = var.app_subnet_virtual_network_name
  address_prefixes     = var.app_subnet_address_prefixes
  service_endpoints    = var.app_subnet_service_endpoints
}