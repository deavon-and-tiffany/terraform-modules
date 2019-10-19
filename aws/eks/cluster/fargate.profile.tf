resource "aws_eks_fargate_profile" "fargate" {
  fargate_profile_name   = var.name
  cluster_name           = aws_eks_cluster.cluster.name
  pod_execution_role_arn = aws_iam_role.fargate.arn
  subnet_ids             = data.aws_subnet_ids.private.ids

  selector {
    namespace = "kube-system"
  }

  selector {
    namespace = "default"
  }
}
