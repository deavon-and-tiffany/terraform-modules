resource "kubernetes_cluster_role" "secrets-editor" {
  metadata {
    name = "global:secrets-editor"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["create", "patch", "update"]
  }

  #   dynamic "rule" {
  #     for_each = kubernetes_cluster_role.secrets-viewer.rule
  #     content {
  #       api_groups = rule.api_groups
  #       resources  = rule.resources
  #       verbs      = rule.verbs
  #     }
  #   }
}
