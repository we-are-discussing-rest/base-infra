resource "helm_release" "argocd" {
  chart            = var.chart
  create_namespace = var.create_namespace
  name             = var.release_name
  namespace        = var.namespace
  repository       = var.repository
  version          = var.chart_version

  values = [
    yamlencode(var.values_map)
  ]
}