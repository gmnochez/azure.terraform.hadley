
variable "automation_job_schedules" {
  description = "List of automation job schedules with common parameters"
  type = list(object({
    schedule_params = object({
      schedule_name                   = string
      frequency                       = string
      interval                        = number
      timezone                        = string
      start_time                      = string
      description                     = string
    })

    common_params = object({
      automation_account_name   = string
      resource_group_name       = string
      runbook_name              = string
      schedule_name             = string
      ResourceGroupName         = string
      AzureSubscriptionID       = string
      Action                    = string
    })
    jobs = map(object({
      VMName    = string
      VMcommand = string
    }))
  }))
}




