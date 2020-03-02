resource "kubernetes_cluster_role" "secrets-admin" {
  metadata {
    name = "global:secrets-admin"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["delete", "deletecollection"]
  }

  #   dynamic "rule" {
  #     for_each = kubernetes_cluster_role.secrets-editor.rule
  #     content {
  #       api_groups = rule.api_groups
  #       resources  = rule.resources
  #       verbs      = rule.verbs
  #     }
  #   }
}
