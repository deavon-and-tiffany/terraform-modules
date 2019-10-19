resource "aws_route_table" "private" {
  for_each = local.zones
  vpc_id   = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.name}-private-${each.key}" },
    {
      "net/region"       = var.region
      "net/zone"         = each.key
      "net/availability" = "private"
      "net/public"       = "false"
      "net/private"      = "true"
    },
    local.tags
  )

  lifecycle {
    ignore_changes = [propagating_vgws]
  }
}

resource "aws_route" "private-nat-gateway" {
  for_each               = local.zones
  route_table_id         = aws_route_table.private["${each.key}"].id
  nat_gateway_id         = aws_nat_gateway.gateway["${each.key}"].id
  destination_cidr_block = "0.0.0.0/0"

  timeouts {
    create = "5m"
  }
}

resource "aws_route" "private-egress-gateway" {
  for_each                    = var.enable_ipv6 ? local.zones : []
  route_table_id              = aws_route_table.private["${each.key}"].id
  egress_only_gateway_id      = aws_egress_only_internet_gateway.gateway[0].id
  destination_ipv6_cidr_block = "::/0"

  timeouts {
    create = "5m"
  }
}

resource "aws_route_table_association" "private" {
  for_each = local.zones

  subnet_id      = aws_subnet.private["${each.key}"].id
  route_table_id = aws_route_table.private["${each.key}"].id
}
