resource "azurerm_dev_test_global_vm_shutdown_schedule" "hadley_resource" {

  virtual_machine_id      = var.virtual_machine_id
  location                = var.location
  enabled                 = var.enabled
  daily_recurrence_time   = var.daily_recurrence_time
  timezone                = var.timezone



  notification_settings  {
    enabled               = var.notification_settings_enabled
    time_in_minutes       = var.notification_settings_time_in_minutes
    webhook_url           = var.notification_settings_enabled_webhook_url
    email                 = var.notification_settings_enabled_email
  }



}
