resource "helm_release" "prometheus" {
  namespace       = "monitoring-system"
  name            = "prometheus"
  chart           = "prometheus"
  version         = local.prometheus.version
  repository      = data.helm_repository.stable.metadata[0].name
  force_update    = local.prometheus.force_update
  recreate_pods   = true
  atomic          = true
  cleanup_on_fail = true
  max_history     = 3
  values          = local.prometheus.values
}
