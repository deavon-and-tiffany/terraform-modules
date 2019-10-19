output "name" {
  value = var.name
}

output "role" {
  value = {
    name = aws_iam_role.cluster.name
    arn  = aws_iam_role.cluster.arn
  }
}

output "oidc_provider" {
  value = {
    arn = aws_iam_openid_connect_provider.cluster.arn
    url = aws_iam_openid_connect_provider.cluster.url
    sub = "${replace(aws_iam_openid_connect_provider.cluster.url, "https://", "")}:sub"
  }
}

output "security_group_id" {
  value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}

output "certificate_authority" {
  value = aws_eks_cluster.cluster.certificate_authority
}
