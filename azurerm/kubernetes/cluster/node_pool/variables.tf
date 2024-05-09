

variable "user_node_pools" {
  description = "App AKS cluster user node pools config"

  type = map(object({
    name                  = string
    kubernetes_cluster_id = string
    enable_auto_scaling   = bool    
    node_count            = number
    min_count             = number
    max_count             = number
    os_disk_type          = string
    os_disk_size_gb       = number
    vm_size               = string
    orchestrator_version  = string
    os_sku                = string
    vnet_subnet_id        = string
    availability_zones    = list(number)
  }))
}


variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}

