################################################################################
# Autoscaling group
################################################################################

resource "aws_autoscaling_group" "autoscaling_group" {
  name = "tcw_autoscaling_group"
  vpc_zone_identifier = data.aws_subnet_ids.available_db_subnet.ids

  min_size         = var.min_size
  max_size         = var.max_size
  desired_capacity = var.desired_capacity
  launch_configuration = aws_launch_configuration.lc.name
  target_group_arns = [aws_lb_target_group.tcw_tg.arn]
  tag {
    key = "Name"
    value = "tcw-wordpress-app-server"
    propagate_at_launch = true
  }

  depends_on = [
    aws_lb_target_group.tcw_tg
  ]
}