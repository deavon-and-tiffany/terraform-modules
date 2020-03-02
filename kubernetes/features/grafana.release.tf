resource "helm_release" "grafana" {
  namespace       = "monitoring-system"
  name            = "grafana"
  chart           = "grafana"
  version         = local.grafana.version
  repository      = data.helm_repository.stable.metadata[0].name
  force_update    = local.grafana.force_update
  recreate_pods   = true
  atomic          = true
  cleanup_on_fail = true
  max_history     = 3
  values          = local.grafana.values
}
