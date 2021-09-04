#####################################################################
## AWS Load Balancer Listener
#####################################################################

resource "aws_lb_listener" "alb_forward_listener" {
load_balancer_arn = aws_lb.test.arn
port = "80"
protocol = "HTTP"
#ssl_policy = "ELBSecurityPolicy-2016-08"
certificate_arn = var.certificate_arn

default_action {
type = "forward"
target_group_arn = aws_lb_target_group.ip_target.arn
}
}
