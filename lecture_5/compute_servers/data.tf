####################################################################
# Data source
####################################################################

data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["tcw_vpc"]
  }
}
data "aws_subnet_ids" "available_db_subnet" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["tcw_public_subnet*"]
  }
}

data "aws_subnet" "subnet_id_each" {
  for_each = data.aws_subnet_ids.available_db_subnet.ids
  id       = each.value
}

data "aws_security_group" "tcw_sg" {
  filter {
    name = "tag:Name"
    values = ["tcw_security_group"]
  }
}
data "template_file" "user_data" {
  template = file("./user-data.sh")
}