resource "aws_iam_role" "policy-admin" {
  name               = "policy-admin"
  path               = "/ops/"
  assume_role_policy = data.aws_iam_policy_document.policy-admin-assume.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "policy-admin" {
  policy_arn = aws_iam_policy.policy-admin.arn
  role       = aws_iam_role.policy-admin.id
}

resource "aws_iam_role_policy_attachment" "policy-admin-security-viewer" {
  policy_arn = aws_iam_policy.security-viewer.arn
  role       = aws_iam_role.policy-admin.id
}

data "aws_iam_policy_document" "policy-admin-assume" {
  statement {
    sid     = "AllowAssume"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        aws_iam_role.agent.arn,
        data.aws_caller_identity.current.arn,
        "arn:aws:sts::${data.aws_caller_identity.current.account_id}:assumed-role/${aws_iam_role.agent.name}/terraform"
      ]
    }
  }
}
