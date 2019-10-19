
resource "aws_s3_bucket_policy" "lambda" {
  bucket = aws_s3_bucket.lambda.id
  policy = data.aws_iam_policy_document.lambda.json
}

data "aws_iam_policy_document" "lambda" {
  statement {
    sid = "AllowSAMRepo"

    actions = [
      "s3:GetObject"
    ]

    principals {
      type = "Service"
      identifiers = [
        "serverlessrepo.amazonaws.com"
      ]
    }

    resources = [
      "${aws_s3_bucket.lambda.arn}/*"
    ]
  }
}
