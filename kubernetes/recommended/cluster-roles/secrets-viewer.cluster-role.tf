resource "kubernetes_cluster_role" "secrets-viewer" {
  metadata {
    name = "global:secrets-viewer"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "watch"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["get", "watch"]
  }

  #   dynamic "rule" {
  #     for_each = kubernetes_cluster_role.secrets-lister.rule
  #     content {
  #       api_groups = rule.api_groups
  #       resources  = rule.resources
  #       verbs      = rule.verbs
  #     }
  #   }
}
