
# output "ec2_id" {
#   value = aws_instance.ec2[*].id
# }

# output "ec2_id" {
#   value = "${element(aws_instance.ec2.*.id, 2)}"
# }

output "ec2_id" {
  value = aws_instance.ec2[*].id
}