resource "azurerm_subnet" "hadley_resource" {
  name                 = var.app_subnet_name
  address_prefixes     = var.app_subnet_address_prefixes
 
}