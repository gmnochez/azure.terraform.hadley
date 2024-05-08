resource "azurerm_virtual_network" "hadley_resource" {
  name                = var.main_virtual_network_name
  address_space       = var.main_virtual_network_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  ddos_protection_plan {
      enable = var.ddos_protection_plan_enable
      id     = var.ddos_protection_plan_id 
  }

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}