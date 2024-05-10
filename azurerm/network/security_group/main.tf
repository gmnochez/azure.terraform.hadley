resource "azurerm_network_security_group" "hadley_resource" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

 
  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }
}