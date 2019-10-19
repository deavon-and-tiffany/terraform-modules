provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_eks_cluster.cluster.vpc_config.vpc_id

  tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
