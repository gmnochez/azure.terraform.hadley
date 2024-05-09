resource "azurerm_kubernetes_cluster" "hadley_resource" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name                 = "system"
    type                 = "VirtualMachineScaleSets"
    enable_auto_scaling  = true
    node_count           = var.default_node_pool.node_count
    min_count            = var.default_node_pool.min_count
    max_count            = var.default_node_pool.max_count
    vm_size              = var.default_node_pool.vm_size
    os_disk_type         = var.default_node_pool.os_disk_type
    os_disk_size_gb      = var.default_node_pool.os_disk_size_gb
    os_sku               = var.default_node_pool.os_sku
    orchestrator_version = var.default_node_pool.orchestrator_version
    vnet_subnet_id       = var.subnet_id
    availability_zones   = var.availability_zones

  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  role_based_access_control {
    enabled = true
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_key
    }
  }

  network_profile {
    network_plugin     = "azure"
    network_policy     = "azure"
    load_balancer_sku  = "Standard"
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip
    docker_bridge_cidr = var.docker_bridge_cidr
  }

  sku_tier = var.sku_tier

  kubernetes_version = var.kubernetes_version

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }
}