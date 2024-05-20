
resource "azurerm_management_lock" "vm_lock" {
  name       = var.name
  scope      = var.scope
  lock_level = var.lock_level
  notes      = var.notes
  
}