provider "azurerm" {
  alias           = var.provider_alias
  subscription_id = var.provider_subscription_id
  features {}
}

resource "azurerm_private_dns_a_record" "hadley_resource" {
  provider            = "azurerm.${var.provider_alias}"
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