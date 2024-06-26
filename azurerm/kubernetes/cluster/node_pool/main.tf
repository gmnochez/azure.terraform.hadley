resource "azurerm_kubernetes_cluster_node_pool" "hadley_resource" {
  for_each = var.user_node_pools

  name                  = each.value.name
  kubernetes_cluster_id = each.value.kubernetes_cluster_id
  enable_auto_scaling   = each.value.enable_auto_scaling
  node_count            = each.value.node_count
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  vm_size               = each.value.vm_size
  os_disk_type          = each.value.os_disk_type
  os_disk_size_gb       = each.value.os_disk_size_gb
  os_sku                = each.value.os_sku
  orchestrator_version  = each.value.orchestrator_version
  vnet_subnet_id        = each.value.vnet_subnet_id
  zones                 = each.value.availability_zones

  tags = {
    for tag in var.tags:
    tag.key => tag.value
  }

}