resource "aws_iam_role" "agent" {
  name               = "agent"
  path               = "/ops/"
  description        = "This role should be assumed by agent virtual machines, containers, or lambdas. An agent could be Azure DevOps, GitLab Runner, etc."
  assume_role_policy = data.aws_iam_policy_document.agent-assume.json
  tags               = local.tags
}

resource "aws_iam_role_policy_attachment" "agent-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  role       = aws_iam_role.agent.id
}

data "aws_iam_policy_document" "agent-assume" {
  statement {
    sid     = "AllowAssumeService"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["ops/agent"]
    }
  }

  statement {
    sid     = "AllowAssumeUser"
    actions = ["sts:AssumeRole"]

    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:PrincipalType"
      values   = ["User"]
    }
  }
}
