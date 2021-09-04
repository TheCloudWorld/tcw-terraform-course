#--------------------------------------------------------------------------##
# Data source
##--------------------------------------------------------------------------##
data "aws_vpc" "vpc_available" {
  filter {
    name   = "tag:Name"
    values = ["myVPC"]
  }
}
data "aws_subnet_ids" "available_db_subnet" {
  vpc_id = data.aws_vpc.vpc_available.id
  filter {
    name   = "tag:Name"
    values = ["database*"]
  }
}

data "aws_subnet" "subnet_id_each" {
  for_each = data.aws_subnet_ids.available_db_subnet.ids
  id       = each.value
}
