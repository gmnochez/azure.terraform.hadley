
resource "azurerm_management_lock" "hadley_resource" {
  for_each = var.management_lock
  name       = each.value.name
  scope      = each.value.scope
  lock_level = each.value.lock_level
  notes      = each.value.notes
  
}