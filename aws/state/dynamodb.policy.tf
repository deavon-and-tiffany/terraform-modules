resource "aws_iam_role_policy_attachment" "terraform-state-lock" {
  role       = var.state_role_name
  policy_arn = aws_iam_policy.terraform-state-lock.arn
}

resource "aws_iam_policy" "terraform-state-lock" {
  policy = data.aws_iam_policy_document.terraform-state-lock.json
}

data "aws_iam_policy_document" "terraform-state-lock" {
  statement {
    sid    = "AllowGetObjectPutObject"
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:PutItem",
      "dynamodb:DeleteItem"
    ]
    resources = [
      aws_dynamodb_table.terraform-state-lock.arn
    ]
  }
}
