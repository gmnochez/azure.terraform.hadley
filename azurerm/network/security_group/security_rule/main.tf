resource "azurerm_network_security_rule" "hadley_resource"  {
  for_each = var.security_rule
    resource_group_name         = var.resource_group_name
    network_security_group_name = var.network_security_group_name
    name                        = each.value.name
    priority                    = each.value.priority
    direction                   = each.value.direction
    access                      = each.value.access
    protocol                    = each.value.protocol
    source_port_ranges          = split(",", replace(each.value.source_port_ranges, "*", "0-65535"))
    destination_port_ranges     = split(",", replace(each.value.destination_port_ranges, "*", "0-65535"))    
    source_address_prefix       = each.value.source_address_prefix
    destination_address_prefix  = each.value.destination_address_prefix
    description                 = each.value.description
   
 
  
 

}