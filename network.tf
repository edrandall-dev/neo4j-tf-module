resource "aws_vpc" "neo4j_vpc" {
  cidr_block           = var.vpc_base_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    "Name"      = "${var.env_prefix}-vpc"
    "Terraform" = true
  }
}

resource "aws_subnet" "neo4j_public_subnet" {
  count = var.node_count

  vpc_id                  = aws_vpc.neo4j_vpc.id
  cidr_block              = cidrsubnet(var.vpc_base_cidr, 8, count.index + 1)
  availability_zone       = join("", ["${var.region}", "${var.availability_zones[count.index]}"])
  map_public_ip_on_launch = true

  tags = {
    "Name"      = "${var.env_prefix}-public-subnet-${var.availability_zones[count.index]}"
    "Terraform" = true
  }
}

resource "aws_internet_gateway" "neo4j_igw" {
  vpc_id = aws_vpc.neo4j_vpc.id

  tags = {
    "Name"      = "${var.env_prefix}-vpc-igw"
    "Terraform" = true
  }
}

resource "aws_route_table" "neo4j_public_subnet_rt" {
  vpc_id = aws_vpc.neo4j_vpc.id
  tags = {
    "Name"      = "${var.env_prefix}-public-subnet-rt"
    "Terraform" = true
  }
}

resource "aws_route" "neo4j_public_subnet_route" {
  route_table_id         = aws_route_table.neo4j_public_subnet_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.neo4j_igw.id
}

resource "aws_route_table_association" "neo4j_public_route_assoc" {
  count          = var.node_count
  subnet_id      = aws_subnet.neo4j_public_subnet[count.index].id
  route_table_id = aws_route_table.neo4j_public_subnet_rt.id
}


/* 
#Private Subnet Stuff - Not normally required

resource "aws_nat_gateway" "neo4j_ngw" {
  allocation_id = aws_eip.neo4j_ngw_eip.id

  //The NGW resides in the first public subnet
  subnet_id = aws_subnet.neo4j_public_subnet[0].id

  tags = {
    "Name"      = "${var.env_prefix}-vpc-ngw"
    "Terraform" = true
  }

  //To ensure proper ordering, it is recommended to add an explicit dependency
  //on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.neo4j_igw]
}

resource "aws_route_table_association" "edr_private_route_assoc" {
  count          = var.private_subnet_qty
  subnet_id      = aws_subnet.neo4j_private_subnet[count.index].id
  route_table_id = aws_route_table.neo4j_private_subnet_rt.id
}

resource "aws_route" "neo4j_private_subnet_route" {
  route_table_id         = aws_route_table.neo4j_private_subnet_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.neo4j_ngw.id
}

resource "aws_eip" "neo4j_ngw_eip" {
  vpc = true

  tags = {
    "Name"      = "${var.env_prefix}-ngw-eip"
    "Terraform" = true
  }
}

resource "aws_subnet" "neo4j_private_subnet" {
  count = var.private_subnet_qty

  vpc_id                  = aws_vpc.neo4j_vpc.id
  cidr_block              = cidrsubnet(var.vpc_base_cidr, 8, count.index + 10)
  availability_zone       = join("", ["${var.region}", "${var.availability_zones[count.index]}"])
  map_public_ip_on_launch = false

  tags = {
    "Name"      = "${var.env_prefix}-private-subnet-${var.availability_zones[count.index]}"
    "Terraform" = true
  }
}

resource "aws_route_table" "neo4j_private_subnet_rt" {
  vpc_id = aws_vpc.neo4j_vpc.id
  tags = {
    "Name"      = "${var.env_prefix}-private-subnet-rt"
    "Terraform" = true
  }
}
*/