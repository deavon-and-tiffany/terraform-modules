variable "assume_role" {
  type        = string
  default     = null
  description = "The role to assume when creating the ops configuration."
}

variable "name" {
  type        = string
  description = "The name of the cluster."
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region in which to deploy resources into the account."
}

variable "endpoints" {
  type = object({
    public  = bool
    private = bool
  })
  default = {
    public  = false
    private = true
  }
  description = <<EOT
    Values indicating whether or not to enable the private and public API server endpoints. By default, only the private
    endpoint is enabled.
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "The version of kubernetes to use within the cluster. Default: use the latest available version."
}

variable "vpc_id" {
  type        = string
  description = <<EOT
    The ID of the VPC in which to deploy the cluster. The cluster will be deployed across all availability zones within
    the vpc. Private subnets must be tagged with 'kubernetes.io/role/internal-elb = 1' or they will not be included.
    Public subnets for external load balancers must be tagged with 'kubernetes.io/role/elb = 1' or they will not be
    included. The vpc module included alongside this repository already sets these tags.
    EOT
}

variable "log_retention_days" {
  type        = number
  default     = 7
  description = "The number of days to retain cluster control plane logs. Default: 7"
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
      Name                  = var.name,
      "ops/managed-by"      = "terraform",
      "terraform/workspace" = terraform.workspace
    },
    local.required_tags,
    var.tags
  )
}
