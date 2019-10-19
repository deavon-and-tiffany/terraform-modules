resource "aws_default_network_acl" "vpc" {
  default_network_acl_id = aws_vpc.vpc.default_network_acl_id

  subnet_ids = concat(
    [for value in aws_subnet.private : value.id],
    [for value in aws_subnet.public : value.id]
  )

  # allow tls web requests (ipv4)
  ingress {
    protocol   = 6 # tcp
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # allow tls web requests (ipv6)
  ingress {
    protocol        = 6 # tcp
    rule_no         = 101
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 443
    to_port         = 443
  }

  # allow ingress from http responses on ephemeral ports (ipv4)
  ingress {
    protocol   = 6 # tcp
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # allow ingress from http responses on ephemeral ports (ipv6)
  ingress {
    protocol        = 6 # tcp
    rule_no         = 102
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 1024
    to_port         = 65535
  }

  # allow egress on tls (ipv4)
  egress {
    protocol   = 6 # tcp
    rule_no    = 100
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 443
    to_port    = 443
  }

  # allow egress on tls (ipv6)
  egress {
    protocol        = 6 # tcp
    rule_no         = 101
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 443
    to_port         = 443
  }

  # allow egress for http on ephemeral ports (ipv4)
  egress {
    protocol   = 6 # tcp
    rule_no    = 102
    action     = "allow"
    cidr_block = "0.0.0.0/0"
    from_port  = 1024
    to_port    = 65535
  }

  # allow egress for http on ephemeral ports (ipv6)
  egress {
    protocol        = 6 # tcp
    rule_no         = 102
    action          = "allow"
    ipv6_cidr_block = "::/0"
    from_port       = 1024
    to_port         = 65535
  }
}
