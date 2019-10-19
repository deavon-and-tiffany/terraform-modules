resource "aws_iam_role" "fargate" {
  name               = "${var.name}-fargate"
  assume_role_policy = data.aws_iam_policy_document.fargate-assume.json
  tags = merge(
    { Name = "${var.name}-fargate" },
    local.tags
  )
}

resource "aws_iam_role_policy_attachment" "fargate" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate.name
}

data "aws_iam_policy_document" "fargate-assume" {
  statement {
    sid     = "AllowAssume"
    actions = ["sts:AssumeRole"]

    principals {
      type = "Service"
      identifiers = [
        "eks-fargate-pods.amazonaws.com"
      ]
    }
  }
}
