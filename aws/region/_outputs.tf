output "region" {
  value = var.region
}

output "zones" {
  value = [
    for zone in data.aws_availability_zones.zones.names : trimprefix(zone, var.region)
  ]
}
