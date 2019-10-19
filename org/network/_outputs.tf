output "cidr" {
  value = var.cidr
}

output "on_premise" {
  value       = local.on_premise
  description = "The CIDR block reserved for on-premise use."
}

output "additional_cloud" {
  value = slice(local.cloud, 3, length(local.cloud))
}

output "region_bits" {
  value = local.region_bits
}

output "vpc_bits" {
  value = local.vpc_bits
}

output "zone_bits" {
  value = local.zone_bits
}

output "zone_numbers" {
  value = local.zone_numbers
}

output "aws" {
  value       = local.cloud[0]
  description = "The CIDR block reserved for use in AWS."
}

output "azure" {
  value       = local.cloud[1]
  description = "The CIDR block reserved for use in Azure."
}

output "gcp" {
  value       = local.cloud[2]
  description = "The CIDR block reserved for use in GCP."
}
