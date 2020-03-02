resource "helm_release" "cert-manager" {
  namespace       = local.cert_manager.namespace
  name            = "cert-manager"
  chart           = "cert-manager"
  version         = local.cert_manager.version
  repository      = data.helm_repository.jetstack.metadata[0].name
  force_update    = local.cert_manager.force_update
  recreate_pods   = true
  atomic          = true
  cleanup_on_fail = true
  max_history     = 3
  values          = local.cert_manager.values
}
