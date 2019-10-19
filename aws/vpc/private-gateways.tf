resource "aws_eip" "nat" {
  for_each = local.zones
  vpc      = true

  tags = merge(
    { Name = "${var.name}-nat-${each.key}" },
    {
      "net/region"       = var.region
      "net/zone"         = each.key
      "net/availability" = "private"
      "net/public"       = "false"
      "net/private"      = "true"
    },
    local.tags
  )
}

resource "aws_nat_gateway" "gateway" {
  for_each = local.zones

  allocation_id = aws_eip.nat["${each.key}"].id
  subnet_id     = aws_subnet.private["${each.key}"].id

  tags = merge(
    { Name = "${var.name}-ngw-${each.key}" },
    {
      "net/region"       = var.region
      "net/zone"         = each.key
      "net/availability" = "private"
      "net/public"       = "false"
      "net/private"      = "true"
    },
    local.tags
  )

  depends_on = [aws_internet_gateway.gateway]
}
