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

variable "name" {
  type        = string
  description = "The name of the node group."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster associated with the node group."
}

variable "ami_type" {
  type        = string
  default     = null
  description = "The type of AMI to use to create nodes within the node group."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

variable "scaling" {
  type = object({
    initial = number
    minimum = number
    maximum = number
  })
  default = {
    initial = 1
    minimum = 1
    maximum = 3
  }
  description = <<EOT
    The scaling for the node group. It is recommended to allow scaling to at least the number of availability zones.
  EOT
}

variable "subnet_ids" {
  type        = list(string)
  default     = null
  description = <<EOT
    The subnets in which to deploy the node pool. By default, the private subnets associated with the EKS cluster will
    be used.
  EOT
}

locals {
  subnet_ids = var.subnet_ids == null ? data.aws_subnet_ids.private.ids : var.subnet_ids
  tags = merge(
    data.aws_eks_cluster.cluster.tags,
    { Name = var.name },
    var.tags
  )
}
