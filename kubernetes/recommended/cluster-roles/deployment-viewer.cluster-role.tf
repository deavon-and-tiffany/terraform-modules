resource "kubernetes_cluster_role" "deployment-viewer" {
  metadata {
    name = "global:deployment-viewer"
  }

  rule {
    api_groups = [""]
    resources = [
      "pods",
      "services",
      "configmaps",
      "endpoints",
      "limitranges",
      "nodes",
      "namespaces",
      "persistentvolumes",
      "persistentvolumeclaims",
      "resourcequotas"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = [""]
    resources = [
      "secret",
      "serviceaccounts"
    ]
    verbs = ["list", "watch"]
  }

  rule {
    api_groups = ["apps", "extensions"]
    resources = [
      "deployments",
      "daemonsets",
      "statefulsets",
      "relicasets"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["autoscaling"]
    resources = [
      "horizontalpodautoscalers"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["batch", "extensions"]
    resources = [
      "jobs",
      "cronjobs"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["networking.k8s.io", "extensions"]
    resources = [
      "ingresses",
      "networkpolicies"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["policy"]
    resources = [
      "poddistruptionbudgets"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["rbac.authorization.k8s.io"]
    resources = [
      "clusterroles",
      "clusterrolebindings",
      "roles",
      "rolebindings"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["scheduling.k8s.io"]
    resources = [
      "priorityclasses"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["storage.k8s.io"]
    resources = [
      "storageclasses"
    ]
    verbs = ["get", "list", "watch"]
  }

  rule {
    api_groups = ["bitnami.com"]
    resources  = ["sealedsecrets"]
    verbs      = ["get", "list", "watch"]
  }
}
