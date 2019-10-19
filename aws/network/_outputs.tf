output "cidr" {
  value       = local.cidr
  description = "The CIDR block assigned to all of Amazon Web Services."
}

output "regions" {
  value       = local.regions
  description = "A map of CIDR blocks reserved for each region within Amazon Web Services."
}

output "zones" {
  value       = local.zones
  description = "A map of CIDR blocks reserved for each availability zone within Amazon Web Services."
}

output "current" {
  value = {
    cidr         = local.cidr
    region       = local.regions["${var.region}"]
    vpc_bits     = local.vpc_bits
    zones        = local.zones["${var.region}"]
    zone_bits    = local.zone_bits
    zone_numbers = local.zone_numbers
  }

  description = "The CIDR block for the current cloud provider, regions, and availability zones."
}
