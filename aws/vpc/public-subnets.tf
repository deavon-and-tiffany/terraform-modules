resource "aws_subnet" "public" {
  for_each = local.zones

  vpc_id                          = aws_vpc.vpc.id
  cidr_block                      = cidrsubnet(module.network.current.zones["${each.key}"], 1, 1)
  availability_zone               = "${var.region}${each.key}"
  map_public_ip_on_launch         = true
  assign_ipv6_address_on_creation = var.enable_ipv6

  ipv6_cidr_block = cidrsubnet(cidrsubnet(aws_vpc.vpc.ipv6_cidr_block, 7, local.zone_numbers["${each.key}"]), 1, 1)

  tags = merge(
    {
      Name = "${var.name}-public-${each.key}"
    },
    {
      "net/region"             = "${var.region}"
      "net/zone"               = each.key
      "net/availability"       = "public"
      "net/public"             = "true"
      "net/private"            = "false",
      "kubernetes.io/role/elb" = "1"
    },
    local.tags
  )
}
