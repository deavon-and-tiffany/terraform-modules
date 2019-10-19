
resource "aws_dynamodb_table" "terraform-state-lock" {
  name           = "terraform-state-lock"
  billing_mode   = "PROVISIONED"
  read_capacity  = 2
  write_capacity = 2
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}
