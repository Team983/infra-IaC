// Public Subnet
resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.public_subnets[count.index].cidr_block
  availability_zone = var.public_subnets[count.index].availability_zone

  tags = merge(
    {
      Name      = "${var.vpc_name}-public-${substr(var.public_subnets[count.index].availability_zone, -1, -2)}"
      ManagedBy = "terraform"
    }, var.tags
  )
}

// Private Subnet
resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index].cidr_block
  availability_zone = var.private_subnets[count.index].availability_zone

  tags = merge(
    {
      Name      = "${var.vpc_name}-private-${substr(var.private_subnets[count.index].availability_zone, -1, -2)}"
      ManagedBy = "terraform"
    }, var.tags
  )
}

// Nat Gateway
resource "aws_eip" "public" {
  count = length(var.public_subnets)

  vpc = true

  tags = merge(
    {
      Name      = "${var.vpc_name}-nat-${substr(var.public_subnets[count.index].availability_zone, -1, -2)}"
      ManagedBy = "terraform"
    }, var.tags
  )
}

resource "aws_nat_gateway" "nat_gateway" {
  count = length(var.public_subnets)

  allocation_id = aws_eip.public[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    {
      Name      = "${var.vpc_name}-nat-${substr(var.public_subnets[count.index].availability_zone, -1, -2)}"
      ManagedBy = "terraform"
    }, var.tags
  )
}

// Routing Table
resource "aws_route_table" "public" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = merge(
    {
      Name      = "${var.vpc_name}-public"
      ManagedBy = "terraform"
    }, var.tags
  )
}

resource "aws_route_table" "private" {
  count = length(var.private_subnets)

  vpc_id = var.vpc_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  tags = merge(
    {
      Name      = "${var.vpc_name}-private-${substr(var.private_subnets[count.index].availability_zone, -1, -2)}"
      ManagedBy = "terraform"
    }, var.tags
  )
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  route_table_id = aws_route_table.private[count.index].id
  subnet_id      = aws_subnet.private[count.index].id
}