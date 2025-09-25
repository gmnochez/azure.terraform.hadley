
resource "azurerm_automation_account" "hadley_resource" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name
}


