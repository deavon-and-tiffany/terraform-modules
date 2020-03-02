module "priority-classes" {
  source = "./priority-classes"
}

module "namespaces" {
  source = "./namespaces"
}

module "cluster-roles" {
  source = "./cluster-roles"
}

module "features" {
  source = "../features"

  prometheus     = var.prometheus
  grafana        = var.grafana
  cert_manager   = var.cert_manager
  sealed_secrets = var.sealed_secrets
  flux           = var.flux
}
