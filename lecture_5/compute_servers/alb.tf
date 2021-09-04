resource "aws_lb" "tcw_alb" {
  name               = "tcw-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.tcw_sg.id]

  # At least two subnets on different AZ must be specified
  subnets            = [for s in data.aws_subnet.subnet_id_each : s.id]
  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}
