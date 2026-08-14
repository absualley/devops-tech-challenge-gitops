# Public Subnet - Availability Zone A
resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name                     = "${var.project_name}-public-a"
      "kubernetes.io/role/elb" = "1"
    }
  )
}

# Public Subnet - Availability Zone B
resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name                     = "${var.project_name}-public-b"
      "kubernetes.io/role/elb" = "1"
    }
  )
}

# Private Subnet - Availability Zone A
resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.11.0/24"
  availability_zone = "us-east-1a"

  tags = merge(
    local.common_tags,
    {
      Name                              = "${var.project_name}-private-a"
      "kubernetes.io/role/internal-elb" = "1"
    }
  )
}

# Private Subnet - Availability Zone B
resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.12.0/24"
  availability_zone = "us-east-1b"

  tags = merge(
    local.common_tags,
    {
      Name                              = "${var.project_name}-private-b"
      "kubernetes.io/role/internal-elb" = "1"
    }
  )
}
