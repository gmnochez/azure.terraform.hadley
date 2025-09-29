locals {
  flattened_jobs = flatten([
    for schedule in var.automation_job_schedules : [
      for job_key, job in schedule.jobs : {
        vm_name                   = job.vm_name
        full_schedule_name        = "${schedule.schedule_params.schedule_name}_${job.vm_name}"
        vm_command                = job.vm_command
        disabled                  = job.disabled
        rgn_vm                    = schedule.common_params.rgn_vm
        azure_subscription_id     = schedule.common_params.azure_subscription_id
        action_script             = schedule.common_params.action_script
        automation_account_name   = schedule.common_params.automation_account_name
        resource_group_name       = schedule.common_params.resource_group_name
        runbook_name              = schedule.common_params.runbook_name
        schedule_name             = schedule.schedule_params.schedule_name
        frequency                 = schedule.schedule_params.frequency
        week_days                 = schedule.schedule_params.week_days
        interval                  = schedule.schedule_params.interval
        timezone                  = schedule.schedule_params.timezone
        start_time                = schedule.schedule_params.start_time
        description               = schedule.schedule_params.description
        
      }
    ]
  ])
}

resource "azurerm_automation_schedule" "hadley_resource" {
  for_each = {
    for idx, job in local.flattened_jobs :
    "${job.full_schedule_name}" => job
    if !job.disabled                      # ✅ skip if disabled = true
  }



  name                      = "${each.value.schedule_name}_${each.value.vm_name}"
  resource_group_name       = each.value.resource_group_name
  automation_account_name   = each.value.automation_account_name
  frequency                 = each.value.frequency
  week_days                 = each.value.week_days
  interval                  = each.value.interval
  timezone                  = each.value.timezone
  start_time                = each.value.start_time
  description               = each.value.description

}


resource "azurerm_automation_job_schedule" "hadley_resource" {
  for_each = {
    for idx, job in local.flattened_jobs :
    "${job.full_schedule_name}" => job
    if !job.disabled                      # ✅ skip if disabled = true
  }


  automation_account_name = each.value.automation_account_name
  resource_group_name     = each.value.resource_group_name
  runbook_name            = each.value.runbook_name
  schedule_name           = each.value.full_schedule_name

  parameters = {
    vm_name               = each.value.vm_name
    vm_command            = each.value.vm_command
    rgn_vm                = each.value.rgn_vm
    azure_subscription_id = each.value.azure_subscription_id
    action_script         = each.value.action_script
  }

  depends_on = [azurerm_automation_schedule.hadley_resource]
}



