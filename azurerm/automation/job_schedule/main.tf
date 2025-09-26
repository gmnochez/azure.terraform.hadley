locals {
  flattened_jobs = flatten([
    for schedule in var.automation_job_schedules : [
      for job_key, job in schedule.jobs : {
        vm_name                    = job.vm_name
        vm_command                 = job.vm_name
        disabled                  = lookup(job, "disabled", false) # ✅ optional default
        rgn_vm                    = schedule.common_params.rgn_vm
        azure_subscription_id      = schedule.common_params.azure_subscription_id
        action                    = schedule.common_params.action
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
    "${job.vm_name}" => job
    if !job.disabled                      # ✅ skip if disabled = true
  }

  automation_account_name = each.value.automation_account_name
  resource_group_name     = each.value.resource_group_name
  runbook_name            = each.value.runbook_name
  schedule_name           = "${each.value.schedule_name}_${each.value.vm_name}"

  parameters = {
    vm_name               = each.value.vm_name
    vm_command            = each.value.vm_command
    rgn_vm                = each.value.rgn_vm
    azure_subscription_id = each.value.azure_subscription_id
    action                = each.value.action
  }
}


resource "azurerm_automation_schedule" "hadley_resource" {
  for_each = { for idx, job in local.flattened_jobs : "${job.vm_name}" => job }
  name                      = "${each.value.schedule_name}_${each.value.vm_name}"
  resource_group_name       = each.value.resource_group_name
  automation_account_name   = each.value.automation_account_name
  frequency                 = each.value.frequency
  interval                  = each.value.interval
  timezone                  = each.value.timezone
  start_time                = each.value.start_time
  description               = each.value.description

}
