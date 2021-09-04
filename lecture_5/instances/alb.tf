resource "aws_lb" "my_alb" {
  name               = "my_alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["sg-09c854ea945de22ab"]
  subnets            = [for s in data.aws_subnet.subnet_id_each : s.id]
  enable_deletion_protection = false
  tags = {
    Environment = "production"
  }
}
