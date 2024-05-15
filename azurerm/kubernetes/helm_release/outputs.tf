output "hadley_helm_release_name" {
  value = helm_release.hadley_resource.name
}

output "nginx_endpoint" {
    value = "http://${data.kubernetes_service.hadley_resource.status.0.load_balancer.0.ingress.0.hostname}"
}