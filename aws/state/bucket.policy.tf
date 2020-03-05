resource "aws_iam_role_policy_attachment" "terraform-state" {
  role       = var.state_role_name
  policy_arn = aws_iam_policy.terraform-state.arn
}

resource "aws_iam_policy" "terraform-state" {
  name   = "terraform-state"
  policy = data.aws_iam_policy_document.terraform-state.json
}

data "aws_iam_policy_document" "terraform-state" {
  statement {
    sid     = "AllowListBucket"
    effect  = "Allow"
    actions = ["s3:ListBucket"]
    resources = [
      aws_s3_bucket.terraform-state.arn
    ]
  }

  statement {
    sid    = "AllowGetObjectPutObject"
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.terraform-state.arn}/*"
    ]
  }
}
