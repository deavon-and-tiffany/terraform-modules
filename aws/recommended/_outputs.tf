output "logging" {
  value = {
    bucket = module.logging.bucket
  }
}

output "roles" {
  value = module.ops.roles
}

output "state" {
  value = {
    kms_key = module.state.kms_key
    bucket  = module.state.bucket
    table   = module.state.table
  }
}
