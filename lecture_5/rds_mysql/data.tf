data "aws_availability_zones" "available" {
  state = "available"
}
data "aws_security_group" "tcw_sg" {
  filter {
    name = "tag:Name"
    values = ["tcw_security_group"]
  }
}