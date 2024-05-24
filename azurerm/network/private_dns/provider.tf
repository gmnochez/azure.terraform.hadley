provider "azurerm" {
  alias           = var.provider_alias
  subscription_id = var.provider_subscription_id
  features {}
}