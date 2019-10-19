resource "aws_iam_role" "security-admin" {
  name               = "security-admin"
  path               = "/ops/"
  assume_role_policy = data.aws_iam_policy_document.security-admin-assume.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "security-admin" {
  policy_arn = aws_iam_policy.security-admin.arn
  role       = aws_iam_role.security-admin.id
}

resource "aws_iam_role_policy_attachment" "security-admin-security-viewer" {
  policy_arn = aws_iam_policy.security-viewer.arn
  role       = aws_iam_role.security-admin.id
}

data "aws_iam_policy_document" "security-admin-assume" {
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
