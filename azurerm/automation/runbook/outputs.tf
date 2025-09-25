
output "hadley_resource_automation_runbook_id" {  
  value = {for k, v in azurerm_automation_runbook.hadley_resource: k => v.id}
}