resource "azurerm_role_assignment" "hadley_resource" {
  for_each = toset(var.role_assignment_id)
  scope                 = var.scope
  role_definition_name  = var.role_assignment_name
  principal_id          = each.key
}


