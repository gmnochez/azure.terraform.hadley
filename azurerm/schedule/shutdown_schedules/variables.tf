
variable "shutdown_schedules" {
  description = "Role Assignment"

  type = map(object({
    virtual_machine_id                        = string
  }))

  default = {}

}



variable "location" {
  description = "Location"
}

variable "enabled" {
  description = "Enabled"
}

variable "daily_recurrence_time" {
  description = "Enabled"
}

variable "timezone" {
  description = "Enabled"
}


variable "notification_settings_enabled" {
  description = "Notification Settings Enabled"
}

variable "notification_settings_time_in_minutes" {
  description = "Notification Settings Time In Minutes"
}

variable "notification_settings_enabled_webhook_url" {
  description = "Notification Settings Enabled Webhook Url"
}

variable "notification_settings_enabled_email" {
  description = "Notification Settings Enabled Email"
}



