resource "kubernetes_namespace" "mesh" {
  metadata {
    name = "mesh-system"

    labels = {
      "system/secure" = "true"
    }
  }
}
