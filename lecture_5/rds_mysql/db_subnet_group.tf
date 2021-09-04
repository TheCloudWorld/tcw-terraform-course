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
    values = ["tcw_database*"]
  }
}

data "aws_subnet" "subnet_id_each" {
  for_each = data.aws_subnet_ids.available_db_subnet.ids
  id       = each.value
}

output "subnet_ids" {
  value = [for s in data.aws_subnet.subnet_id_each : s.id]
}


###############################################################
## DB Subnet Group creation
###############################################################

resource "aws_db_subnet_group" "db_sub_group" {
  name       = "main"
  subnet_ids = [for s in data.aws_subnet.subnet_id_each : s.id]

  tags = {
    Name = "My DB subnet group"
  }
}