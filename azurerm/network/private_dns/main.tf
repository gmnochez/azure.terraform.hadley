resource "azurerm_private_dns_a_record" "hadley_resource" {
  provider            = azurerm.dns
  name                = var.name
  zone_name           = var.zone_name
  resource_group_name = var.resource_group_name
  ttl                 = var.ttl
  records             = var.records

 
  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }
}