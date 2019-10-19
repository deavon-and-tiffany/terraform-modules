resource "kubernetes_namespace" "namespace" {
  metadata {
    name        = var.name
    labels      = var.labels
    annotations = var.annotations
  }
}
