resource "aws_s3_bucket" "terraform-state" {
  bucket = "terraform.${var.name}.${var.domain}"
  acl    = "private"

  tags = merge(
    local.tags,
    { Name = "terraform.${var.name}.${var.domain}" }
  )

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "state"
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
    target_bucket = local.log_bucket
    target_prefix = "terraform.${var.name}.${var.domain}/"
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = aws_kms_key.terraform-state.key_id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-state" {
  bucket = aws_s3_bucket.terraform-state.id

  block_public_acls   = true
  block_public_policy = true
}
