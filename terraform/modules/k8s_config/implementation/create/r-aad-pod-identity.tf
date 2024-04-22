data "azurerm_subscription" "current" {}

resource "kubernetes_namespace" "add_pod_identity" {
  metadata {
    name = var.aadpodidentity_namespace
    labels = {
      deployed-by = "Terraform"
    }
  }
}

resource "helm_release" "aad_pod_identity" {
  name       = "aad-pod-identity"
  repository = var.aadpodidentity_chart_repository
  chart      = "aad-pod-identity"
  version    = var.aadpodidentity_chart_version
  namespace  = kubernetes_namespace.add_pod_identity.metadata[0].name

  dynamic "set" {
    for_each = local.aadpodidentity_values
    iterator = setting
    content {
      name  = setting.key
      value = setting.value
    }
  }

  # If `Aadpodidentity` is used within an Aks Cluster with Kubenet network Plugin,
  # `nmi.allowNetworkPluginKubenet` parameter is set to `true`.
  # https://github.com/Azure/aad-pod-identity/issues/949
  set {
    name  = "nmi.allowNetworkPluginKubenet"
    value = var.aks_network_plugin == "kubenet" ? "true" : "false"
  }
}

