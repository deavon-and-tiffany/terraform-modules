resource "aws_iam_role" "devops-lambda" {
  name               = "devops-lambda"
  path               = "/ops/"
  description        = "This role should be assumed as the primary role for deploying applications into AWS lambda using SAM, Serverless, etc."
  assume_role_policy = data.aws_iam_policy_document.devops-lambda-assume.json
  tags               = local.tags
}

data "aws_iam_policy_document" "devops-lambda-assume" {
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
