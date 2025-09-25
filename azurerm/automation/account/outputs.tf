
output "hadley_resource_automation_account_id" {
  
  value = {for k, v in azurerm_automation_account.hadley_resource: k => v.id}
}


