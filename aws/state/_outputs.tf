output "kms_key" {
  value = aws_kms_key.terraform-state.id
}

output "table" {
  value = aws_dynamodb_table.terraform-state-lock.id
}

output "bucket" {
  value = aws_s3_bucket.terraform-state.id
}
