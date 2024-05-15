


data "azurerm_kubernetes_cluster" "cluster" {
  name                = var.name
  resource_group_name = var.resource_group_name
}



provider "helm" {
  kubernetes {
    host                   = data.azurerm_kubernetes_cluster.cluster.kube_config[0].host
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config[0].client_certificate)
    client_key             = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.cluster.kube_config[0].cluster_ca_certificate)
  
  }
}



resource "helm_release" "hadley_resource" {
  name       = var.helm_name
  repository = var.helm_repository
  chart      = var.helm_chart

  values = [
    file(var.helm_file)
  ]
}


# data "kubernetes_service" helm_name {
#   depends_on = [helm_release.hadley_resource]
#   metadata {
#     name = var.helm_name
#   }
# }
