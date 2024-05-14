
data "azurerm_kubernetes_cluster" "credentials" {
  name                = var.name
  resource_group_name = var.resource_group_name
}

provider "helm" {
  kubernetes {
    # host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
    # client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
    # client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
    # cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
  
    host                   = data.azurerm_kubernetes_cluster.credentials.endpoint
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["aks", "get-token", "--cluster-name", azurerm_kubernetes_cluster.credentials.name]
      command     = "az"
  
    }
  }
}

terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.8.0"
    }
  }
}

