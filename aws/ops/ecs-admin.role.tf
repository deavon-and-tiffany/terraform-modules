resource "aws_iam_role" "ecs-admin" {
  name        = "ecs-admin"
  path        = "/ops/"
  description = "A role used to assume permissions required to create and modify ECS cluster resources within the hierarchy."
  tags        = local.tags

  assume_role_policy    = data.aws_iam_policy_document.ecs-admin-assume.json
  force_detach_policies = true
}

resource "aws_iam_role_policy_attachment" "ecs-admin" {
  policy_arn = aws_iam_policy.ecs-admin.arn
  role       = aws_iam_role.ecs-admin.id
}

resource "aws_iam_role_policy_attachment" "ecs-admin-network-admin" {
  policy_arn = aws_iam_policy.network-admin.arn
  role       = aws_iam_role.ecs-admin.id
}

resource "aws_iam_role_policy_attachment" "ecs-admin-security-admin" {
  policy_arn = aws_iam_policy.security-admin.arn
  role       = aws_iam_role.ecs-admin.id
}

resource "aws_iam_role_policy_attachment" "ecs-admin-policy-admin" {
  policy_arn = aws_iam_policy.policy-admin.arn
  role       = aws_iam_role.ecs-admin.id
}

data "aws_iam_policy_document" "ecs-admin-assume" {
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
