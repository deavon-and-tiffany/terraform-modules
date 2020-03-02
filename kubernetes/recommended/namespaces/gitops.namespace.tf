resource "kubernetes_namespace" "gitops" {
  metadata {
    name = "gitops-system"

    labels = {
      "system/secure" = "true"
    }
  }
}
