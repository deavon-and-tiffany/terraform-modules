resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = merge(
    { Name = "${var.name}-igw-ipv4" },
    {
      "net/region"       = "${var.region}"
      "net/zone"         = join(", ", local.zones)
      "net/availability" = "public"
      "net/public"       = "true"
      "net/private"      = "false"
    },
    local.tags
  )
}

resource "aws_egress_only_internet_gateway" "gateway" {
  count  = var.enable_ipv6 ? 1 : 0
  vpc_id = aws_vpc.vpc.id
}
