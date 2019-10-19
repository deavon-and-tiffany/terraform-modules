resource "aws_subnet" "private" {
  for_each = local.zones

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = cidrsubnet(module.network.current.zones["${each.key}"], 1, 0)
  availability_zone               = "${var.region}${each.key}"
  map_public_ip_on_launch         = false
  assign_ipv6_address_on_creation = var.enable_ipv6

  ipv6_cidr_block = cidrsubnet(cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 7, local.zone_numbers["${each.key}"]), 1, 0)

  tags = merge(
    { Name = "${var.name}-private-${each.key}" },
    {
      "net/region"                      = var.region
      "net/zone"                        = each.key
      "net/availability"                = "private"
      "net/public"                      = "false"
      "net/private"                     = "true",
      "kubernetes.io/role/internal-elb" = "1"
    },
    local.tags
  )
}
