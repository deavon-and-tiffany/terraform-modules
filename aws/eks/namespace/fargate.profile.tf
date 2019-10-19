resource "aws_eks_fargate_profile" "fargate" {
  fargate_profile_name   = var.name
  cluster_name           = data.aws_eks_cluster.cluster.name
  pod_execution_role_arn = data.aws_iam_role.fargate.arn
  subnet_ids             = data.aws_subnet_ids.private.ids

  selector {
    namespace = var.name
    labels    = var.fargate_labels
  }
}

data "aws_iam_role" "fargate" {
  name = "${var.cluster_name}-fargate"
}
