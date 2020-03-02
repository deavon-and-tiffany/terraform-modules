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
