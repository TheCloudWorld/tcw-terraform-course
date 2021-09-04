data "aws_ami" "amazon_linux_2" {
 most_recent = true
 filter {
   name   = "owner-alias"
   values = ["amazon"]
 }
 filter {
   name   = "name"
   values = ["amzn2-ami-hvm*"]
 }
}

resource "aws_launch_configuration" "lc" {
  name_prefix   = "tcw_lc"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
}
