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
  description = "The name of the service account role."
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster for which to create a service account role."
}

variable "policy" {
  type        = string
  description = "The policy to apply to the account role."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags associated with the resource."
}

locals {
  tags = merge(
    data.aws_eks_cluster.cluster.tags,
    { Name = var.name },
    var.tags
  )
  oidc_provider = {
    arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer}"
    sub = "${replace(aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://")}:sub"
  }
}
