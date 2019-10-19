variable "assume_role" {
  type        = string
  default     = null
  description = "The role to assume when creating the recommended configuration."
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region in which to deploy resources into the account."
}

variable "name" {
  type        = string
  description = "The unique name for the account, preferrably a domain name."
}

variable "domain" {
  type        = string
  description = <<EOF
    The domain name for the account, which is used to ensure unique names for globally unique resources, such as s3
    buckets.
  EOF
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

locals {
  tags = merge(
    {
      Name                  = var.name,
      "ops/managed-by"      = "terraform",
      "terraform/workspace" = terraform.workspace
    },
    { for k, v in var.org : "org/${k}" => v },
    { for k, v in var.owners : "owners/${k}" => v },
    var.tags
  )
}
