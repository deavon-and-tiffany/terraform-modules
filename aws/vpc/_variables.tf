variable "assume_role" {
  type        = string
  default     = null
  description = "The role to assume when creating the vpc."
}

variable "name" {
  type        = string
  description = "The unique name for the account, preferrably a domain name."
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region for the vpc."
}

variable "vpc_number" {
  type        = number
  description = "The network number for the vpc which is used to carve out a CIDR block. This should be unique for each VPC within the AWS network."
}

variable "instance_tenancy" {
  type        = string
  default     = null
  description = "The desired instance tenancy within the vpc."
}

variable "enable_ipv6" {
  type        = bool
  default     = true
  description = "A value indicating whether or not to enable IPv6 support within the vpc."
}

variable "enable_dns_hostnames" {
  type        = bool
  default     = true
  description = "A value indicating whether or not to enable dns hostnames within the vpc."
}

variable "enable_dns_support" {
  type        = bool
  default     = true
  description = "A value indicating whether or not to enable dns support within the vpc."
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "The list of availability zones for the vpc. If this is not set, then two zones will be selected by default."
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
  zones        = toset(var.zones == null ? slice(module.network.current.region.zones, 0, 2) : var.zones)
  zone_bits    = module.network.current.zone_bits
  zone_numbers = module.network.current.zone_numbers
  cidr         = module.network.current.region.cidr

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
