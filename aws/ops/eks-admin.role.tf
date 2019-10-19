resource "aws_iam_role" "eks-admin" {
  name        = "eks-admin"
  path        = "/ops/"
  description = "A role used to assume permissions required to create and modify network infrastructure within the hierarchy."
  tags        = local.tags

  assume_role_policy    = data.aws_iam_policy_document.eks-admin-assume.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "eks-admin" {
  policy_arn = aws_iam_policy.eks-admin.arn
  role       = aws_iam_role.eks-admin.id
}

resource "aws_iam_role_policy_attachment" "eks-admin-network-admin" {
  policy_arn = aws_iam_policy.network-admin.arn
  role       = aws_iam_role.eks-admin.id
}

resource "aws_iam_role_policy_attachment" "eks-admin-security-admin" {
  policy_arn = aws_iam_policy.security-admin.arn
  role       = aws_iam_role.eks-admin.id
}

resource "aws_iam_role_policy_attachment" "eks-admin-policy-admin" {
  policy_arn = aws_iam_policy.policy-admin.arn
  role       = aws_iam_role.eks-admin.id
}

data "aws_iam_policy_document" "eks-admin-assume" {
  statement {
    sid     = "AllowAssume"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.agent.arn,
        data.aws_caller_identity.current.arn,
        "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/${aws_iam_role.agent.name}/terraform",
        "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/${aws_iam_role.devops.name}/terraform"
      ]
    }
  }
}
