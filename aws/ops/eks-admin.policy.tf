resource "aws_iam_policy" "eks-admin" {
  name        = "eks-admin"
  path        = "/ops/"
  description = "A role used to assume permissions required to create and modify EKS cluster resources within the hierarchy."

  policy = data.aws_iam_policy_document.eks-admin.json
}

data "aws_iam_policy_document" "eks-admin" {
  statement {
    sid = "AllowEKSAdmin"
    actions = [
      "eks:*"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = [for k, v in local.required_tags : k]
    }
  }
}
