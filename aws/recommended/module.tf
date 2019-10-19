provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

module "ops" {
  source      = "../ops"
  assume_role = var.assume_role
  region      = var.region

  org    = var.org
  owners = var.owners
  tags   = var.tags
}

module "logging" {
  source      = "../logging"
  assume_role = var.assume_role
  region      = var.region

  name   = var.name
  domain = var.domain

  org    = var.org
  owners = var.owners
  tags   = var.tags
}

module "state" {
  source          = "../state"
  assume_role     = var.assume_role
  state_role_name = module.ops.roles.agent.id
  region          = var.region

  name       = var.name
  domain     = var.domain
  log_bucket = module.logging.bucket

  org    = var.org
  owners = var.owners
  tags   = var.tags
}
