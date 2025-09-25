
variable "automation_runbooks" {
  description = "automation runbooks"

  type = map(object({
    name                      = string
    location                  = string
    resource_group_name       = string
    automation_account_name   = string
    log_progress              = bool
    log_verbose               = bool
    runbook_type              = string
    description               = string
  }))

  default = {}
 
}
