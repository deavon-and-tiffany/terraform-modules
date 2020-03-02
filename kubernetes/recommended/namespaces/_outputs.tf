output "gitops" {
  value = {
    name = kubernetes_namespace.gitops.metadata[0].name
  }
}

output "mesh" {
  value = {
    name = kubernetes_namespace.mesh.metadata[0].name
  }
}

output "monitoring" {
  value = {
    name = kubernetes_namespace.monitoring.metadata[0].name
  }
}

output "security" {
  value = {
    name = kubernetes_namespace.security.metadata[0].name
  }
}
