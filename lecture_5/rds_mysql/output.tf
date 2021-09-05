output "subnet_data" {
  value = data.aws_subnet_ids.available_db_subnet.ids
}
output "rds_address" {
  value = aws_db_instance.db_instance.address
}
