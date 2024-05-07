output "hadley_resource_virtual_network_id" {
  value = azurerm_virtual_network.hadley_resource.id
}

output "hadley_resource_subnet_id" {
  value = azurerm_subnet.hadley_resource.id
}
