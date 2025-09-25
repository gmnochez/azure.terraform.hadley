resource "azurerm_automation_runbook" "hadley_resource" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  automation_account_name = var.automation_account_name
  log_progress            = var.log_progress
  log_verbose             = var.log_verbose
  runbook_type            = var.runbook_type
  content                 = file("azure_vm_command.ps1")
  description             = var.description
}




