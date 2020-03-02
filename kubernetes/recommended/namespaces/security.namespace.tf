resource "kubernetes_namespace" "security" {
  metadata {
    name = "security-system"

    labels = {
      "system/secure"                         = "true"
      "certmanager.k8s.io/disable-validation" = "true"
    }
  }
}
