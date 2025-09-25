resource "azurerm_automation_runbook" "hadley_resource" {
  for_each = var.automation_runbooks
  name                    = each.var.name
  location                = each.var.location
  resource_group_name     = each.var.resource_group_name
  automation_account_name = each.var.automation_account_name
  log_progress            = each.var.log_progress
  log_verbose             = each.var.log_verbose
  runbook_type            = each.var.runbook_type
  content                 = file("azure_vm_command.ps1")
  description             = each.var.description
}




