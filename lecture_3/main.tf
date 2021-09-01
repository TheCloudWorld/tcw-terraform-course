provider "aws"{
    region = "us-east-1"
}

data "aws_subnet" "selected" {
  filter {
    name   = "tag:Name"
    values = [var.subnet_name]
  }
}

resource "aws_instance" "ec2_1" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected.id
  key_name = var.my_key
  tags = {
    Name = "HelloWorld"
  }
}

###################################################################

variable "subnet_name" {
  description = "This is the name of the subnet"
  type = string
  default = "subnet_1"
}

variable "my_key" {
  type = string
  default = "dev-account"
}