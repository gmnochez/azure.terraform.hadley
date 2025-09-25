resource "azurerm_automation_runbook" "hadley_resource" {
  for_each = var.automation_runbooks
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  automation_account_name = each.value.automation_account_name
  log_progress            = each.value.log_progress
  log_verbose             = each.value.log_verbose
  runbook_type            = each.value.runbook_type
  content                 = file("azure_vm_command.ps1")
  description             = each.value.description
}




