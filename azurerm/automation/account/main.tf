
resource "azurerm_automation_account" "hadley_resource" {
  for_each = var.automation_accounts
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku_name            = each.value.sku_name

  identity {
    type = "SystemAssigned"
  }

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }
}


