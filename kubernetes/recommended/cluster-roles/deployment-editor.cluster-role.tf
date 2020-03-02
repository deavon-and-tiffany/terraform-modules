resource "kubernetes_cluster_role" "deployment-editor" {
  metadata {
    name = "global:deployment-editor"
  }

  rule {
    api_groups = [""]
    resources = [
      "pods",
      "services",
      "configmaps",
      "endpoints",
    ]
    verbs = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["apps", "extensions"]
    resources = [
      "deployments",
      "daemonsets",
      "statefulsets"
    ]
    verbs = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources = [
      "horizontalpodautoscalers"
    ]
    verbs = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["batch", "extensions"]
    resources = [
      "jobs",
      "cronjobs"
    ]
    verbs = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["networking.k8s.io", "extensions"]
    resources = [
      "ingresses"
    ]
    verbs = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["policy"]
    resources = [
      "poddistruptionbudgets"
    ]
    verbs = ["create", "patch", "update"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["create", "patch", "update"]
  }

  #   dynamic "rule" {
  #     for_each = kubernetes_cluster_role.deployment-viewer.rule
  #     content {
  #       api_groups = rule.api_groups
  #       resources  = rule.resources
  #       verbs      = rule.verbs
  #     }
  #   }
}
