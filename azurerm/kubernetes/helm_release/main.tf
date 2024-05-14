resource "helm_release" "hadley_resource" {
  name       = var.helm_name
  repository = var.helm_repository
  chart      = var.helm_chart

  values = [
    file(var.helm_file)
  ]
}
