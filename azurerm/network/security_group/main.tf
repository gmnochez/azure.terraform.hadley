resource "azurerm_network_security_group" "hadley_resource" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.security_rule
      content {
        name                       = security_rule.value.name
        priority                   = security_rule.value.priority
        direction                  = security_rule.value.direction
        access                     = security_rule.value.access
        protocol                   = security_rule.value.protocol
        # source_port_ranges         = split(",", replace(security_rule.value.source_port_ranges, "*", "0-65535"))
        # destination_port_ranges    = split(",", replace(security_rule.value.destination_port_ranges, "*", "0-65535"))
        source_port_ranges         = security_rule.value.source_port_ranges
        destination_port_ranges    = security_rule.value.destination_port_ranges        
        source_address_prefix      = security_rule.value.source_address_prefix
        destination_address_prefix = security_rule.value.destination_address_prefix
        description                = security_rule.value.description
      }  
  }
 
  
 
  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }
}