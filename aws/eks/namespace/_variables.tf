variable "assume_role" {
  type        = string
  default     = null
  description = "The role to assume when creating the ops configuration."
}

variable "annotations" {
  type        = map(string)
  default     = {}
  description = "A map of annotations to add to the namespace."
}

variable "labels" {
  type        = map(string)
  default     = {}
  description = "A map of labels to add to the namespace."
}

variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region in which to deploy resources into the account."
}

variable "name" {
  type        = string
  description = "The name of the namespace."
}

variable "fargate_labels" {
  type        = map(string)
  default     = { fargate = "true" }
  description = <<EOT
    The labels to use to schedule pods within the namespace on Fargate. By default, a label of 'fargate: "true"' is
    used.
  EOT
}

variable "cluster_name" {
  type        = string
  description = "The name of the cluster in which to create the namespace."
}
