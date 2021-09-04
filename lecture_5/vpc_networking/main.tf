################################################################################
# VPC
################################################################################

resource "aws_vpc" "myVPC" {
  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink
  enable_classiclink_dns_support   = var.enable_classiclink_dns_support
  assign_generated_ipv6_cidr_block = var.enable_ipv6

  tags = {
    Name = var.vpc_name

  }
}


###############################################################################
# Internet Gateway
###############################################################################

resource "aws_internet_gateway" "myIGW" {

  vpc_id = aws_vpc.myVPC.id
  tags = {
    "Name" = var.igw_tag
  }
}


################################################################################
# Availability Zones list out
################################################################################
data "aws_availability_zones" "available" {
  state = "available"
}

################################################################################
# Public subnet
################################################################################

resource "aws_subnet" "public_subnet" {
  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.public_subnets_cidr
  availability_zone               = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch         = var.map_public_ip_on_launch
  assign_ipv6_address_on_creation = var.public_subnet_assign_ipv6_address_on_creation

  tags = {
   "Name" = var.public_subnet_tag
  }
}

################################################################################
# Database subnet
################################################################################

resource "aws_subnet" "database_subnet" {
  vpc_id                          = aws_vpc.myVPC.id
  cidr_block                      = var.database_subnets_cidr
  availability_zone               = data.aws_availability_zones.available.names[0]
  assign_ipv6_address_on_creation = var.private_subnet_assign_ipv6_address_on_creation
  map_public_ip_on_launch         = false

  tags = {
    "Name" = var.database_subnet_tag
  }
}


################################################################################
# Publiс routes
################################################################################

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    "Name" = var.public_route_table_tag
  }
}
resource "aws_route" "public_internet_gateway" {
  route_table_id         = [aws_route_table.public_route_table.id, aws_route_table.database_route_table.id]
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.myIGW.id
}

################################################################################
# Database route table
################################################################################

resource "aws_route_table" "database_route_table" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    "Name" = var.database_route_table_tag
  }
}

################################################################################
# Route table association with subnets
################################################################################

resource "aws_route_table_association" "public_route_table_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "database_route_table_association" {
  subnet_id      = aws_subnet.database_subnet.id
  route_table_id = aws_route_table.database_route_table.id
}

###############################################################################
# Security Group
###############################################################################


