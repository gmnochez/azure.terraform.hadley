provider "azurerm" {
  alias           = "dns"
  subscription_id = var.provider_subscription_id
  skip_provider_registration = true
  features {}
}

resource "azurerm_private_dns_a_record" "hadley_resource" {
  for_each = var.private_dns
  provider            = azurerm.dns
  name                = each.value.name
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = each.value.ttl
  records             = each.value.records

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }
}