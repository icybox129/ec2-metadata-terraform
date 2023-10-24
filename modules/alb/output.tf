
# output "ec2_id" {
#   value = aws_instance.ec2[*].id
# }

# output "ec2_id" {
#   value = "${element(aws_instance.ec2.*.id, 2)}"
# }

# output "ec2_id" {
#   value = aws_instance.ec2[*].id
# }

output "alb_tg_arn" {
  value = aws_lb_target_group.alb_tg.arn
}

output "aws_alb_public_dns" {
  value       = "http://${aws_lb.alb.dns_name}"
  description = "Public DNS hostname for the application loadbalancer"
}