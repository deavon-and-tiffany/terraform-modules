resource "aws_iam_policy" "ecs-admin" {
  name        = "ecs-admin"
  path        = "/ops/"
  description = "A policy that enables the creation and modification of ECS cluster resources."

  policy = data.aws_iam_policy_document.ecs-admin.json
}

data "aws_iam_policy_document" "ecs-admin" {
  statement {
    sid = "AllowECSAdmin"
    actions = [
      "ecs:*"
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
