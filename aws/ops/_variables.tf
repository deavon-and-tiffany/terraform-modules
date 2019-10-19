variable "assume_role" {
  type        = string
  default     = null
  description = "The role to assume when creating the ops configuration."
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region in which to deploy resources into the account."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

variable "org" {
  type = object({
    hierarchy_id = string
    division     = string
    product      = string
    service      = string
  })

  description = "The organizational hierarchy for the resource."
}

variable "owners" {
  type = object({
    billing   = string
    business  = string
    technical = string
  })
  description = "The business and technical owners associated with the resource."
}

locals {
  required_tags = merge(
    { for k, v in var.org : "org/${k}" => v },
    { for k, v in var.owners : "owners/${k}" => v }
  )
  tags = merge(
    {
      "ops/managed-by"      = "terraform",
      "terraform/workspace" = terraform.workspace
    },
    local.required_tags,
    var.tags
  )
  arn_prefix = "arn:${data.aws_partition.current.partition}:ec2::${data.aws_caller_identity.current.account_id}"
}
