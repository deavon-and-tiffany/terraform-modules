variable "region" {
  type        = string
  default     = "eu-west-2"
  description = "The region for which to capture a network."
}

variable "vpc_number" {
  type        = number
  description = "The number of the VPC used to determine a unique CIDR block."
}

locals {
  region_bits  = module.network.region_bits
  vpc_bits     = module.network.vpc_bits
  zone_bits    = module.network.zone_bits
  zone_numbers = module.network.zone_numbers

  cidr = cidrsubnet(module.network.aws, local.vpc_bits, var.vpc_number)

  regions = {
    # united states
    eu-west-2 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 0),
      zones = module.eu-west-2.zones
    }
    # us-east-2 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 1),
    #   zones = module.us-east-2.zones
    # }
    # us-west-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 2),
    #   zones = module.us-west-1.zones
    # }
    # us-west-2 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 3),
    #   zones = module.us-west-2.zones
    # }

    # # asia pacific
    # ap-east-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 4),
    #   zones = module.ap-east-1.zones
    # }
    # ap-northeast-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 5),
    #   zones = module.ap-northeast-1.zones
    # }
    # ap-northeast-2 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 6),
    #   zones = module.ap-northeast-2.zones
    # }
    # ap-northeast-3 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 7),
    #   zones = module.ap-northeast-3.zones
    # }
    # ap-south-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 8),
    #   zones = module.ap-south-1.zones
    # }
    # ap-southeast-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 9),
    #   zones = module.ap-southeast-1.zones
    # }
    # ap-southeast-2 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 10),
    #   zones = module.ap-southeast-2.zones
    # }

    # # canada
    # ca-central-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 11),
    #   zones = module.ca-central-1.zones
    # }

    # europe
    # eu-north-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 12),
    #   zones = module.eu-north-1.zones
    # }
    # eu-west-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 13),
    #   zones = module.eu-west-1.zones
    # }
    eu-west-2 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 14),
      zones = module.eu-west-2.zones
    }
    # eu-west-3 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 15),
    #   zones = module.eu-west-3.zones
    # }
    # eu-central-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 16),
    #   zones = module.eu-central-1.zones
    # }

    # # south america
    # sa-east-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 17),
    #   zones = module.sa-east-1.zones
    # }

    # # middle east
    # me-south-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 18),
    #   zones = module.me-south-1.zones
    # }

    # # china
    # cn-north-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 19),
    #   zones = module.cn-north-1.zones
    # }
    # cn-northwest-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 20),
    #   zones = module.cn-northwest-1.zones
    # }

    # # us government
    # us-gov-east-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 21),
    #   zones = module.us-gov-east-1.zones
    # }
    # us-gov-west-1 = {
    #   cidr  = cidrsubnet(local.cidr, local.region_bits, 22),
    #   zones = module.us-gov-west-1.zones
    # }
  }

  zones = { for region, value in local.regions
    : region => { for zone in value.zones
    : zone => cidrsubnet(value.cidr, local.zone_bits, local.zone_numbers["${zone}"]) }
  }
}
