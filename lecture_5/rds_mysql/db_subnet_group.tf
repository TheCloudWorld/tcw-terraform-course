###############################################################
## DB Subnet Group creation
###############################################################

resource "aws_db_subnet_group" "db_sub_group" {
  name       = "main"
  subnet_ids = data.aws_subnet_ids.available_db_subnet.ids
  tags = {
    Name = "My DB subnet group"
  }
}
