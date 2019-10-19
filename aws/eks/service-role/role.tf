resource "aws_iam_role" "role" {
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.role-assume.json
  tags               = local.tags
}

data "aws_iam_policy_document" "role-assume" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = local.oidc_provider.sub
      values   = ["system:serviceaccount:kube-system:aws-node"]
    }

    principals {
      type        = "Federated"
      identifiers = [local.oidc_provider.arn]
    }
  }
}

resource "aws_iam_policy" "role" {
  name   = aws_iam_role.role.name
  path   = "/eks/${var.cluster_name}/"
  policy = var.policy
}

resource "aws_iam_role_policy_attachment" "policy" {
  role       = aws_iam_role.role.id
  policy_arn = aws_iam_policy.role.arn
}
