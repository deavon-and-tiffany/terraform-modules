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

variable "cluster_name" {
  type        = string
  description = "The name of the cluster in which to install features."
}

variable "prometheus" {
  type        = bool
  default     = true
  description = "A value indicating whether or not to install prometheus into the cluster."
}

variable "grafana" {
  type        = bool
  default     = true
  description = "A value indicating whether or not to install grafana into the cluster."
}
