resource "aws_eip" "nat_main" {
  domain = "vpc"

  tags = {
    Name = "eip-nat-${var.environment}-${var.project_name}"
  }
}

resource "aws_nat_gateway" "nat_main" {
  allocation_id = aws_eip.nat_main.id
  subnet_id     = aws_subnet.public["a"].id

  tags = {
    Name = "nat-gateway-${var.environment}-${var.project_name}"
  }

}


resource aws_internet_gateway "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.environment}-${var.project_name}"
  }
}

resource aws_route "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource aws_route "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_main.id
  depends_on = [aws_nat_gateway.nat_main]
}