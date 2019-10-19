output "id" {
  value = aws_organizations_account.account.id
}

output "account" {
  value = aws_organizations_account.account
}

output "logging" {
  value = module.recommended.logging
}

output "roles" {
  value = module.recommended.roles
}

output "state" {
  value = module.recommended.state
}

output "name" {
  value = var.name
}

output "org" {
  value = var.org
}

output "owners" {
  value = var.owners
}

output "tags" {
  value = var.tags
}

output "region" {
  value = var.region
}
