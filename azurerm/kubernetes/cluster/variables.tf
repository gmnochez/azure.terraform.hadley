variable "location" {
  description = "Location"
}

variable "resource_group_name" {
  description = "Resource group name"
}

variable "name" {
  description = "App AKS cluster name"
}

variable "dns_prefix" {
  description = "App AKS DNS prefix"
}

variable "client_id" {
  description = "Azure service principal ID"
}

variable "client_secret" {
  description = "Azure service pricipal password"
  sensitive   = true
}

variable "ssh_key" {
  description = "App AKS cluster SSH key"
  sensitive   = true
}

variable "service_cidr" {
  description = "Service CIDR"
  default     = "10.0.0.0/16"
}

variable "dns_service_ip" {
  description = "DNS service IP"
  default     = "10.0.0.10"
}

variable "docker_bridge_cidr" {
  description = "Docker bridge CIDR"
  default     = "172.17.0.1/16"
}

variable "sku_tier" {
  description = "App AKS cluster SKU tier"
}

variable "kubernetes_version" {
  description = "App AKS cluster Kubernetes version"
}


variable "default_node_pool" {
  description = "App AKS cluster system node pool config"

  type = object({
    name                 = string
    type                 = string
    enable_auto_scaling  = bool
    node_count           = number
    min_count            = number
    max_count            = number
    os_disk_type         = string
    os_disk_size_gb      = number
    vm_size              = string
    orchestrator_version = string
    os_sku               = string
    vnet_subnet_id       = string
    availability_zones   = list(number)
  })
}




variable "tags" {
  description = "Lista de Tags"
  type = list(any)
  default = []
}