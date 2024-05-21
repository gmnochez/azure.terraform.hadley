output "hadley_resource_role_assignment_name" {
  value = {for k, v in azurerm_role_assignment.hadley_resource: k => v.name}
}

output "hadley_resource_role_assignment_id" {
  value = {for k, v in azurerm_role_assignment.hadley_resource: k => v.id}
}



