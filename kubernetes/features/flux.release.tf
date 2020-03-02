resource "helm_release" "flux" {
  namespace       = "gitops-system"
  name            = "flux"
  chart           = "flux"
  version         = local.flux.version
  repository      = data.helm_repository.fluxcd.metadata[0].name
  force_update    = local.flux.force_update
  recreate_pods   = true
  atomic          = true
  cleanup_on_fail = true
  max_history     = 3
  values          = local.flux.values
}
