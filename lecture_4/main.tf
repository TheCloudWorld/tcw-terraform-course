resource "aws_instance" "ec2_1" {
  ami           = "ami-0c2b8ca1dad447f8a"
  instance_type = "t2.micro"
  subnet_id     = data.aws_subnet.selected.id
  key_name = var.my_key
  tags = {
    Name = "HelloWorld"
  }
}
