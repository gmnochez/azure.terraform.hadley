
variable "shutdown_schedules" {
  description = "Shutdown Schedule"

  type = map(object({
    virtual_machine_id                        = string
  }))

  default = {}
  ephemeral = true
  
}



variable "location" {
  description = "Location"
}

variable "enabled" {
  description = "Enabled"
  type = bool
}

variable "daily_recurrence_time" {
  description = "Daily Recurrence Time"
}

variable "timezone" {
  description = "timezone"
}


variable "notification_settings_enabled" {
  description = "Notification Settings Enabled"
  type = bool
}

variable "notification_settings_time_in_minutes" {
  description = "Notification Settings Time In Minutes"
}

variable "notification_settings_webhook_url" {
  description = "Notification Settings Enabled Webhook Url"
}

variable "notification_settings_email" {
  description = "Notification Settings Enabled Email"
}



