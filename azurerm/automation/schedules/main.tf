resource "azurerm_automation_schedule" "hadley_resource" {
  for_each                  = var.automation_schedules
  name                      = each.value.name
  resource_group_name       = each.value.resource_group_name
  automation_account_name   = each.value.automation_account_name
  frequency                 = each.value.frequency
  interval                  = each.value.interval
  timezone                  = each.value.timezone
  start_time                = each.value.start_time
  description               = each.value.description

}
