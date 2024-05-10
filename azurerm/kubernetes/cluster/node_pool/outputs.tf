output "hadley_resource_azurerm_kubernetes_cluster_node_pool_id" {
  value = {for k, v in azurerm_kubernetes_cluster_node_pool.hadley_resource: k => v.id}
}
