resource "aws_organizations_account" "account" {
  name                       = "${var.name}.${var.domain}"
  email                      = local.email
  role_name                  = "root-admin"
  parent_id                  = var.parent_id
  iam_user_access_to_billing = local.allow_billing
  tags                       = local.tags
}

module "recommended" {
  source      = "../recommended"
  assume_role = "arn:aws:iam::${aws_organizations_account.account.id}:role/root-admin"

  name   = var.name
  domain = var.domain

  org    = var.org
  owners = var.owners
  region = var.region
  tags   = var.tags
}
