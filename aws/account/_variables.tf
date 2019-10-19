variable "name" {
  type        = string
  description = "The name of the account, preferrably a domain name."
}

variable "domain" {
  type        = string
  description = <<EOF
    The domain name for the account, which is used to ensure unique names for globally unique resources, such as s3
    buckets.
  EOF
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region in which to deploy resources into the account."
}

variable "parent_id" {
  type        = string
  default     = null
  description = "The organizational unit that is the parent for the account."
}

variable "allow_billing" {
  type        = bool
  default     = true
  description = "A value indicating whether or not to allow access to billing for the IAM users within the account."
}

variable "email" {
  type        = string
  default     = null
  description = <<EOT
    The email address associated with the account. This must be globally unique within AWS for accounts. If no email is
    provided, one is generated as {email_prefix}+{name}@{email_domain}
  EOT
}

variable "email_prefix" {
  type        = string
  default     = "aws"
  description = <<EOT
    The email prefix to use to generate an email address using a psuedo alias if no email address is provided.
  EOT
}

variable "email_domain" {
  type        = string
  default     = null
  description = <<EOT
    The email domain used to generate an email address using a psuedo alias if no email address is provided.
  EOT
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
  description = "The tags to apply to resources within the accounts."
}

locals {
  allow_billing = var.allow_billing ? "ALLOW" : "DENY"
  email_domain  = var.email_domain == null ? var.domain : var.email_domain
  email         = var.email != null ? var.email : "${var.email_prefix}+${var.name}-${terraform.workspace}@${local.email_domain}"
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
