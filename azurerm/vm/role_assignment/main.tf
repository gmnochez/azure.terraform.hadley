resource "azurerm_role_assignment" "hadley_resource" {
  for_each = var.role_assignment
  scope                 = each.value.scope
  role_definition_name  = each.value.role_assignment_name
  principal_id          = each.value.role_assignment_id
}


