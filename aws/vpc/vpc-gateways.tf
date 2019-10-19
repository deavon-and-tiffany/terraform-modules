resource "aws_vpc_endpoint" "s3" {
  vpc_id            = aws_vpc.vpc.id
  vpc_endpoint_type = "Gateway"
  auto_accept       = true

  route_table_ids = concat(
    [for value in aws_route_table.public : value.id],
    [for value in aws_route_table.private : value.id]
  )

  service_name = "com.amazonaws.${var.region}.s3"
}

resource "aws_vpc_endpoint" "dynamodb" {
  vpc_id            = aws_vpc.vpc.id
  vpc_endpoint_type = "Gateway"
  auto_accept       = true

  route_table_ids = concat(
    [for value in aws_route_table.public : value.id],
    [for value in aws_route_table.private : value.id]
  )

  service_name = "com.amazonaws.${var.region}.dynamodb"
}
