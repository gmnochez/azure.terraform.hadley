provider "azurerm" {
  alias           = "dns"
  subscription_id = var.provider_subscription_id
  features {}
}