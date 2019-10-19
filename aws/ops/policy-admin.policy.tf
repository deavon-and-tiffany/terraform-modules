resource "aws_iam_policy" "policy-admin" {
  name        = "policy-admin"
  path        = "/ops/"
  description = "A policy that enables the administration of IAM users, groups, and roles within the hierarchy."

  policy = data.aws_iam_policy_document.policy-admin.json
}

data "aws_iam_policy_document" "policy-admin" {
  statement {
    sid = "AllowSecurityCreation"
    actions = [
      "iam:CreatePolicy",
      "iam:CreatePolicyVersion",
      "iam:DeletePolicy",
      "iam:DeletePolicyVersion",
      "iam:DetachGroupPolicy",
      "iam:DetachUserPolicy",
      "iam:DetachRolePolicy"
    ]

    resources = [
      "*"
    ]
  }
}
