locals {
  flattened_jobs = flatten([
    for schedule in var.automation_job_schedules : [
      for job_key, job in schedule.jobs : {
        VMName                    = job.VMName
        VMcommand                 = job.VMcommand
        ResourceGroupName         = schedule.common_params.ResourceGroupName
        AzureSubscriptionID       = schedule.common_params.AzureSubscriptionID
        Action                    = schedule.common_params.Action
        automation_account_name   = schedule.common_params.automation_account_name
        resource_group_name       = schedule.common_params.resource_group_name
        runbook_name              = schedule.common_params.runbook_name
        schedule_name             = schedule.common_params.schedule_name
        
      }
    ]
  ])
}


resource "azurerm_automation_job_schedule" "jobs" {
  for_each = { for idx, job in local.flattened_jobs : "${job.job_name}" => job }

  automation_account_name = each.value.automation_account_name
  resource_group_name     = each.value.resource_group_name
  runbook_name            = each.value.runbook_name
  schedule_name           = "${each.value.schedule_name}_${each.value.VMName}"

  parameters = {
    VMName              = each.value.VMName
    VMcommand           = each.value.VMcommand
    ResourceGroupName   = each.value.ResourceGroupName
    AzureSubscriptionID = each.value.AzureSubscriptionID
    Action              = each.value.Action
  }
}

