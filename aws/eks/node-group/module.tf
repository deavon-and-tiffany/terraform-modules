provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_eks_cluster.cluster.vpc_config.vpc_id

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
