data "aws_elb_service_account" "root" {}

resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_sg
  subnets            = var.subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "alb_tg" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "alb_tg_attachment" {
  count = var.instance_count
  target_group_arn = aws_lb_target_group.alb_tg.arn
  target_id        = aws_instance.ec2[count.index].id
  port             = 80
}

# I THINK I NEED TO MERGE EC2 AND ALB INTO ONE MODULE