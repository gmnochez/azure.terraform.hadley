
output "hadley_resource_dev_test_global_vm_shutdown_schedule_id" {
  
  value = {for k, v in azurerm_dev_test_global_vm_shutdown_schedule.hadley_resource: k => v.id}
}
