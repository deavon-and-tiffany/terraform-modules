resource "aws_eks_node_group" "node-group" {
  cluster_name    = data.aws_eks_cluster.cluster.name
  node_group_name = var.name
  node_role_arn   = aws_iam_role.node.arn
  subnet_ids      = local.subnet_ids
  ami_type        = var.ami_type

  tags = local.tags

  scaling_config {
    desired_size = var.scaling.initial
    min_size     = var.scaling.min
    max_size     = var.scaling.max
  }

  depends_on = [
    aws_iam_role_policy_attachment.node-policy,
    aws_iam_role_policy_attachment.cni-policy,
    aws_iam_role_policy_attachment.registry-policy,
  ]
}
