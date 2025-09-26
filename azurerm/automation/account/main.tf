
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

data "azurerm_subscription" "current" {}

resource "azurerm_role_assignment" "hadley_resource" {
  for_each = azurerm_automation_account.hadley_resource
  principal_id         = each.value.identity[0].principal_id
  role_definition_name = "Virtual Machine Contributor"
  scope                = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${each.value.resource_group_name}"
}


