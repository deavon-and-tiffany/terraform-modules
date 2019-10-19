provider "aws" {
  version = "~> 2"
  region  = var.region
}

data "aws_availability_zones" "zones" {}
