provider "aws" {
  region = "us-east-1"
}

###########  VPC block ##################

resource "aws_vpc" "myVpc" {
  cidr_block = "10.0.0.0/16"
}

##########  Internet Gateway ############
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVpc.id

  tags = {
    Name = "igw"
  }
}

######### Subnets #################

resource "aws_subnet" "mySubnet_1" {
  vpc_id     = aws_vpc.myVpc.id # Argument
  cidr_block = "10.0.1.0/24"

    tags = {
      Name = "subnet"
    }
}

resource "aws_subnet" "mySubnet_2" {
  vpc_id     = aws_vpc.myVpc.id # Argument
  cidr_block = "10.0.11.0/24"

    tags = {
      Name = "subnet"
    }
}
############ Route Table ###################

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myVpc.id

  route = []
  tags = {
    Name = "example"
  }
}

########### Route #####################

resource "aws_route" "route" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
  depends_on             = [aws_route_table.rt]
}

################# Route Table Associations #################

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.mySubnet_1.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.mySubnet_2.id
  route_table_id = aws_route_table.rt.id
}
######### Security Group ###################

resource "aws_security_group" "sg" {
  name        = "allow_all_traffic"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.myVpc.id

  ingress = [
    {
      description      = "All traffic"
      from_port        = 0    # All ports
      to_port          = 0    # All Ports
      protocol         = "-1" # All traffic
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = null
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      description      = "Outbound rule"
      prefix_list_ids  = null
      security_groups  = null
      self             = null
    }
  ]

  tags = {
    Name = "all_traffic"
  }
}


################ EC2 Instances ##########################

# resource "aws_instance" "ec2_1" {
#   ami           = "ami-0c2b8ca1dad447f8a"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.mySubnet_1.id
#   key_name = "dev-account"
#   tags = {
#     Name = "HelloWorld"
#   }
# }

# resource "aws_instance" "ec2_2" {
#   ami           = "ami-0c2b8ca1dad447f8a"
#   instance_type = "t2.micro"
#   subnet_id     = aws_subnet.mySubnet_2.id
#   key_name = "dev-account"
#   tags = {
#     Name = "HelloWorld"
#   }
# }