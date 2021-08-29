provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "myVpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags = {
    Name = "myVpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVpc.id

  tags = {
    Name = "igw"
  }
}

resource "aws_subnet" "mySubnet" {
  vpc_id     = aws_vpc.myVpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "mySubnet"
  }
}

resource "aws_route_table" "myRT" {
  vpc_id = aws_vpc.myVpc.id

  route = []

  tags = {
    Name = "myRouteTable"
  }
}
resource "aws_route" "myR" {
  route_table_id            = aws_route_table.myRT.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id  = aws_internet_gateway.igw.id
  depends_on                = [aws_route_table.myRT]
}
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mySubnet.id
  route_table_id = aws_route_table.myRT.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_all_traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myVpc.id

  ingress = [
    {
      description      = "all traffic"
      from_port        = 0
      to_port          = 0
      protocol         = -1
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      security_groups = null
      self = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description = "egress"
      prefix_list_ids = null
      security_groups = null
      self = null
    }
  ]

  tags = {
    Name = "allow_all_traffic"
  }
}

resource "aws_instance" "myEC2" {
  ami           = "ami-0c2b8ca1dad447f8a"
  subnet_id = aws_subnet.mySubnet.id
  instance_type = "t2.micro"

  tags = {
    Name = "HelloWorld"
  }
}