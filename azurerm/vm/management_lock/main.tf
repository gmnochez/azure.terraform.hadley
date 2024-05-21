
resource "azurerm_management_lock" "hadley_resource" {
  name       = var.name
  scope      = var.scope
  lock_level = var.lock_level
  notes      = var.notes
  
}