
data "azurerm_kubernetes_cluster" "credentials" {
  name                = var.name
  resource_group_name = var.resource_group_name
}


cluster_storage_key          = "deployment/enviroment/daily/us/app/kubernetes/cluster.tfstate"
    cluster_resource_group_name  = "rg-shared-eus2"
    cluster_storage_account_name = "assdteus2016st001"
    cluster_subscription_id      = "61407a28-a2f5-4d0d-86da-6af06fb1ef92"


data "terraform_remote_state" "aks" {
  backend = "cluster"
  config = {
    subscription_id      = var.cluster_subscription_id
    resource_group_name  = var.cluster_resource_group_name
    storage_account_name = var.cluster_storage_account_name
    container_name       = "terraform-state"
    key                  = var.cluster_storage_key
  }
}

# Retrieve EKS cluster configuration
data "azure_aks_cluster" "cluster" {
  name = data.terraform_remote_state.aks.outputs.cluster_name
}






provider "helm" {
  kubernetes {
    # host                   = data.azurerm_kubernetes_cluster.credentials.kube_config.0.host
    # client_certificate     = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_certificate)
    # client_key             = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.client_key)
    # cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.credentials.kube_config.0.cluster_ca_certificate)
  
    host                   = data.terraform_remote_state.aks.endpoint
    cluster_ca_certificate = base64decode(data.terraform_remote_state.aks.certificate_authority.0.data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      args        = ["aks", "get-credentials", "--name", data.azure_aks_cluster.cluster.name, "-g", data.terraform_remote_state.aks.resource_group_name]
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










resource "helm_release" "hadley_resource" {
  name       = var.helm_name
  repository = var.helm_repository
  chart      = var.helm_chart

  values = [
    file(var.helm_file)
  ]
}
