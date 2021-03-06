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
  type = object({
    namespace    = string
    version      = string
    force_update = bool
    values       = list(string)
  })
  default     = null
  description = "Provides for the customization of prometheus within the cluster."
}

variable "grafana" {
  type = object({
    namespace    = string
    version      = string
    force_update = bool
    values       = list(string)
  })
  default     = null
  description = "Provides for the customization of grafana within the cluster."
}

variable "cert_manager" {
  type = object({
    namespace    = string
    version      = string
    force_update = bool
    values       = list(string)
  })
  default     = null
  description = "Provides for the customization of cert-manager within the cluster."
}

variable "sealed_secrets" {
  type = object({
    namespace    = string
    version      = string
    force_update = bool
    values       = list(string)
  })
  default     = null
  description = "Provides for the customization of sealed-secrets within the cluster."
}

variable "flux" {
  type = object({
    namespace    = string
    version      = string
    force_update = bool
    values       = list(string)
  })
  default     = null
  description = "Provides for the customization of flux within the cluster."
}
