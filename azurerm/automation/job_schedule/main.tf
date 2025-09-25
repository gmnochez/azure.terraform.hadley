
resource "azurerm_automation_job_schedule" "hadley_resource" {
  for_each = var.automation_job_schedules
  parameters = {
    job_name                = each.value.job_name
    vm_name                 = each.value.vm_name
    vm_command              = each.value.vm_command
    rgn_job                 = each.value.rgn_job
    azure_subscription_id   = each.value.azure_subscription_id
    action                  = each.value.action
  }


  
  automation_account_name = var.automation_account_name
  resource_group_name     = var.resource_group_name
  runbook_name            = var.runbook_name
  schedule_name           = var.schedule_name
  
}


