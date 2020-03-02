resource "kubernetes_namespace" "monitoring" {
  metadata {
    name = "monitoring-system"

    labels = {
      "system/secure" = "true"
    }
  }
}
