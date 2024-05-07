resource "azurerm_subnet" "hadley_resource" {
  name                 = var.app_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hadley_resource.name
  address_prefixes     = var.app_subnet_address_prefixes

  service_endpoints = ["Microsoft.Sql", "Microsoft.Storage", "Microsoft.KeyVault"]
}