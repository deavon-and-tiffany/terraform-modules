resource "aws_iam_policy" "security-viewer" {
  name        = "security-viewer"
  path        = "/ops/"
  description = "A policy that enables the description of IAM users, groups, roles, and policies within the hierarchy."

  policy = data.aws_iam_policy_document.security-viewer.json
}

data "aws_iam_policy_document" "security-viewer" {
  statement {
    sid = "AllowSecurityView"
    actions = [
      "iam:Generate*",
      "iam:Get*",
      "iam:List*"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }
  }
}
