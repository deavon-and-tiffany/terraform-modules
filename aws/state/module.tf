provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

resource "aws_kms_key" "terraform-state" {
  description = "This key is used to encrypt terraform state within the account."
  tags        = local.tags
}
