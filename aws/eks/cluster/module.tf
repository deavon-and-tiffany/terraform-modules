provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}

data "aws_subnet_ids" "public" {
  vpc_id = var.vpc_id

  tags = {
    "kubernetes.io/role/elb" = "1"
  }
}
