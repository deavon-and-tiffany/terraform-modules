provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

resource "aws_s3_bucket" "logging" {
  bucket = "logging.${var.name}.${var.domain}"
  acl    = "log-delivery-write"

  tags = merge(
    local.tags,
    { Name = "logging.${var.name}.${var.domain}" }
  )

  versioning {
    enabled = false
  }

  lifecycle_rule {
    id      = "log"
    enabled = true

    tags = local.tags

    transition {
      days          = 60
      storage_class = "ONEZONE_IA"
    }

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    expiration {
      days = 180
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = var.kms_master_key_id
        sse_algorithm     = var.kms_master_key_id == null ? "AES256" : "aws:kms"
      }
    }
  }
}
