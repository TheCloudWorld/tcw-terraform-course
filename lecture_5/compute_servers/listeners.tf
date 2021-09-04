#####################################################################
## AWS Load Balancer Listener
#####################################################################

resource "aws_lb_listener" "alb_forward_listener" {
load_balancer_arn = aws_lb.tcw_alb.arn
port = "80"
protocol = "HTTP"
default_action {
type = "forward"
target_group_arn = aws_lb_target_group.tcw_tg.arn
}
}
