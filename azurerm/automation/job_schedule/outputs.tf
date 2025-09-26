
output "hadley_resource_automation_job_schedule_id" {
  
  value = {for k, v in azurerm_automation_job_schedule.hadley_resource: k => v.id}
}

output "hadley_resource_automation_schedule_id" {
  
  value = {for k, v in azurerm_automation_schedule.hadley_resource: k => v.id}
}
