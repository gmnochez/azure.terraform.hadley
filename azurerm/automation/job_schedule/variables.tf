
variable "automation_job_schedules" {
  description = "List of automation job schedules with common parameters"
  type = list(object({
    schedule_params = object({
      schedule_name                   = string
      frequency                       = string
      week_days                       = list(string)
      interval                        = number
      timezone                        = string
      start_time                      = string
      description                     = string
    })

    common_params = object({
      automation_account_name   = string
      resource_group_name       = string
      runbook_name              = string
      rgn_vm                    = string
      azure_subscription_id     = string
      action_script             = string
    })
    jobs = map(object({
      vm_name    = string
      vm_command = string
      disabled   = bool
    }))
  }))
}




