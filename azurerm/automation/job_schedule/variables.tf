
variable "automation_job_schedules" {
  description = "automation job schedules"

  type = map(object({
    job_name                = string
    vm_name                 = string
    vm_command              = string
    rgn_job                 = string
    azure_subscription_id   = string
    action                  = string

  }))

  default = {}
 
}



variable "automation_account_name" {
  description = "automation_account_name"
}

variable "resource_group_name" {
  description = "resource_group_name"
}

variable "runbook_name" {
  description = "runbook_name"
}

variable "schedule_name" {
  description = "schedule_name"
}


