################################################################################
# Autoscaling group
################################################################################

resource "aws_autoscaling_group" "autoscaling_group" {
  name = "asg-wilshan"
  vpc_zone_identifier = [for s in data.aws_subnet.subnet_id_each : s.id]

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  min_elb_capacity = var.min_elb_capacity
  launch_configuration = aws_launch_configuration.as_conf.name
}
