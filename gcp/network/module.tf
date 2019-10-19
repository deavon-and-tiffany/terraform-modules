module "network" {
  source = "../../../org/_modules/network"
}

variable "region" {
  type    = string
  default = "us-east1"
}

locals {
  cidr = module.network.gcp

  region_bits  = module.network.region_bits
  vpc_bits     = module.network.vpc_bits
  zone_bits    = module.network.zone_bits
  zone_numbers = module.network.zone_numbers

  regions = {
    # united states
    us-east1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 0),
      zones = ["b", "c", "d"]
    }
    us-east4 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 1),
      zones = ["a", "b", "c"]
    }
    us-central1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 2),
      zones = ["a", "b", "c"]
    }
    us-west1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 3),
      zones = ["a", "b", "c"]
    }
    us-west2 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 4),
      zones = ["a", "b", "c"]
    }

    # asia pacific
    asia-east1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 5),
      zones = ["a", "b", "c"]
    }
    asia-east2 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 6),
      zones = ["a", "b", "c"]
    }
    asia-northeast1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 7),
      zones = ["a", "b", "c"]
    }
    asia-northeast2 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 8),
      zones = ["a", "b", "c"]
    }
    asia-south1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 9),
      zones = ["a", "b", "c"]
    }
    asia-southeast1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 10),
      zones = ["a", "b", "c"]
    }

    # australia
    australia-southeast1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 11),
      zones = ["a", "b", "c"]
    }

    # canada
    northamerica-northeast1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 12),
      zones = ["a", "b", "c"]
    }

    # europe
    europe-north1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 13),
      zones = ["a", "b", "c"]
    }
    europe-west1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 14),
      zones = ["b", "c", "d"]
    }
    europe-west2 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 15),
      zones = ["a", "b", "c"]
    }
    europe-west3 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 16),
      zones = ["a", "b", "c"]
    }
    europe-west4 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 17),
      zones = ["a", "b", "c"]
    }
    europe-west5 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 18),
      zones = ["a", "b", "c"]
    }
    europe-west6 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 19),
      zones = ["a", "b", "c"]
    }

    # south america
    southamerica-east1 = {
      cidr  = cidrsubnet(local.cidr, local.region_bits, 20),
      zones = ["a", "b", "c"]
    }
  }

  zones = { for region, value in local.regions
    : region => { for zone in value.zones
    : zone => cidrsubnet(value.cidr, local.zone_bits, local.zone_numbers["${zone}"]) }
  }
}

output "cidr" {
  value       = local.cidr
  description = "The CIDR block assigned to all of Google Cloud Platform."
}

output "regions" {
  value       = local.regions
  description = "A map of CIDR blocks reserved for each region within Google Cloud Platform."
}

output "zones" {
  value       = local.zones
  description = "A map of CIDR blocks reserved for each availability zone within Google Cloud Platform."
}

output "current" {
  value = {
    cidr   = local.cidr
    region = local.regions["${var.region}"]
    zones  = local.zones["${var.region}"]
  }

  description = "The CIDR block for the current cloud provider, regions, and availability zones."
}
