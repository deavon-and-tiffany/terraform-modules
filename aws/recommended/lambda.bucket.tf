resource "aws_s3_bucket" "lambda" {
  bucket = "lambda.${var.name}.${var.domain}"
  acl    = "private"

  tags = merge(
    local.tags,
    { Name = "lambda.${var.name}.${var.domain}" }
  )

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "lambda"
    enabled = true

    tags = local.tags

    noncurrent_version_transition {
      days          = 30
      storage_class = "ONEZONE_IA"
    }

    noncurrent_version_transition {
      days          = 60
      storage_class = "GLACIER"
    }

    noncurrent_version_expiration {
      days = 90
    }
  }

  logging {
    target_bucket = module.logging.bucket
    target_prefix = "lambda.${var.name}/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "lambda" {
  bucket = aws_s3_bucket.lambda.id

  block_public_acls   = true
  block_public_policy = true
}
