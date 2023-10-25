data "aws_elb_service_account" "root" {}

resource "aws_lb" "alb" {
  name               = "${var.naming_prefix}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg
  subnets            = var.subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "${var.naming_prefix}-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "redirect"
    
    redirect {
      port = "443"
      protocol = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = { Name = "${var.naming_prefix}-alb-http-listener" }
}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.icybox_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

# resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
#   count            = var.instance_count
#   target_group_arn = aws_lb_target_group.alb_tg.arn
#   target_id        = aws_instance.ec2[count.index].id
#   port             = 80
# }
