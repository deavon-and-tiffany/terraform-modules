resource "kubernetes_cluster_role" "secrets-lister" {
  metadata {
    name = "global:secrets-lister"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["list"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["list"]
  }
}
