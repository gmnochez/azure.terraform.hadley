output "hadley_resource_management_lock_name" {
  value = {for k, v in azurerm_management_lock.hadley_resource: k => v.name}
}

output "hadley_resource_management_lock_id" {
  value = {for k, v in azurerm_management_lock.hadley_resource: k => v.id}
}



