locals {
  flattened_jobs = flatten([
    for schedule in var.automation_job_schedules : [
      for job_key, job in schedule.jobs : {
        VMName                    = job.VMName
        VMcommand                 = job.VMcommand
        disabled                  = lookup(job, "disabled", false) # ✅ optional default
        ResourceGroupName         = schedule.common_params.ResourceGroupName
        AzureSubscriptionID       = schedule.common_params.AzureSubscriptionID
        Action                    = schedule.common_params.Action
        automation_account_name   = schedule.common_params.automation_account_name
        resource_group_name       = schedule.common_params.resource_group_name
        runbook_name              = schedule.common_params.runbook_name
        schedule_name             = schedule.schedule_params.schedule_name
        frequency                 = schedule.schedule_params.frequency
        interval                  = schedule.schedule_params.interval
        timezone                  = schedule.schedule_params.timezone
        start_time                = schedule.schedule_params.start_time
        description               = schedule.schedule_params.description
        
      }
    ]
  ])
}


resource "azurerm_automation_job_schedule" "hadley_resource" {
  for_each = {
    for idx, job in local.flattened_jobs :
    "${job.VMName}" => job
    if !job.disabled                      # ✅ skip if disabled = true
  }

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


resource "azurerm_automation_schedule" "hadley_resource" {
  for_each = { for idx, job in local.flattened_jobs : "${job.job_name}" => job }
  name                      = "${each.value.schedule_name}_${each.value.VMName}"
  resource_group_name       = each.value.resource_group_name
  automation_account_name   = each.value.automation_account_name
  frequency                 = each.value.frequency
  interval                  = each.value.interval
  timezone                  = each.value.timezone
  start_time                = each.value.start_time
  description               = each.value.description

}
