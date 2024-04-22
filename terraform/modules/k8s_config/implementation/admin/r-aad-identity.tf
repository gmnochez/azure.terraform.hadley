resource "azurerm_user_assigned_identity" "aad_pod_identity" {
  location            = var.location
  name                = var.aadpodidentity_custom_name
  resource_group_name = var.aks_resource_group_name

  tags = var.aadpodidentity_extra_tags
}

resource "azurerm_role_assignment" "aad_pod_identity_msi" {
  scope                = format("/subscriptions/%s/resourceGroups/%s", data.azurerm_subscription.current.subscription_id, var.aks_resource_group_name)
  principal_id         = azurerm_user_assigned_identity.aad_pod_identity.principal_id
  role_definition_name = "Managed Identity Operator"
}
