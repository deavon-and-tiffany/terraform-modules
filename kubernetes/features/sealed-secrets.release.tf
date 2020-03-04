resource "helm_release" "sealed-secrets" {
  namespace       = "security-system"
  name            = "sealed-secrets"
  chart           = "sealed-secrets"
  version         = local.sealed_secrets.version
  repository      = data.helm_repository.stable.metadata[0].name
  force_update    = local.sealed_secrets.force_update
  recreate_pods   = true
  atomic          = true
  cleanup_on_fail = true
  max_history     = 3
  values          = local.sealed_secrets.values
}
