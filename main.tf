resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(
    {
      Name = var.vpc_name
    },
    var.tags
  )
}

resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.subnet_cidr
  availability_zone       = var.az
  map_public_ip_on_launch = var.is_public

  tags = merge(
    {
      Name = "${var.vpc_name}-subnet"
    },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  count  = var.is_public ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.vpc_name}-igw"
    },
    var.tags
  )
}

resource "aws_route_table" "public" {
  count  = var.is_public ? 1 : 0
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "${var.vpc_name}-public-rt"
    },
    var.tags
  )
}

resource "aws_route" "internet_access" {
  count                  = var.is_public ? 1 : 0
  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0" # All traffic not local goes to the IGW
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public_association" {
  count          = var.is_public ? 1 : 0
  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.public[0].id
}
