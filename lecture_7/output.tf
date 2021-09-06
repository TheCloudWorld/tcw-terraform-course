# output "subnet_ids" {
#   value = [for s in data.aws_subnet.subnet_id_each : s.id]
# }
output "name" {
  value = aws_launch_configuration.lc
}