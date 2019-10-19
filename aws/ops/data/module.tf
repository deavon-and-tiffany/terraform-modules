provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

data "aws_iam_role" "agent" {
  name = "agent"
}

data "aws_iam_role" "devops" {
  name = "devops"
}

data "aws_iam_role" "devops-lambda" {
  name = "devops-lambda"
}

data "aws_iam_role" "network-admin" {
  name = "network-admin"
}

data "aws_iam_role" "policy-admin" {
  name = "policy-admin"
}

data "aws_iam_role" "security-admin" {
  name = "security-admin"
}
