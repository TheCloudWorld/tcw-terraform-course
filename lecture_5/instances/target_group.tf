#####################################################################
## AWS Target Group
#####################################################################

resource "aws_lb_target_group" "ip_target" {
name = "wilshan-lb-tg"
port = 80
protocol = "HTTP"
target_type = "ip"
vpc_id = data.aws_vpc.default.id
}

#####################################################################
## AWS Target Group Attachment
#####################################################################

resource "aws_lb_target_group_attachment" "ping_attach_1" {
target_group_arn = aws_lb_target_group.ip_target.arn
target_id  = "10.0.4.32"
port = 22
availability_zone = "us-east-1a"
}

resource "aws_lb_target_group_attachment" "ping_attach_2" {
target_group_arn = aws_lb_target_group.ip_target.arn
target_id = "10.0.5.37"
port = 22
availability_zone = "us-east-1b"
}
