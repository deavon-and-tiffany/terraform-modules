provider "aws" {
  version = "~> 2"
  region  = var.region
  assume_role {
    role_arn     = var.assume_role
    session_name = var.assume_role == null ? null : "terraform"
  }
}

module "network" {
  source     = "../network"
  region     = var.region
  vpc_number = var.vpc_number
}

resource "aws_vpc" "vpc" {
  cidr_block           = local.cidr
  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support

  enable_classiclink               = false
  enable_classiclink_dns_support   = false
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = merge(
    { Name = var.name },
    {
      "net/region" = "${var.region}"
      "net/zone"   = join(", ", local.zones)
    },
    local.tags
  )
}
