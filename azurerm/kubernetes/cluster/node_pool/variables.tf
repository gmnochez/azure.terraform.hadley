


variable "kubernetes_cluster_id" {
  description = "Kubernetes Cluster Id"
}


variable "enable_auto_scaling" {
  description = "AutoScaling switch"
  type = bool
}

variable "availability_zones" {
  description = "Availability Zones"
  type = list(number)
  default = []
}



variable "default_node_pool" {
  description = "App AKS cluster system node pool config"

  type = object({
    node_count           = number
    min_count            = number
    max_count            = number
    os_disk_type         = string
    os_disk_size_gb      = number
    vm_size              = string
    orchestrator_version = string
    os_sku               = string
  })
}

variable "user_node_pools" {
  description = "App AKS cluster user node pools config"

  type = map(object({
    name                 = string
    node_count           = number
    min_count            = number
    max_count            = number
    os_disk_type         = string
    os_disk_size_gb      = number
    vm_size              = string
    orchestrator_version = string
    os_sku               = string
  }))
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}

