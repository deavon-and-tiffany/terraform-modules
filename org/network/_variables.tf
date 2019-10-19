variable "cidr" {
  type    = string
  default = "172.16.0.0/12"

  description = "The complete network CIDR block for on premise and cloud."
}

variable "on_premise" {
  type        = bool
  default     = false
  description = "A value indicating whether or not to reserve a block for on-premise networks."
}

variable "platform_bits" {
  type        = number
  default     = 2
  description = "The number of bits to use for on-premise and cloud platform providers. Must be >= 2"
}

locals {
  platform_bits = var.platform_bits < 2 ? 2 : var.platform_bits
  region_bits   = 5
  vpc_bits      = 2
  zone_bits     = 3

  platform_blocks = [
    for block in range(local.platform_bits * 2) : cidrsubnet(var.cidr, var.platform_bits, block)
  ]

  on_premise = var.on_premise ? local.platform_blocks[0] : null
  cloud      = slice(local.platform_blocks, var.on_premise ? 1 : 0, length(local.platform_blocks))

  zone_numbers = {
    a = 0
    b = 1
    c = 2
    d = 3
    e = 4
    f = 5
  }
}
