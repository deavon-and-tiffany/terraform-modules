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

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

module "recommended" {
  source = "../../../kubernetes/recommended"
}

module "features" {
  source = "../../../kubernetes/features"

  grafana        = var.grafana
  prometheus     = var.prometheus
  cert_manager   = var.cert_manager
  sealed_secrets = var.sealed_secrets
  flux           = var.flux
}
