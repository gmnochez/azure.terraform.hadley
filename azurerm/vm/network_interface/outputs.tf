output "hadley_resource_network_interface_name" {
  value = azurerm_network_interface.hadley_resource.name
}

output "hadley_resource_network_interface_id" {
  value = azurerm_network_interface.hadley_resource.id
}


output "network_interface_id" {
  value = data.azurerm_network_interface.interface.id
}