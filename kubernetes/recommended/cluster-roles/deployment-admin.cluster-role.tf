resource "kubernetes_cluster_role" "deployment-admin" {
  metadata {
    name = "global:deployment-admin"
  }

  rule {
    api_groups = [""]
    resources = [
      "pods",
      "services",
      "configmaps",
      "endpoints",
      "secrets"
    ]
    verbs = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["apps", "extensions"]
    resources = [
      "deployments",
      "daemonsets",
      "statefulsets"
    ]
    verbs = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources = [
      "horizontalpodautoscalers"
    ]
    verbs = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["batch", "extensions"]
    resources = [
      "jobs",
      "cronjobs"
    ]
    verbs = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["networking.k8s.io", "extensions"]
    resources = [
      "ingresses"
    ]
    verbs = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["policy"]
    resources = [
      "poddistruptionbudgets"
    ]
    verbs = ["delete", "deletecollection"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["delete", "deletecollection"]
  }

  #   dynamic "rule" {
  #     for_each = kubernetes_cluster_role.deployment-editor.rule
  #     content {
  #       api_groups = rule.api_groups
  #       resources  = rule.resources
  #       verbs      = rule.verbs
  #     }
  #   }
}
