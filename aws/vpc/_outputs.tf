output "id" {
  value = aws_vpc.vpc.id
}

output "network" {
  value = {
    ipv4 = aws_vpc.vpc.cidr_block
    ipv6 = aws_vpc.vpc.ipv6_cidr_block
  }
}

output "subnets" {
  value = {
    private = [for k, v in aws_subnet.private : {
      id   = v.id
      zone = v.availability_zone
      ipv4 = v.cidr_block
      ipv6 = v.ipv6_cidr_block
    }]

    public = [for k, v in aws_subnet.public : {
      id   = v.id
      zone = v.availability_zone
      ipv4 = v.cidr_block
      ipv6 = v.ipv6_cidr_block
    }]
  }
}

output "region" {
  value = var.region
}
