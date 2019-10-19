resource "aws_route_table" "public" {
  for_each = local.zones
  vpc_id   = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.name}-public-${each.key}" },
    {
      "net/region"       = "${var.region}"
      "net/zone"         = each.key
      "net/availability" = "public"
      "net/public"       = "true"
      "net/private"      = "false"
    },
    local.tags
  )
}

resource "aws_route" "public-internet-gateway" {
  for_each               = local.zones
  route_table_id         = aws_route_table.public["${each.key}"].id
  gateway_id             = aws_internet_gateway.gateway.id
  destination_cidr_block = "0.0.0.0/0"

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "public-egress-gateway" {
  for_each                    = var.enable_ipv6 ? local.zones : []
  route_table_id              = aws_route_table.public["${each.key}"].id
  egress_only_gateway_id      = aws_egress_only_internet_gateway.gateway[0].id
  destination_ipv6_cidr_block = "::/0"

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "public" {
  for_each = local.zones

  subnet_id      = aws_subnet.public["${each.key}"].id
  route_table_id = aws_route_table.public["${each.key}"].id
}
