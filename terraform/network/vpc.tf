data aws_availability_zones "available" {
  state = "available"
}

# maps subnet key -> cidrsubnet netnum
locals {
  public_subnets  = { a = 0, b = 1 }
  private_subnets = { a = 2, b = 3 }
}

resource aws_vpc "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc-${var.environment}-${var.project_name}"
  }
}

resource aws_subnet "public" {
  for_each                = local.public_subnets
  vpc_id                  = aws_vpc.main.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 2, each.value)
  availability_zone       = data.aws_availability_zones.available.names[each.value]
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-public-${each.key}-${var.environment}-${var.project_name}"
  }
}

resource aws_subnet "private" {
  for_each          = local.private_subnets
  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 2, each.value)
  availability_zone = data.aws_availability_zones.available.names[each.value - 2]

  tags = {
    Name = "subnet-private-${each.key}-${var.environment}-${var.project_name}"
  }

}

resource aws_route_table "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "route-table-public-${var.environment}-${var.project_name}"
  }
}


resource aws_route_table_association "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource aws_route_table "private" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "route-table-private-${var.environment}-${var.project_name}"
  }
}

resource aws_route_table_association "private" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

